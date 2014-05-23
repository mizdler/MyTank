package ir.baazino.mytank.screen
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import flash.events.StatusEvent;
	import flash.net.Responder;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.connection.rtmfp.MTNConnection;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.Notifier;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.SERVER_FUNCTION;
	import ir.baazino.mytank.info.Lobby;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class LobbyScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var roomList:List;
		private var btnBack:Button;
		private var btnJoin:Button;
		private var btnCreate:Button;
		
		private var alert:Alert;
		
		public function LobbyScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			alert = Alert.show( "connecting to server...", "please wait", new ListCollection(
				[
					{ label: "cancel", triggered: connectionCanceledHandler }
					
				]) );
			ConnectionManager.connectOnline();
			ConnectionManager.mConnection.addEventListener("CONNECTION", connectinEventHandler);
			
			roomList = new List();
			roomList.width = stage.stageWidth/3;
			roomList.height = stage.stageHeight/2;
			roomList.dataProvider = Lobby.roomCollection;
			roomList.itemRendererProperties.labelField = "roomName";
			this.addChild(roomList);
			roomList.validate();
			roomList.x = (stage.stageWidth - roomList.width)/2;
			roomList.y = (stage.stageHeight - roomList.height)/2;
			
			group = new LayoutGroup();
			layout = new VerticalLayout();
			group.layout = layout;
			layout.gap = stage.stageHeight / 15;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.addChild(group);
			
			btnJoin = new Button();
			btnJoin.label = "Join Room";
			btnJoin.addEventListener(Event.TRIGGERED, btnJoinClickHandler);
			group.addChild(btnJoin);
			
			btnCreate = new Button();
			btnCreate.label = "Create Room";
			btnCreate.addEventListener(Event.TRIGGERED, btnCreateClickHnadler);
			group.addChild(btnCreate);
			
			group.validate();
			group.x = roomList.x + roomList.width + stage.stageWidth/20;
			group.y = roomList.y;
			
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.name = Button.ALTERNATE_NAME_BACK_BUTTON;
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
		}
		
		protected function connectinEventHandler(event:StatusEvent):void
		{
			if(event.code == "success")
			{
				if(alert)
					stage.removeChild(alert, true);
				ConnectionManager.mConnection.call(SERVER_FUNCTION.GET_PLAYER_ID, new Responder(getPlayerId));
				ConnectionManager.mConnection.call(SERVER_FUNCTION.GET_ROOMS_NAME, new Responder(getRoomsNameHandler));
			}
		}
		
		private function connectionCanceledHandler():void
		{
			
		}
		
		private function btnCreateClickHnadler():void
		{
			owner.showScreen(SCREEN.CREATE_ROOM);
		}
		
		private function btnJoinClickHandler():void
		{
			var pass:String = "";
			ConnectionManager.mConnection.call(SERVER_FUNCTION.JOIN_ROOM, new Responder(joinRoomHandler), Number(roomList.selectedItem.roomId), Match.myId, pass);
		}	
		
		
		public function getPlayerId(msg:String):void
		{
			Match.myId = msg.split(",")[0];
			Lobby.playersNumber = Number(msg.split(",")[1]);
		}
		
		private function getRoomsNameHandler(msg:String):void
		{
			var rooms:Array = new Array();
			rooms = msg.split("@_!,");
			for(var x:String in rooms)
				if(rooms[x] != ""){
					var words:Array = new Array();
					words = rooms[x].split("$#_^");
					var room:Object = new Object();
					room.roomId = Number(words[0]);
					room.roomName =  words[1];
					room.maxPlayers = (words[2] + '/' + words[3]).toString();
					room.pass = words[4];
					Lobby.roomCollection.addItem(room);
				}
		}
		
		private function joinRoomHandler(msg:String):void
		{
			if(msg == "-2"){
				alert = Alert.show("The room is not exist anymore!", "Alert", new ListCollection(
					[
						{label: "I got it!"}
						
					]) );
			}
			else if(msg == "-1"){
				alert = Alert.show("Password is wrong, try again", "Alert", new ListCollection(
					[
						{label: "I got it!"}
						
					]) );
			}
			else{
				ConnectionManager.mConnection.joinGroup(roomList.selectedItem.roomId);
				var hostId:Number = Number(msg);
				Match.init(Match.multi);
				owner.showScreen(SCREEN.ROOM);
			}
		}
		
		private function btnBackClickHandler():void
		{
			ConnectionManager.closeRTMFP();
			owner.showScreen(SCREEN.MAIN_MENU);
		}		
	}
}