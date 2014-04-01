package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import mx.core.mx_internal;
	
	import starling.events.Event;
	
	public class MainMenuScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var btnStart:Button;
		private var btnCreate:Button;
		private var btnJoin:Button;
		private var btnSettings:Button;
		
		public function MainMenuScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			group = new LayoutGroup();
			layout = new VerticalLayout();
			group.layout = layout;
			layout.gap = stage.stageHeight / 15;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.addChild(group);
			
			btnStart = new Button();
			btnStart.label = "Start Game!";
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			group.addChild(btnStart);
			
			btnCreate = new Button();
			btnCreate.label = "Create Game!";
			btnCreate.addEventListener(Event.TRIGGERED, btnCreateClickHandler);
			group.addChild(btnCreate);
			
			btnJoin = new Button();
			btnJoin.label = "Join Game!";
			btnJoin.addEventListener(Event.TRIGGERED, btnJoinClickHandler);
			group.addChild(btnJoin);
			
			btnJoin = new Button();
			btnJoin.label = "Settings";
			btnJoin.addEventListener(Event.TRIGGERED, btnSettingsClickHandler);
			group.addChild(btnJoin);
			
			
			group.validate();
			group.y = (stage.stageHeight - group.height)/2;
			group.x = (stage.stageWidth - group.width)/2;
		}
		
		private function btnSettingsClickHandler():void
		{
			owner.showScreen(SCREEN.settings);
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
			ConnectionManager.sendTCP(CMD.start + "#" + Match.myId);
			owner.showScreen(SCREEN.game);
		}
	}
}