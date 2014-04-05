package ir.baazino.mytank.helper
{
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.GroupedList;
	import feathers.controls.ScrollText;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.PopUpManager;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.ILayout;
	import feathers.layout.VerticalLayout;
	
	import flash.text.TextFormat;
	
	import starling.events.Event;
	
	[Event(name="open",type="starling.events.Event")]
	[Event(name="close",type="starling.events.Event")]
	
	//[Event(name="complete",type="starling.events.Event")]
	final public class Notifier extends FeathersControl
	{
		static public const OK:uint = 0x0;
		static public const YES:uint = 0x1;
		static public const NO:uint = 0x2;
		//static public const CANCEL:uint = 0x4;
		
		public var layout:ILayout;
		
		private var _defaultFlag:uint = 0x0;
		
		//private var _screenRenderList:ScrollContainer;
		//private var _buttonSelectionHBox:ScrollContainer;
		private var _popupManager:VerticalCenteredPopUpContentManager;
		
		private var _title:String;
		private var _message:String;
		private var _flags:uint;
		
		private var _notifier:GroupedList;
		
		private var _messageText:ScrollText;
		
		private var _hasDrawn:Boolean;
		private var _hasShown:Boolean;
		
		private var _buttonGroup:ButtonGroup;
		private var _buttonGroupListCollection:ListCollection;
		
		private var _selectedFlag:uint;
		
		public function Notifier($message:String, $flags:uint,$title:String="", $defaultFlag:uint=0)
		{
			super();
			
			_title = $title;
			_message = $message;
			_flags = $flags;
			_selectedFlag = _defaultFlag = $defaultFlag;
			
		}
		
		override protected function initialize():void
		{
			visible = false;
			_popupManager = new VerticalCenteredPopUpContentManager();
			_notifier = new GroupedList();
			_messageText = new ScrollText();
			_buttonGroup = new ButtonGroup();
			
			_popupManager.addEventListener(Event.CLOSE, onClose);
			
			if (!layout)
			{
				var v:VerticalLayout = new VerticalLayout();
				v.gap = 2;
				v.hasVariableItemDimensions = true;
				v.useVirtualLayout = true;
				v.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
				layout = v;
			}
			
			if (!_title.length)
				_title = null;
			
			_buttonGroupListCollection = new ListCollection([]);
			
			if (_flags == OK)
			{
				_buttonGroupListCollection.push( { label:"OK", triggered:onButtonTriggered, value:OK } );
				//createFlagButton("OK");
			}
			else
			{
				if (_flags | YES) _buttonGroupListCollection.push( { label:"Yes", triggered:onButtonTriggered, value:YES } );
				if (_flags | NO) _buttonGroupListCollection.push( { label:"No", triggered:onButtonTriggered, value:NO } );
			}
			
			_buttonGroup.dataProvider = _buttonGroupListCollection;
			
			_notifier.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			_notifier.isSelectable = false;
			_notifier.dataProvider = new HierarchicalCollection( [{
				header:_title,
				children:[
					//{label:_message},
					{label:" ",accessory:_messageText},
					//{label:" ",accessory:_buttonSelectionHBox}
				]
				
			}]);
			
			_messageText.text = _message;
			
			addChild(_notifier);
			addChild(_buttonGroup);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			_messageText.width = width-60;
			_messageText.validate();
			
			_notifier.width = width;
			_notifier.layout = layout;
			
			_notifier.validate();
			_buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			_buttonGroup.gap = 5;
			_buttonGroup.y = _notifier.height+_buttonGroup.gap;
			_buttonGroup.width = width;
			
			_buttonGroup.validate();
			
			_notifier.validate();
			height = _buttonGroup.height + _notifier.height+_buttonGroup.gap;
			validate();
			
			if (_hasShown && !_hasDrawn)
				renderNotifier();
			
			_hasDrawn = true;
			
		}
		
		public function show():void
		{
			if (!_hasShown)
			{
				if (_hasDrawn && !_hasShown)
					renderNotifier();
				
				_hasShown = true;
			}
			
			dispatchEventWith(Event.OPEN);
		}
		
		public function hide():void
		{
			_popupManager.close();
		}
		
		private function onClose(e:Event):void
		{
			dispatchEventWith(Event.CLOSE);
		}
		
		private function renderNotifier():void
		{
			visible = true;
			
			_popupManager.open(this, parent);
		}
		
		private function onButtonTriggered(e:Event):void
		{
			var $button:Button = Button( e.currentTarget );
			var $item:Object;
			
			for (var i:int = 0; i < _buttonGroupListCollection.length; i++)
			{
				$item = _buttonGroupListCollection.getItemAt(i);
				if ($item.label == $button.label)
				{
					_selectedFlag = $item.value;
					break;
				}
			}
			
			trace( "button triggered:", $button.label, "value:",_selectedFlag);
			
			hide();
		}
	}
	
}