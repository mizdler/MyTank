package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class MainMenuScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var btnSingle:Button;
		private var btnMulti:Button;
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
			
			btnSingle = new Button();
			btnSingle.label = "SinglePlayer";
			btnSingle.addEventListener(Event.TRIGGERED, btnSingleClickHandler);
			group.addChild(btnSingle);
			
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
		}
		
		private function btnSettingsClickHandler():void
		{
			owner.showScreen(SCREEN.SETTINGS);
		}
		
		private function btnMultiClickHandler():void
		{
			owner.showScreen(SCREEN.MULTI_PLAYER);
		}
		
		private function btnSingleClickHandler():void
		{
			owner.showScreen(SCREEN.SINGLE_PLAYER);
		}
	}
}