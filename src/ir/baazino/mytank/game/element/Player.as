package ir.baazino.mytank.game.element
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	import ir.baazino.mytank.screen.GameScreen;
	
	import nape.callbacks.CbType;
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class Player extends AbstractObject
	{
		public var tank:Body;
		public var id:String;

		[Embed(source='assets/tank.png')]
		protected var tankImg:Class;
		protected var tankShape:Image;

		public var speed:Number = 0.7;
		protected var scale:Number = 1;

		public var missiles:Dictionary = new Dictionary;

		protected var mCount:int;
		protected var firing:Boolean = false;

		protected var tankColl:CbType;
		public var isCollided:Boolean = false;

		public function Player(tankCollisionType:CbType)
		{
			super();
			tankColl = tankCollisionType;
		}

		override protected function init():void
		{
			createPlayer();
			addMissilePack();

			stage.addEventListener(Event.ENTER_FRAME, go);
		}

		protected function createPlayer():void
		{
			tankShape = Image.fromBitmap(new tankImg());

			tankShape.pivotX = int(width/2);
			tankShape.pivotY = int(height/2);
			tankShape.alignPivot();

			width = tankShape.width * scale;
			height = tankShape.height * scale;

			PhysicsData.registerCbType('tank', tankColl);
			tank = PhysicsData.createBody("tank");

			tank.userData.graphic = tankShape;

			tank.position.x = 75;
			tank.position.y = 40;
			tank.rotation = Math.PI/2;

			addChild(tankShape);
		}

		protected function addMissilePack(count:int = 5):void
		{
			mCount = count;

			for (var i:int = 0; i < count; i++)
			{
				missiles[i] = new Missile();
				addChild(missiles[i]);
			}
		}

		protected function go():void
		{
			var actor:Actor = Match.playerMap[this.id] as Actor;
			tank.rotation = actor.rotation;
			if(actor.isMoving)
				move(speed*3);
			if(actor.shoot)
			{
				fire();
				actor.shoot = false;
			}
			actor.x = tank.position.x;
			actor.y = tank.position.y;
		}

		override public function move(len:int):void
		{
			if (!isCollided)
			{
				tank.position.x += Math.sin(tank.rotation)*len;
				tank.position.y -= Math.cos(tank.rotation)*len;
			}
		}

		protected function fire():void
		{
			var mX:Number = Math.sin(-tank.rotation)*-53;
			var mY:Number = Math.cos(tank.rotation)*-53;

			for (var i:int = 0; i < mCount; i++)
			{
				if (!missiles[i].isVisible())
				{
					missiles[i].go(tank.position.x + mX, tank.position.y + mY, tank.rotation);
					firing = false;
					break;
				}
			}

		}
	}
}