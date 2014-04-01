package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import ir.baazino.mytank.helper.SCREEN;
	
	import starling.events.Event;

	public class SingleplayerScreen extends Screen
	{
		private var btnBack:Button;
		
		public function SingleplayerScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
		}
		
		private function btnBackClickHandler():void
		{
			owner.showScreen(SCREEN.mainMenu);
		}
	}
}