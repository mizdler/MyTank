package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class WaitingScreen extends Screen
	{
		public static var textLog:StageTextTextEditor;
		private var btnStart:Button;
		
		public function WaitingScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
			
			if(ConnectionManager.isServer)
			{
				btnStart = new Button();
				btnStart.label = "Start Game!";
				btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
				this.addChild(btnStart);
				btnStart.validate();
				btnStart.x = stage.stageWidth - (btnStart.width + stage.stageWidth/100);
				btnStart.y = stage.stageHeight - (btnStart.height + stage.stageHeight/100);
			}
		}
		
		private function btnStartClickHandler():void
		{
			ConnectionManager.sendTCP(CMD.start + "#" + Match.myId);
			owner.showScreen(SCREEN.game);
		}
	}
}