package ir.baazino.mytank.screen
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.Notifier;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Lobby;
	
	import starling.events.Event;
	
	public class MainMenuScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var btnSingle:Button;
		private var btnMulti:Button;
		private var btnOnline:Button;
		private var btnSettings:Button;
		private var btnUpgrade:Button;
		
		public function MainMenuScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.backButtonHandler = btnBackClickHandler;
			ANE.purchase.addEventListener(StatusEvent.STATUS, onPurchaseStatus);
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
			
			btnSingle = new Button();
			btnSingle.label = "SinglePlayer";
			btnSingle.addEventListener(Event.TRIGGERED, btnSingleClickHandler);
			group.addChild(btnSingle);
			
			btnOnline = new Button();
			btnOnline.label = "Play Online";
			btnOnline.addEventListener(Event.TRIGGERED, btnOnlineClickHandler);
			group.addChild(btnOnline);
			
			btnMulti = new Button();
			btnMulti.label = "MultiPlayer";
			btnMulti.addEventListener(Event.TRIGGERED, btnMultiClickHandler);
			group.addChild(btnMulti);
			
			btnSettings = new Button();
			btnSettings.label = "Settings";
			btnSettings.addEventListener(Event.TRIGGERED, btnSettingsClickHandler);
			group.addChild(btnSettings);
			
			group.validate();
			group.y = (stage.stageHeight - group.height)/2;
			group.x = (stage.stageWidth - group.width)/2;
			
			btnUpgrade = new Button();
			btnUpgrade.label = "Upgrade";
			btnUpgrade.addEventListener(Event.TRIGGERED, btnUpgradeClickHandler);
			this.addChild(btnUpgrade);
			btnUpgrade.validate();
			btnUpgrade.y = stage.stageHeight / 20;
			btnUpgrade.x = stage.stageWidth - (btnUpgrade.width + stage.stageWidth / 20);
		}
		

		protected function onPurchaseStatus(event:StatusEvent):void
		{
			var alert:Alert = Alert.show(event.code, "Alert", new ListCollection(
				[
					{ label: "OK"},
				]) );
		}
		
		private function btnUpgradeClickHandler():void
		{
			ANE.purchase.init();
		}

		private function btnOnlineClickHandler():void
		{
			Lobby.init();
			owner.showScreen(SCREEN.LOBBY);
		}
		
		private function btnSingleClickHandler():void
		{
			owner.showScreen(SCREEN.SINGLE_PLAYER);
		}
		
		private function btnMultiClickHandler():void
		{
			owner.showScreen(SCREEN.MULTI_PLAYER);
		}
		
		private function btnSettingsClickHandler():void
		{
			owner.showScreen(SCREEN.SETTINGS);
		}
		
		private function btnBackClickHandler():void
		{
			MyTank.exitGame();
		}
	}
}