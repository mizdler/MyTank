package ir.baazino.mytank.game
{
	import ir.baazino.mytank.game.element.JoyStick;
	import ir.baazino.mytank.game.element.Player;
	
	import flash.utils.Dictionary;
	
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Game extends Sprite
	{
		private var field:Field;
		private var controller:JoyStick;
		private var player:Player;
		private var players:Dictionary = new Dictionary;
		private var playersLen:int;
		
		private var space:Space = new Space();

		public function Game()
		{
			super();
			playersLen = 0;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		public function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}

		private function init():void
		{
			field = new Field(stage.stageWidth, stage.stageHeight);
			addChild(field);

			addPlayer();
			
			addController();

			addToSpace();

			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function addPlayer():void
		{
			player = new Player();
			players[playersLen] = player;
			addChild(players[playersLen]);

			playersLen += 1;
		}
		
		private function addController():void
		{
			controller = new JoyStick(player.tank);
			addChild(controller);
		}
		

		private function addToSpace():void
		{
			for (var i:int = 0; i < field.cell_count; i++)
				field.body[i].space = space;

			for (i = 0; i < playersLen; i++)
				players[i].tank.space = space;

			for (i = 0; i < playersLen; i++)
				for (var j:int = 0; j < 5; j++)
					players[i].missiles[j].missile.space = space;
		}

		private function loop():void
		{
			space.step(1/60);
			space.liveBodies.foreach(updateGraphics);
		}

		private function updateGraphics(b:Body):void
		{
			b.userData.graphic.x = b.position.x;
			b.userData.graphic.y = b.position.y;
			b.userData.graphic.rotation = b.rotation;
		}
	}
}