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
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class Player extends AbstractObject
	{
		public var tank:Body;
		public var id:String;

		[Embed(source='assets/blue-tank.png')]
		private var tankImg:Class;
		private var tankShape:Image;
		private var tHeight:Number;
		private var tWidth:Number;

		public var speed:Number = 150;
		public var angSpeed:Number = 10;

		public var missiles:Dictionary = new Dictionary;

		private var mCount:int;

		private var right:Boolean = false;
		private var left:Boolean = false;
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var firing:Boolean = false;

		private var tankColl:CbType;
		public var isCollided:Boolean = false;

		public function Player(tankCollisionType:CbType)
		{
			tankColl = tankCollisionType;
			super();
		}

		override protected function init():void
		{
			createPlayer();
			addMissilePack();

			stage.addEventListener(Event.ENTER_FRAME, go);
		}

		private function createPlayer():void
		{
			tankShape = Image.fromBitmap(new tankImg());
			tankShape.scaleX = tankShape.scaleY = Starter.scale;
			tankShape.alignPivot();
			tankShape.x = 121.5;
			tankShape.y = 133.5;
			
			tHeight = tankShape.height;
			tWidth = tankShape.width;

			PhysicsData.registerCbType('tank', tankColl);
			tank = PhysicsData.createBody("tank");
			tank.userData.graphic = tankShape;

			tank.scaleShapes(Starter.scale, Starter.scale);
			tank.position.x = 121.5;
			tank.position.y = 133.5;
			tank.rotation = Math.PI;

			addChild(tankShape);
		}

		private function addMissilePack(count:int = 5):void
		{
			mCount = count;

			for (var i:int = 0; i < count; i++)
			{
				missiles[i] = new Missile();
				addChild(missiles[i]);
			}
		}

		private function go():void
		{
			var actor:Actor = Match.playerMap[this.id] as Actor;
			
			rotate(actor.rotation);
			
			if(actor.isMoving)
				move(speed);
			else
				tank.velocity = new Vec2(0,0);
			
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
				tank.velocity.x = len*Math.sin(tank.rotation);
				tank.velocity.y = -len*Math.cos(tank.rotation);
			}
		}

		private function fire():void
		{
			var mX:Number = Math.sin(tank.rotation)*(tHeight/2)*1.1;
			var mY:Number = -Math.cos(tank.rotation)*(tHeight/2)*1.1;

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
		
		private function getAngel(angel:Number):Number
		{
			while (angel > Math.PI*2) 
				angel -= Math.PI;

			while (angel < -Math.PI*2) 
				angel += Math.PI;
			return angel;
		} 
		
		private function rotate(angel:Number):void
		{
			if (angel > tank.rotation + Math.PI) angel -= Math.PI*2;
			if (angel < tank.rotation - Math.PI) angel += Math.PI*2;

			tank.rotation += (angel - tank.rotation) / angSpeed;
		}
	}
}