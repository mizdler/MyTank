package ir.baazino.mytank.game.element
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AbstractObject extends Sprite implements ObjectInterface
	{
		public function AbstractObject()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		protected function init():void {}
		public function move(len:int):void {}
	}
}