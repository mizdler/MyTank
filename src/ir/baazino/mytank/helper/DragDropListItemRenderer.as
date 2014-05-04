package ir.baazino.mytank.helper
{
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class DragDropListItemRenderer extends DefaultListItemRenderer
	{
		public function DragDropListItemRenderer()
		{
			super();
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		protected function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{
				owner.selectedItem = this.data;
				owner.selectedIndex = this.index;
				(owner as DragDropList).touchBegin(event);
			}
		}
	}
}