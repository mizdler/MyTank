package ir.baazino.mytank.helper
{
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDragSource;
	import feathers.dragDrop.IDropTarget;
	import feathers.events.DragDropEvent;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	//[Event(name="changeTeam", type="Event")]
	
	public class DragDropList extends List implements IDropTarget, IDragSource
	{
		public function DragDropList()
		{
			super();
			itemRendererType = DragDropListItemRenderer;
			addEventListener(DragDropEvent.DRAG_ENTER, dragEnterHandler);
			addEventListener(DragDropEvent.DRAG_DROP, dragDropHandler);
			addEventListener(DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
		}
		
		public function touchBegin(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{
				
				if(selectedItem)
				{
					var fc:DragDropListItemRenderer = new DragDropListItemRenderer();
					var lbl:Label = new Label();
					lbl.text = selectedItem["playerName"];
					fc.addChild(lbl);
					var dd:DragData = new DragData();
					dd.setDataForFormat("playerFormat", selectedItem);
					DragDropManager.startDrag(this, touch, dd, fc);
				}
			}
		}
		
		protected function dragEnterHandler(event:DragDropEvent, dragData:DragData):void
		{
			if(dragData.hasDataForFormat("playerFormat"))
			{
				DragDropManager.acceptDrag(this);
			}
		}
		
		protected function dragDropHandler(event:DragDropEvent, dragData:DragData):void
		{
			if(dragData.hasDataForFormat("playerFormat"))
			{
				var obj:Object = dragData.getDataForFormat("playerFormat");
				dataProvider.push(obj);
				//dispatchEventWith("changeTeam", false, obj);
			}
		}
		
		protected function dragCompleteHandler(event:DragDropEvent):void
		{
			if(event.isDropped)
			{
				dataProvider.removeItem(selectedItem);
			}
		}
		
	}
}