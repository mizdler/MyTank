package ir.baazino.mytank.game.element
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class Player extends AbstractObject
	{
		public var tank:Body;

		[Embed(source='../assets/tank.png')]
		private var tankImg:Class;
		private var tankShape:Image;

		public var speed:Number = 0.7;
		private var scale:Number = 1;

		public var missiles:Dictionary = new Dictionary;

		private var mCount:int;

		private var right:Boolean = false;
		private var left:Boolean = false;
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var firing:Boolean = false;

		public function Player()
		{
			super();
		}

		override protected function init():void
		{
			createPlayer();
			addMissilePack();

			stage.addEventListener(Event.ENTER_FRAME, go);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		private function createPlayer():void
		{
			tankShape = Image.fromBitmap(new tankImg());

			tankShape.pivotX = int(width/2);
			tankShape.pivotY = int(height/2);
			tankShape.alignPivot();

			width = tankShape.width * scale;
			height = tankShape.height * scale;

			tank = PhysicsData.createBody("tank");
			tank.userData.graphic = tankShape;

			tank.position.x = 75;
			tank.position.y = 40;
			tank.rotation = Math.PI/2;

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
			tank.rotation = JoyStick.info.rotation;
			if(JoyStick.info.isMoving)
				move(speed*3);
			if(JoyStick.info.shoot){
				fire();
				JoyStick.info.shoot = false;
			}
			/*
			if(right)
				tank.rotation += 0.07 * speed;
			if(left)
				tank.rotation -= 0.07 * speed;
			if(up)
				move(-6 * speed);
			if(down)
				move(6 * speed);
			if(firing)
				fire();
			*/
		}

		private function handleKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.RIGHT && right == false)
				right = true;
			if(e.keyCode == Keyboard.LEFT && left == false)
				left = true;
			if(e.keyCode == Keyboard.UP && up == false)
				up = true;
			if(e.keyCode == Keyboard.DOWN && down == false)
				down = true;
			if(e.keyCode == Keyboard.SPACE && firing == false)
				firing = true;
		}

		private function handleKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.RIGHT)
				right = false;
			if(e.keyCode == Keyboard.LEFT)
				left = false;
			if(e.keyCode == Keyboard.UP)
				up = false;
			if(e.keyCode == Keyboard.DOWN)
				down = false;
			if(e.keyCode == Keyboard.SPACE)
				firing = false;
		}

		override public function move(len:int):void
		{
			//tank.position.x += Math.sin(-tank.rotation)*len;
			//tank.position.y += Math.cos(tank.rotation)*len;
			tank.position.x += Math.sin(tank.rotation)*len;
			tank.position.y -= Math.cos(tank.rotation)*len;
		}

		private function fire():void
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