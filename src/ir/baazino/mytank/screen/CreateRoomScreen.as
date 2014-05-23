package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.layout.TiledRowsLayout;
	
	import flash.net.Responder;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.SERVER_FUNCTION;
	import ir.baazino.mytank.info.Match;
	
	import mx.states.AddChild;
	
	import starling.events.Event;
	
	public class CreateRoomScreen extends Screen
	{
		private var mPanel:Panel;
		private var layout:TiledRowsLayout;
		private var lblRoomName:Label;
		private var txtRoomName:TextInput;
		private var lblPassword:Label;
		private var txtPassword:TextInput;
		private var lblMaxPlayer:Label;
		private var txtMaxPlayer:TextInput;
		private var btnCreate:Button;
		private var btnBack:Button;
		
		public function CreateRoomScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHander);
		}
		
		private function addToStageHander():void
		{
			mPanel = new Panel();
			layout = new TiledRowsLayout();
			layout.useSquareTiles = false;
			mPanel.layout = layout;
			
			lblRoomName = new Label();
			lblRoomName.text = "Room's Name";
			mPanel.addChild(lblRoomName);
			
			txtRoomName = new TextInput();
			mPanel.addChild(txtRoomName);
			
			lblPassword = new Label();
			lblPassword.text = "Password";
			mPanel.addChild(lblPassword);
			
			txtPassword = new TextInput();
			mPanel.addChild(txtPassword);
			
			lblMaxPlayer = new Label();
			lblMaxPlayer.text = "Max Players";
			mPanel.addChild(lblMaxPlayer);
			
			txtMaxPlayer = new TextInput();
			txtMaxPlayer.text = "6";
			mPanel.addChild(txtMaxPlayer);
			
			btnCreate = new Button();
			btnCreate.label = "Create";
			btnCreate.addEventListener(Event.TRIGGERED, btnCreateClickHandler);
			mPanel.addChild(btnCreate);
			
			this.addChild(mPanel);
			mPanel.validate();
			mPanel.x = (stage.stageWidth - mPanel.width)/2;
			mPanel.y = (stage.stageHeight - mPanel.height)/2;
			
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.name = Button.ALTERNATE_NAME_BACK_BUTTON;
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
		}
		
		private function btnBackClickHandler():void
		{
			owner.showScreen(SCREEN.LOBBY);
		}
		
		private function btnCreateClickHandler():void
		{
			ConnectionManager.mConnection.call(SERVER_FUNCTION.ADD_ROOM, new Responder(addRoomHandler), txtRoomName.text, Match.myId, txtPassword.text, txtMaxPlayer.text);
			ConnectionManager.isServer = true;
			Match.init(Match.multi);
			owner.showScreen(SCREEN.ROOM);
		}
		
		private function addRoomHandler(msg:String):void
		{
			ConnectionManager.mConnection.joinGroup(msg);		
		}
	}
}