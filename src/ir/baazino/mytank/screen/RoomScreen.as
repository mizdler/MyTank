package ir.baazino.mytank.screen
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.dragDrop.DragData;
	import feathers.events.DragDropEvent;
	import feathers.layout.HorizontalLayout;
	
	import flash.display.Loader;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.DragDropList;
	import ir.baazino.mytank.helper.ImageHelper;
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
			ConnectionManager.mConnection.addEventListener("UPDATE", updateHandler);
			this.backButtonHandler = btnCancelClickHandler;
		}
		
		protected function updateHandler(event:Object):void
		{
			var item:Object;
			for each(item in Match.noneCollection.data)
			{
				setAvatar(item);
			}
			for each(item in Match.blueCollection.data)
				setAvatar(item);
			for each(item in Match.redCollection.data)
				setAvatar(item);
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
			redList.itemRendererProperties.iconSourceField = "avatar";
			redList.addEventListener(DragDropEvent.DRAG_DROP, dropRedEventHandler);
			teamGroup.addChild(redList);
			
			noneList = new DragDropList();
			noneList.width = stage.stageWidth/4;
			noneList.height = stage.stageHeight/2;
			noneList.dataProvider = Match.noneCollection;
			noneList.itemRendererProperties.labelField = "playerName";
			noneList.itemRendererProperties.iconSourceField = "avatar";
			noneList.addEventListener(DragDropEvent.DRAG_DROP, dropNoneEventHandler);
			teamGroup.addChild(noneList);
			
			blueList = new DragDropList();
			blueList.width = stage.stageWidth/4;
			blueList.height = stage.stageHeight/2;
			blueList.dataProvider = Match.blueCollection;
			blueList.itemRendererProperties.labelField = "playerName";
			blueList.itemRendererProperties.iconSourceField = "avatar";
			blueList.addEventListener(DragDropEvent.DRAG_DROP, dropBlueEventHandler);
			teamGroup.addChild(blueList);
			
			teamGroup.validate();
			teamGroup.y = (stage.stageHeight - teamGroup.height)/2;
			teamGroup.x = (stage.stageWidth - teamGroup.width)/2;
			
			btnStart = new Button();
			btnStart.label = "Start Game!";
			btnStart.name = Button.ALTERNATE_NAME_FORWARD_BUTTON;
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			if(!ConnectionManager.isServer)
				btnStart.alpha = 0.3;
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
		
		private function dropBlueEventHandler(event:DragDropEvent, dragData:DragData):void
		{
			
		}
		
		private function dropNoneEventHandler(event:DragDropEvent, dragData:DragData):void
		{
			
		}
		
		private function dropRedEventHandler(event:DragDropEvent, dragData:DragData):void
		{
			
		}
		
		public function setAvatar(item:Object):void
		{
			if(!item.byteAvatar)
				return;
			var imageLoader:Loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function (event:Object):void
			{
				var ldr:Loader = event.currentTarget.loader as Loader;
				item.avatar = ImageHelper.loaderToAvatar(ldr, stage);
				
				if(Match.noneCollection.getItemIndex(item)!=-1)
					Match.noneCollection.updateItemAt(Match.noneCollection.getItemIndex(item));
			});
			imageLoader.loadBytes(item.byteAvatar);
		}
		
		private function btnStartClickHandler():void
		{
			if(ConnectionManager.isServer)
			{
				ConnectionManager.sendMsg(CMD.START + "#" + Match.myId);
				owner.showScreen(SCREEN.GAME);
			}
			else
			{
				var alert:Alert = Alert.show("your friend should start game!", "Alert", new ListCollection(
					[
						{label: "OK"}
					]) );			
			}
		}
		
		private function btnCancelClickHandler():void
		{
			if(!ConnectionManager.mConnection.isLocal)
			{
				ConnectionManager.closeRTMFP();
				owner.showScreen(SCREEN.MAIN_MENU);
			}
			else
			{
				ConnectionManager.mConnection.exitRoom();
				owner.showScreen(SCREEN.LOBBY);
			}
		}
	}
}