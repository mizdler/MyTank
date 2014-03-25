package 
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.SCREEN;
	
	import mx.core.FlexGlobals;
	
	import starling.core.Starling;

	[SWF(frameRate="60", backgroundColor="#ffffff")]
	public class MyTank extends Sprite
	{
		private var strling:Starling;

		public function MyTank()
		{
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_UP, backKeyHandler);
			Starling.multitouchEnabled = true;
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = Capabilities.screenResolutionX;
			viewPortRectangle.height = Capabilities.screenResolutionY;
			strling = new Starling(Starter, stage, viewPortRectangle);
			strling.antiAliasing = 1;
			strling.showStats = true;
			strling.start();

		}
		
		protected function backKeyHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK && Starter.navigator.activeScreenID == SCREEN.mainMenu){
				ConnectionManager.closeTCP();
				ANE.wifi.disableWifi();
				NativeApplication.nativeApplication.exit();
			}
		}
		
	}
}