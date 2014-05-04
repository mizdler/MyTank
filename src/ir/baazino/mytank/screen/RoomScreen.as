package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.layout.HorizontalLayout;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.DragDropList;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Match;
	
	import starling.events.Event;
	
	public class RoomScreen extends Screen
	{
		private var teamGroup:LayoutGroup;
		private var teamLayout:HorizontalLayout;
		
		private var redList:DragDropList;
		private var noneList:DragDropList;
		private var blueList:DragDropList;
		
		private var btnStart:Button;
		private var btnBack:Button;
		
		public function RoomScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.backButtonHandler = btnCancelClickHandler;
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
			
			redList = new DragDropList();
			redList.width = stage.stageWidth/4;
			redList.height = stage.stageHeight/2;
			redList.dataProvider = Match.redCollection;
			redList.itemRendererProperties.labelField = "playerName";
			teamGroup.addChild(redList);
			
			noneList = new DragDropList();
			noneList.width = stage.stageWidth/4;
			noneList.height = stage.stageHeight/2;
			noneList.dataProvider = Match.noneCollection;
			noneList.itemRendererProperties.labelField = "playerName";
			teamGroup.addChild(noneList);
			
			blueList = new DragDropList();
			blueList.width = stage.stageWidth/4;
			blueList.height = stage.stageHeight/2;
			blueList.dataProvider = Match.blueCollection;
			blueList.itemRendererProperties.labelField = "playerName";
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
			btnBack.label = "cancel";
			btnBack.addEventListener(Event.TRIGGERED, btnCancelClickHandler);
			this.addChild(btnBack);
			btnBack.validate();
			btnBack.x = stage.stageWidth / 100;
			btnBack.y = stage.stageHeight - (btnBack.height + stage.stageHeight/100);
		}
		
		private function btnStartClickHandler():void
		{
			ConnectionManager.sendMsg(CMD.START + "#" + Match.myId);
			owner.showScreen(SCREEN.GAME);
		}
		
		private function btnCancelClickHandler():void
		{
			ConnectionManager.closeRTMFP();
			owner.showScreen(SCREEN.MULTI_PLAYER);
		}
	}
}