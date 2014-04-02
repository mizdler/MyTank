package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.layout.HorizontalLayout;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class RoomScreen extends Screen
	{
		private var teamGroup:LayoutGroup;
		private var teamLayout:HorizontalLayout;
		
		private var redList:List;
		private var noneList:List;
		private var blueList:List;
		
		private var btnStart:Button;
		private var btnBack:Button;
		
		public function RoomScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			teamGroup = new LayoutGroup();
			teamLayout = new HorizontalLayout();
			teamLayout.gap = 50;
			teamGroup.layout = teamLayout;
			teamLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			teamLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.addChild(teamGroup);
			
			redList = new List();
			redList.dataProvider = Match.redCollection;
			redList.itemRendererProperties.labelField = "name";
			teamGroup.addChild(redList);
			
			noneList = new List();
			noneList.dataProvider = Match.noneCollection;
			noneList.itemRendererProperties.labelField = "name";
			teamGroup.addChild(noneList);
			
			blueList = new List();
			blueList.dataProvider = Match.blueCollection;
			blueList.itemRendererProperties.labelField = "name";
			teamGroup.addChild(blueList);
			
			teamGroup.validate();
			teamGroup.y = (stage.stageHeight - teamGroup.height)/2;
			teamGroup.x = (stage.stageWidth - teamGroup.width)/2;
			
			btnStart = new Button();
			btnStart.label = "Start Game!";
			btnStart.name = Button.ALTERNATE_NAME_FORWARD_BUTTON;
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			this.addChild(btnStart);
			btnStart.validate();
			btnStart.x = stage.stageWidth - (btnStart.width + stage.stageWidth/100);
			btnStart.y = stage.stageHeight - (btnStart.height + stage.stageHeight/100);
			
			btnBack = new Button();
			btnBack.name = Button.ALTERNATE_NAME_BACK_BUTTON;
			btnBack.label = "back";
			btnBack.addEventListener(Event.TRIGGERED, btnBackClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
		}
		
		private function btnStartClickHandler():void
		{
			ConnectionManager.sendMsg(CMD.start + "#" + Match.myId);
			owner.showScreen(SCREEN.game);
		}
		
		private function btnBackClickHandler():void
		{
			ConnectionManager.closeRTMFP();
			owner.showScreen(SCREEN.multiPlayer);
		}
	}
}