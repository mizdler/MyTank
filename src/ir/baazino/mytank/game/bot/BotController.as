package ir.baazino.mytank.game.bot
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ir.baazino.mytank.screen.GameScreen;
	import nape.callbacks.CbType;

	public class BotController
	{
		private var screen:GameScreen;
		private var tankCollisionType:CbType=new CbType();
		private var botTimer:Timer;
		
		public function BotController(gameScreen:GameScreen)
		{
			screen = gameScreen;
			botTimer = new Timer(5000)
			botTimer.addEventListener(TimerEvent.TIMER, addBot);
			//botTimer.start();
		}
		
		protected function addBot(event:TimerEvent):void
		{
			var bot:MBot = new MBot(tankCollisionType);
			screen.addChild(bot);
			bot.tank.space = screen.space;
		}
	}
}