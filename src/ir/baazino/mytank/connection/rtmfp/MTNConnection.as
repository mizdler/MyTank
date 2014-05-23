package ir.baazino.mytank.connection.rtmfp
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroupSendMode;
	import flash.net.Responder;
	import flash.net.sendToURL;
	import flash.utils.ByteArray;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.Storage;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Lobby;
	import ir.baazino.mytank.info.Match;

	public class MTNConnection extends NetConnection
	{
		public var isLocal:Boolean;
		
		private var groupSpecifier:GroupSpecifier;
		private var mGroup:MTNGroup;
		private var serverAddr:String;
		
		public function MTNConnection(_isLocal:Boolean)
		{
			this.isLocal = _isLocal;
			this.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			
			if(isLocal)
				serverAddr = ConnectionConfig.LOCAL_ADDR;
			else
				serverAddr = ConnectionConfig.ONLINE_ADDR;
		}
		
		public function connectNet():void
		{
			connect(serverAddr);
		}
		public function exitRoom():void
		{
			mGroup.close();
		}
		
		// push functions
		
		public function pushPlayersNumber(msg:String):void
		{
			Lobby.playersNumber = Number(msg);
		}
		
		public function pushAddRoomList(msg:String):void
		{
			var words:Array = new Array();
			words = msg.split("$#_^");
			var room:Object = new Object();
			room.roomId = Number(words[0]);
			room.roomName =  words[1];
			room.maxPlayers = words[2] + '/' + words[3];
			room.pass = words[4];
			Lobby.roomCollection.addItem(room);
		}
		
		public function pushDeleteRoomList(msg:String):void
		{
			for (var i:Number=0; i<Lobby.roomCollection.length; i++)
				if(Lobby.roomCollection.getItemAt(i).roomId == msg)
					Lobby.roomCollection.removeItemAt(i);
		}
		
		public function pushJoinRoomList(msg:String):void
		{
			for (var i:Number=0; i<Lobby.roomCollection.length; i++)
				if(Lobby.roomCollection.getItemAt(i).roomId == msg)
				{
					var room:Object = Lobby.roomCollection.getItemAt(i)
					room.maxPlayers = (Number(room.maxPlayers.split("/")[0]) - 1).toString() + '/' + room.maxPlayers.split("/")[1];
				}
		}
		
		public function pushExitRoomList(msg:String):void
		{
			for (var i:Number=0; i<Lobby.roomCollection.length; i++)
				if(Lobby.roomCollection.getItemAt(i).roomId == msg)
				{
					var room:Object = Lobby.roomCollection.getItemAt(i)
					room.maxPlayers = (Number(room.maxPlayers.split("/")[0]) + 1).toString() + '/' + room.maxPlayers.split("/")[1];
				}
		}
		
		// end of push functions
		
		
		public function joinGroup(groupName:String):void
		{
			groupSpecifier = new GroupSpecifier(groupName);
			groupSpecifier.serverChannelEnabled = true;
			groupSpecifier.multicastEnabled = true;
			groupSpecifier.ipMulticastMemberUpdatesEnabled = true;
			groupSpecifier.postingEnabled = true;
			groupSpecifier.routingEnabled = true;
			if(isLocal)
				groupSpecifier.addIPMulticastAddress(ConnectionConfig.MULTICAST_ADDR);
			
			var groupspec:String = groupSpecifier.groupspecWithAuthorizations();
			mGroup = new MTNGroup(this, groupspec);
			mGroup.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			var code:String = event.info.code;
			switch(code)
			{
				case "NetConnection.Connect.Success":
					if(isLocal)
						joinGroup(ConnectionConfig.GROUP_NAME);
					else
						dispatchEvent(new StatusEvent("CONNECTION", false, false, "success"));
					
					break;
				case "NetGroup.Connect.Success":
					var me:Actor = new Actor();
					if(isLocal)
						Match.myId = mGroup.convertPeerIDToGroupAddress(nearID);
					me.playerName = Storage.loadPlayerName();
					me.avatar = Storage.loadAvatar();
					Match.playerMap[Match.myId] = me;
					
					var item:Object = new Object();
					item.id = Match.myId;
					item.playerName = me.playerName;
					item.byteAvatar = me.avatar;
					Match.noneCollection.push(item);
					dispatchEvent(new StatusEvent("UPDATE", false, false, "avatars"));
					
					var r1:String = mGroup.post(CMD.JOIN + "#" + Match.myId + "#" + me.playerName + "#" + "");
					if(!r1)
						trace("POST ERROR");
					break;
				case "NetGroup.Neighbor.Connect":
					me = Match.playerMap[Match.myId];
					var r2:String = mGroup.post(CMD.JOIN + "#" + Match.myId + "#" + me.playerName + "#" + "");
					if(!r2)
						trace("POST ERROR");
					break;
				case "NetGroup.Posting.Notify":
					receiveNeighbor(event.info.message);
					break;
				case "NetGroup.SendTo.Notify":
					receiveNeighbor(event.info.message);
					break;
				case "NetGroup.Neighbor.Disconnect":
					var id:String = event.info.neighbor;
					for each(var o:Object in Match.noneCollection.data)
						if(o.id == id)
							Match.noneCollection.removeItem(o);
					
					Match.playerMap[event.info.neighbor] = null;
					break;
			}
		}
		private function receiveNeighbor(msg:String):void
		{
			var splited:Array = msg.split("#");
			var cmd:String = splited[0];
			var id:String = splited[1];
			var actor:Actor;
			
			switch(cmd)
			{
				case CMD.UPDATE:
					actor = Match.playerMap[id] as Actor;
					actor.x = splited[2];
					actor.y = splited[3];
					actor.rotation = splited[4];
					actor.isMoving = splited[5]=="true"?true:false;
					actor.shoot = splited[6]=="true"?true:false;
					break;
				
				case CMD.JOIN:
					actor = new Actor();
					actor.playerName = splited[2];
					Match.playerMap[id] = actor;
					
					if(splited[3] != "")
					{
						var bArray:ByteArray = new ByteArray();
						bArray.writeUTF(splited[3]);
						actor.avatar = bArray;
					}
					
					var item:Object = new Object();
					item.id = id;
					item.playerName = actor.playerName;
					Match.noneCollection.addItem(item);
					dispatchEvent(new StatusEvent("UPDATE", false, false, "avatars"))
					break;
				
				case CMD.START:
					Starter.navigator.showScreen(SCREEN.GAME);
			}
		}
		
		public function sendMsg(msg:String):void
		{
			mGroup.sendToAllNeighbors(msg);
		}
		
	}
	
}