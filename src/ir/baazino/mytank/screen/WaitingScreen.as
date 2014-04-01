package ir.baazino.mytank.screen
{
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	
	import starling.events.Event;
	
	public class WaitingScreen extends Screen
	{
		public static var textLog:StageTextTextEditor;
		
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
		}
	}
}