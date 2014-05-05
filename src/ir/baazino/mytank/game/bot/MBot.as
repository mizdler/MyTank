package ir.baazino.mytank.game.bot
{
	import ir.baazino.mytank.game.element.Player;
	
	import nape.callbacks.CbType;

	public class MBot extends Player
	{
		public function MBot(tankCollisionType:CbType)
		{
			super(tankCollisionType);
		}
		
		override protected function go():void
		{
			// logic
		}
	}
}