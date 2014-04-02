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
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	
	import mx.core.mx_internal;
	
	import starling.events.Event;
	
	public class MultiplayerScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var btnCreate:Button;
		private var btnMulti:Button;
		private var btnLan:Button;
		
		private var btnBack:Button;
		
		public function MultiplayerScreen()
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
			
			btnCreate = new Button();
			btnCreate.label = "Create Game!";
			btnCreate.addEventListener(Event.TRIGGERED, btnCreateClickHandler);
			group.addChild(btnCreate);
			
			btnMulti = new Button();
			btnMulti.label = "Join Game!";
			btnMulti.addEventListener(Event.TRIGGERED, btnJoinClickHandler);
			group.addChild(btnMulti);
			
			btnLan = new Button();
			btnLan.label = "Local Network";
			btnLan.addEventListener(Event.TRIGGERED, btLanClickHandler);
			group.addChild(btnLan);
			
			group.validate();
			group.y = (stage.stageHeight - group.height)/2;
			group.x = (stage.stageWidth - group.width)/2;
			
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
			owner.showScreen(SCREEN.mainMenu);
		}
		
		private function btLanClickHandler():void
		{
			Match.init();
			ConnectionManager.connectLocal();
			owner.showScreen(SCREEN.room);			
		}
		
		private function btnJoinClickHandler():void
		{
			Match.init();
			WaitingScreen.isServer = false;
			owner.showScreen(SCREEN.waiting);
			ConnectionManager.joinHotspot();
		}
		
		private function btnCreateClickHandler():void
		{
			Match.init();
			WaitingScreen.isServer = true;
			owner.showScreen(SCREEN.waiting);
			ConnectionManager.createHotspot();
		}
		
	}
}