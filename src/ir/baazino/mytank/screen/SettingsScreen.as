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
		
		private var navGroup:LayoutGroup;
		private var navLayout:HorizontalLayout;
		
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
			
			
			navGroup = new LayoutGroup();
			
			btnBack = new Button();
			btnBack.label = "back";
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			navGroup.addChild(btnBack);
			
			btnSave = new Button();
			btnSave.label = "Save";
			btnSave.addEventListener(Event.TRIGGERED, btnSaveClickHandler);
			navGroup.addChild(btnSave);
			
			navLayout = new HorizontalLayout();
			navGroup.layout = navLayout;
			navLayout.padding = stage.stageHeight/100;
			this.addChild(navGroup);
			navGroup.validate();
			navGroup.y = stage.stageHeight - navGroup.height;
			navLayout.gap = stage.width - (btnBack.width + 2*btnSave.width); 
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