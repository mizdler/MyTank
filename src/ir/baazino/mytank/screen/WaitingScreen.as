package ir.baazino.mytank.screen
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.data.ListCollection;
	
	import flash.events.StatusEvent;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.Notifier;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class WaitingScreen extends Screen
	{
		public static var isServer:Boolean;
		public static var textLog:StageTextTextEditor;
		
		private var btnStart:Button;
		private var btnCancel:Button;
		
		public function WaitingScreen()
		{
			super();
			ConnectionManager.dispatcher.addEventListener("CONNECTION", connectionListener);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.backButtonHandler = btnCancelClickHandler;
		}
		
		protected function connectionListener(event:StatusEvent):void
		{
			var alert:Alert = Alert.show(event.code, "Alert", new ListCollection(
				[
					{label: "OK"}
				]) );
		}
		
		private function addedToStageHandler():void
		{
			textLog = new StageTextTextEditor();
			textLog.multiline = true;
			textLog.isEditable = false;
			textLog.width = stage.stageWidth;
			textLog.height = stage.stageHeight;
			addChild(textLog);
			textLog.validate();
			textLog.y = 0;
			textLog.x = 0;
			
			if(isServer)
			{
				btnStart = new Button();
				btnStart.label = "Start Game!";
				btnStart.name = Button.ALTERNATE_NAME_FORWARD_BUTTON;
				btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
				this.addChild(btnStart);
				btnStart.validate();
				btnStart.x = stage.stageWidth - (btnStart.width + stage.stageWidth/100);
				btnStart.y = stage.stageHeight - (btnStart.height + stage.stageHeight/100);
			}
			
			btnCancel = new Button();
			btnCancel.name = Button.ALTERNATE_NAME_BACK_BUTTON;
			btnCancel.label = "cancel";
			btnCancel.addEventListener(Event.TRIGGERED, btnCancelClickHandler);
			this.addChild(btnCancel);
			btnCancel.validate();
			btnCancel.x = stage.stageWidth / 100;
			btnCancel.y = stage.stageHeight - (btnCancel.height + stage.stageHeight/100);
		}
		
		private function btnCancelClickHandler():void
		{
			owner.showScreen(SCREEN.MULTI_PLAYER);
		}
		
		private function btnStartClickHandler():void
		{
			ConnectionManager.sendMsg(CMD.START + "#" + Match.myId);
			owner.showScreen(SCREEN.GAME);
		}
	}
}