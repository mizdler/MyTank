package 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;
	
	import starling.core.Starling;

	[SWF(frameRate="60", backgroundColor="#ffffff")]
	public class MyTank extends Sprite
	{
		private var strling:Starling;

		public function MyTank()
		{
			Starling.multitouchEnabled = true;
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = Capabilities.screenResolutionX;
			viewPortRectangle.height = Capabilities.screenResolutionY;
			strling = new Starling(Starter, stage, viewPortRectangle);
			strling.antiAliasing = 1;
			strling.showStats = true;
			strling.start();

		}
	}
}