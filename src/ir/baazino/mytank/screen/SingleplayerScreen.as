package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;

	public class SingleplayerScreen extends Screen
	{
		private var btnBack:Button;
		private var btnStart:Button;
		
		public function SingleplayerScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.name = Button.ALTERNATE_NAME_BACK_BUTTON;
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
			
			btnStart = new Button();
			btnStart.label = "Start Game!";
			btnStart.name = Button.ALTERNATE_NAME_FORWARD_BUTTON;
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			this.addChild(btnStart);
			btnStart.validate();
			btnStart.x = stage.stageWidth - (btnStart.width + stage.stageWidth/100);
			btnStart.y = stage.stageHeight - (btnStart.height + stage.stageHeight/100);
		}
		
		private function btnStartClickHandler():void
		{
			Match.myId = ConnectionManager.SERVER_ID;
			Match.playerMap[Match.myId] = new Actor();
			owner.showScreen(SCREEN.game);
		}
		
		private function btnBackClickHandler():void
		{
			owner.showScreen(SCREEN.mainMenu);
		}
	}
}