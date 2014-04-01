package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.SCREEN;
	
	import spark.containers.NavigatorGroup;
	
	import starling.events.Event;
	
	public class SettingsScreen extends Screen
	{
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var playerGroup:LayoutGroup;
		private var playerLayout:HorizontalLayout;
		
		private var lblPlayerName:Label;
		private var txtPlayerName:TextInput;
		private var btnSave:Button;
		private var btnBack:Button;
		
		public function SettingsScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			group = new LayoutGroup();
			playerGroup = new LayoutGroup();
			
			lblPlayerName = new Label;
			lblPlayerName.text = "player name:";
			playerGroup.addChild(lblPlayerName);
			
			txtPlayerName = new TextInput();
			txtPlayerName.text = ANE.info.loadPlayerName();
			playerGroup.addChild(txtPlayerName);
			
			playerLayout = new HorizontalLayout();
			playerGroup.layout = playerLayout;
			playerLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_BOTTOM;
			group.addChild(playerGroup);
			
			layout = new VerticalLayout();
			group.layout = layout;
			layout.gap = stage.stageHeight / 15;
			this.addChild(group);
			group.validate();
			group.y = (stage.stageHeight - group.height)/2;
			group.x = (stage.stageWidth - group.width)/2;
			
			
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
			
			btnSave = new Button();
			btnSave.label = "Save Settings";
			btnSave.addEventListener(Event.TRIGGERED, btnSaveClickHandler);
			this.addChild(btnSave);
			btnSave.validate();
			btnSave.x = stage.stageWidth - (btnSave.width + stage.stageWidth/100);
			btnSave.y = stage.stageHeight - (btnSave.height + stage.stageHeight/100);
		}
		
		private function btnBackClickHandler():void
		{
			owner.showScreen(SCREEN.mainMenu);
		}
		
		private function btnSaveClickHandler():void
		{
			ANE.info.savePlayerName(txtPlayerName.text);
			owner.showScreen(SCREEN.mainMenu);
		}
	}
}