package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.utils.Dictionary;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.game.Field;
	import ir.baazino.mytank.game.element.JoyStick;
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.helper.Screens;
	
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;

	public class GameScreen extends Screen
	{
		private var field:Field;
		private var controller:JoyStick;
		private var player:Player;
		private var players:Dictionary = new Dictionary;
		private var playersLen:int;
		
		private var space:Space = new Space();

		public function GameScreen()
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
			
			addButtons();

			addToSpace();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function addButtons():void
		{
			var btnStart:Button = new Button();
			btnStart.label = "Back";
			btnStart.addEventListener(Event.TRIGGERED, btnStartClickHandler);
			addChild(btnStart);
			btnStart.validate();
			btnStart.x = (stage.stageWidth - btnStart.width)/2;
			btnStart.y = (stage.stageHeight - btnStart.height);			
		}
		
		private function btnStartClickHandler():void
		{
			owner.showScreen(Screens.mainMenuId);
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