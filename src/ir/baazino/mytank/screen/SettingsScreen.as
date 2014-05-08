package ir.baazino.mytank.screen
{
	import com.freshplanet.ane.AirImagePicker.AirImagePicker;
	import com.greensock.loading.ImageLoader;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.factory.TruncationOptions;
	
	import ir.baazino.mytank.helper.ImageHelper;
	import ir.baazino.mytank.helper.Notifier;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.Storage;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SettingsScreen extends Screen
	{
		private var header:Header;
		private var group:LayoutGroup;
		private var layout:VerticalLayout;
		
		private var playerGroup:LayoutGroup;
		private var playerLayout:HorizontalLayout;
		private var lblPlayerName:Label;
		private var txtPlayerName:TextInput;
		private var btnAvatar:Button;
		
		private var imgAvatar:Image;
		private var byteAvatar:ByteArray;
		
		private var wifiGroup:LayoutGroup;
		private var wifiLayout:HorizontalLayout;
		private var lblWifiPassword:Label;
		private var txtWifiPassword:TextInput;
		
		private var btnSave:Button;
		private var btnBack:Button;
		
		public function SettingsScreen()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.backButtonHandler = btnBackClickHandler;
		}
		
		private function addedToStageHandler():void
		{
			header = new Header()
			header.title = "Settings";
			this.addChild(header);
			
			group = new LayoutGroup();
			playerGroup = new LayoutGroup();
			wifiGroup = new LayoutGroup();
			
			lblPlayerName = new Label;
			lblPlayerName.text = "player name:";
			playerGroup.addChild(lblPlayerName);
			
			txtPlayerName = new TextInput();
			txtPlayerName.text = Storage.loadPlayerName();
			playerGroup.addChild(txtPlayerName);
			
			setAvatar(Storage.loadAvatar());
			if(imgAvatar)
				playerGroup.addChild(imgAvatar);
				
			btnAvatar = new Button();
			btnAvatar.label = "Choose Image";
			btnAvatar.addEventListener(Event.TRIGGERED, btnAvatarClickHandler);
			playerGroup.addChild(btnAvatar);
			
			playerLayout = new HorizontalLayout();
			playerGroup.layout = playerLayout;
			playerLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			group.addChild(playerGroup);
			
			
			lblWifiPassword = new Label;
			lblWifiPassword.text = "WiFi password:";
			wifiGroup.addChild(lblWifiPassword);
			
			txtWifiPassword = new TextInput();
			txtWifiPassword.text = Storage.loadWifiPassword();
			wifiGroup.addChild(txtWifiPassword);
			
			wifiLayout = new HorizontalLayout();
			wifiGroup.layout = wifiLayout;
			wifiLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			group.addChild(wifiGroup);
			
			layout = new VerticalLayout();
			group.layout = layout;
			layout.gap = stage.stageHeight / 15;
			this.addChild(group);
			group.validate();
			group.y = (stage.stageHeight - group.height)/2;
			group.x = (stage.stageWidth - group.width)/2;
			
			
			btnBack = new Button();
			btnBack.name = Button.ALTERNATE_NAME_BACK_BUTTON;
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
		
		private function btnAvatarClickHandler():void
		{
			if (AirImagePicker.getInstance().isCameraAvailable())
			{
				AirImagePicker.getInstance().displayCamera(function(status:String, ...mediaArgs):void {
					if(status == AirImagePicker.STATUS_OK){
						byteAvatar = (ByteArray)(mediaArgs[1]);
						setAvatar(byteAvatar);
					}
				});
			}			
		}
		public function setAvatar(byteArray:ByteArray):void
		{
			if(!byteArray)
				return;
			var imageLoader:Loader = new Loader();
			var ldr:ImageLoader;
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function (event:Object):void
			{
				var ldr:Loader = event.currentTarget.loader as Loader;
				var newAvatar:Image = ImageHelper.loaderToAvatar(ldr, stage);
				
				if(imgAvatar)
					playerGroup.removeChild(imgAvatar, true);
				imgAvatar = newAvatar;
				playerGroup.addChild(imgAvatar);
			});
			imageLoader.loadBytes(byteArray);
		}
		
		private function btnBackClickHandler():void
		{
			owner.showScreen(SCREEN.MAIN_MENU);
		}
		
		private function btnSaveClickHandler():void
		{
			var alert:Notifier;
			if(txtPlayerName.text.length < 1)
			{
				alert = new Notifier("player name must be at least 1 characters.",Notifier.OK,"Alert");
				alert.width = stage.stageWidth/2;
				addChild(alert);
				alert.show();
				txtPlayerName.text = Storage.loadPlayerName()();
			}
			else if(txtWifiPassword.text.length < 8)
			{
				alert= new Notifier("WiFi password must be at least 8 characters.",Notifier.OK,"Alert");
				alert.width = stage.stageWidth/2;
				addChild(alert);
				alert.show();
				txtWifiPassword.text = Storage.loadWifiPassword();
			}
			else
			{
				Storage.savePlayerName(txtPlayerName.text);
				Storage.saveAvatar(byteAvatar);
				Storage.saveWifiPassword(txtWifiPassword.text);
				owner.showScreen(SCREEN.MAIN_MENU);
			}
		}
	}
}