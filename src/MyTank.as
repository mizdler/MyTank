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
			Starter.isIOS = Capabilities.manufacturer.indexOf("iOS")!=-1;
			Starling.multitouchEnabled = true;
			var viewPortRectangle:Rectangle = new Rectangle();
			if(Starter.isIOS)
			{
				Starling.handleLostContext = false;
				viewPortRectangle.width = Capabilities.screenResolutionY;
				viewPortRectangle.height = Capabilities.screenResolutionX;
			}		
			else
			{
				Starling.handleLostContext = true;
				viewPortRectangle.width = Capabilities.screenResolutionX;
				viewPortRectangle.height = Capabilities.screenResolutionY;
			}
			
			Starter.height = viewPortRectangle.height;
			Starter.width = viewPortRectangle.width;
			
			if (Starter.height/600 > Starter.width/800) 
				Starter.scale = Starter.width/800;
			else
				Starter.scale = Starter.height/600;

			strling = new Starling(Starter, stage, viewPortRectangle);
			strling.antiAliasing = 1;
			strling.showStats = true;
			strling.start();
		}
		
		public static function exitGame():void
		{
			ConnectionManager.closeTCP();
			ConnectionManager.closeUDP();
			ConnectionManager.closeRTMFP();
			NativeApplication.nativeApplication.exit();
		}
		
	}
}