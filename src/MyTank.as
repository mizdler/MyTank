package 
{
	import flash.display.Sprite;
	
	import mx.core.FlexGlobals;
	
	import starling.core.Starling;
	import ir.baazino.mytank.game.Game;

	[SWF(frameRate="60", width="480", height="720", backgroundColor="#ffffff")]
	public class MyTank extends Sprite
	{
		private var strling:Starling;

		public function MyTank()
		{
			Starling.multitouchEnabled = true;
			strling = new Starling(Game, stage);
			strling.antiAliasing = 1;
			strling.showStats = true;
			strling.start();

		}
	}
}