package ir.baazino.mytank.helper
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	
	import starling.events.Event;
	
	
	final public class Notifier extends Alert
	{
		public static const OK_CANCEL:String = "ok_cancel";
		public static const OK:String = "ok";
		public static const CHOOSE_AVATAR:String = "choose_image";
		
		public static const BTN_OK:String = "btnOK";
		public static const BTN_CANCEL:String = "btnCancel";
		public static const BTN_GALLERY:String = "btnGallery";
		public static const BTN_CAMERA:String = "btnCamera";
		
		private var btnOK:Button;
		private var btnCancel:Button;
		private var btnGallery:Button;
		private var btnCamera:Button;
		
		public var btnClicked:Button;
		
		public function Notifier(title:String, message:String, type:int)
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			this.headerFactory = function():Header
			{
				var header:Header = new Header();
				header.title = title;
				return header;
			}
			this.footerFactory = function():LayoutGroup
			{
				var buttons:LayoutGroup = new LayoutGroup();
				var layout:HorizontalLayout = new HorizontalLayout();
				buttons.layout = layout;
				switch(type)
				{
					case OK:
						btnOK = new Button();
						btnOK.name = BTN_OK;
						btnOK.label = "Ok.";
						btnOK.addEventListener(Event.TRIGGERED, onClickButton);
						buttons.addChild(btnOK);
						break;
					
					case OK_CANCEL:
						btnOK = new Button();
						btnOK.name = "btnOK";
						btnOK.label = "Ok.";
						btnOK.addEventListener(Event.TRIGGERED, onClickButton);
						buttons.addChild(btnOK);
						
						btnCancel = new Button();
						btnCancel.name = BTN_CANCEL;
						btnCancel.label = "cancel";
						btnCancel.addEventListener(Event.TRIGGERED, onClickButton);
						buttons.addChild(btnCancel);
						break;
					
					case CHOOSE_AVATAR:
						btnGallery = new Button();
						btnGallery.name = BTN_GALLERY;
						btnGallery.label = "choose from gallery";
						btnGallery.addEventListener(Event.TRIGGERED, onClickButton);
						buttons.addChild(btnGallery);
						
						btnCamera = new Button();
						btnCamera.name = BTN_CAMERA;
						btnCamera.label = "take a picture";
						btnCamera.addEventListener(Event.TRIGGERED, onClickButton);
						buttons.addChild(btnCamera);
						break;
					
				}
				return buttons;
			}
			
		}
		
		private function addToStageHandler():void
		{
		}
		
		private function onClickButton(event:Event):void
		{
			dispatchEvent(new Event(btnClicked.name));
		}
		
	}
	
}