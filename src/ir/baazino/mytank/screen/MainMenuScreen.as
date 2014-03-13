package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import mx.core.mx_internal;
	
	import starling.events.Event;
	
	public class MainMenuScreen extends Screen
	{
		private var btnStart:Button;
		private var btnCreate:Button;
		private var btnJoin:Button;
		
		public function MainMenuScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			btnStart = new Button();
			btnStart.label = "Start Game!";
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			addChild(btnStart);
			btnStart.validate();
			btnStart.x = (stage.stageWidth - btnStart.width)/2;
			btnStart.y = (stage.stageHeight/2 - btnStart.height*2);
			
			btnCreate = new Button();
			btnCreate.label = "Create Game!";
			btnCreate.addEventListener(Event.TRIGGERED, btnCreateClickHandler);
			addChild(btnCreate);
			btnCreate.validate();
			btnCreate.x = (stage.stageWidth - btnCreate.width)/2;
			btnCreate.y = stage.stageHeight/2;
			
			btnJoin = new Button();
			btnJoin.label = "Join Game!";
			btnJoin.addEventListener(Event.TRIGGERED, btnJoinClickHandler);
			addChild(btnJoin);
			btnJoin.validate();
			btnJoin.x = (stage.stageWidth - btnJoin.width)/2;
			btnJoin.y = stage.stageHeight/2 + btnJoin.height*2;
		}
		
		private function btnJoinClickHandler():void
		{
			ConnectionManager.joinHotspot();
		}
		
		private function btnCreateClickHandler():void
		{
			ConnectionManager.createHotspot();
		}
		
		private function btnStartClickHandler():void
		{
			ConnectionManager.sendTCP(CMD.start + "/" + Match.myId);
			owner.showScreen(SCREEN.game);
		}
	}
}