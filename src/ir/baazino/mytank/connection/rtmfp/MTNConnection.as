package ir.baazino.mytank.connection.rtmfp
{
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroupSendMode;
	import flash.net.sendToURL;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;

	public class MTNConnection extends NetConnection
	{
		private var groupSpecifier:GroupSpecifier;
		private var isLocal:Boolean;
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
			trace(Match.noneCollection, Match.noneCollection.data, Match.noneCollection.length);
			var code:String = event.info.code;
			switch(code)
			{
				case "NetConnection.Connect.Success":
					joinGroup(ConnectionConfig.GROUP_NAME);
					break;
				case "NetGroup.Connect.Success":
					var me:Actor = new Actor();
					Match.myId = mGroup.convertPeerIDToGroupAddress(nearID);
					me.name = ANE.info.loadPlayerName();
					Match.playerMap[Match.myId] = me;
					
					var item:Object = new Object();
					item.id = Match.myId;
					item.name = me.name;
					Match.noneCollection.addItem(item);
					
					mGroup.post(CMD.join + "#" + Match.myId + "#" + me.name);
					break;
				case "NetGroup.Neighbor.Connect":
					mGroup.post(CMD.join + "#" + Match.myId + "#" + (Match.playerMap[Match.myId] as Actor).name);
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
				case CMD.update:
					actor = Match.playerMap[id] as Actor;
					actor.x = splited[2];
					actor.y = splited[3];
					actor.rotation = splited[4];
					actor.isMoving = splited[5]=="true"?true:false;
					actor.shoot = splited[6]=="true"?true:false;
					break;
				
				case CMD.join:
					actor = new Actor();
					actor.name = splited[2];
					Match.playerMap[id] = actor;
					
					var item:Object = new Object();
					item.id = id;
					item.name = actor.name;
					Match.noneCollection.addItem(item);
					break;
				
				case CMD.start:
					Starter.navigator.showScreen(SCREEN.game);
			}
		}
		
		public function sendMsg(msg:String):void
		{
			mGroup.sendToAllNeighbors(msg);
		}
		
		public function closeRTMFP():void
		{
			if(mGroup)
				mGroup.close();
			this.close();
		}
		
	}
	
}