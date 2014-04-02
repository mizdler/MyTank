package ir.baazino.mytank.screen
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import flash.utils.Dictionary;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.game.Field;
	import ir.baazino.mytank.game.element.JoyStick;
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	
	import nape.callbacks.*;
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.events.Event;
	
	public class GameScreen extends Screen
	{
		private var field:Field;
		private var controller:JoyStick;
		private var player:Player;
		private var players:Dictionary = new Dictionary;
		private var playersLen:int;
		
		private var space:Space = new Space();
		
		private var interaction:InteractionListener;
		private var sepration:InteractionListener;
		private var wallCollisionType:CbType=new CbType();
		private var tankCollisionType:CbType=new CbType();
		
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
			
			interaction = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, wallCollisionType, tankCollisionType, collision);
			sepration = new InteractionListener(CbEvent.END, InteractionType.COLLISION, wallCollisionType, tankCollisionType, seprate);
			
			space.listeners.add(interaction);
			space.listeners.add(sepration);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function addButtons():void
		{
			var btnEnd:Button = new Button();
			btnEnd.label = "End";
			btnEnd.addEventListener(Event.TRIGGERED, btnEndClickHandler);
			addChild(btnEnd);
			btnEnd.validate();
			btnEnd.x = (stage.stageWidth - btnEnd.width)/2;
			btnEnd.y = (stage.stageHeight - btnEnd.height);
		}
		
		private function btnEndClickHandler():void
		{
			owner.showScreen(SCREEN.MAIN_MENU);
		}
		
		private function addPlayer():void
		{
			for(var id:String in Match.playerMap)
			{
				player = new Player(tankCollisionType);
				player.id = id;
				players[id] = player;
				addChild(players[id]);
				playersLen += 1;
			}
		}
		
		private function addController():void
		{
			controller = new JoyStick();
			addChild(controller);
		}
		
		private function addToSpace():void
		{
			for each(var b:Body in field.body)
			{
				b.cbTypes.add(wallCollisionType);
				b.space = space;
			}
			
			for each(var p:Player in players)
				p.tank.space = space;
			
			for each(var p2:Player in players)
				for (var j:int = 0; j < 5; j++)
					p2.missiles[j].missile.space = space;
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
		
		private function collision(collision:InteractionCallback):void
		{
			for each(var p:Player in players)
				p.isCollided = true;
		}
		
		private function seprate(collision:InteractionCallback):void
		{
			for each(var p:Player in players)
				p.isCollided = false;
		}
	}
}