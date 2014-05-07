package ir.baazino.mytank.game.element
{
	import flash.utils.setTimeout;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	
	import starling.core.Starling;
	import starling.display.Shape;

	public class Missile extends AbstractObject
	{
		public var missile:Body = new Body(BodyType.DYNAMIC);

		public var missileGraphic:Shape;

		private var mRadius:Number;
		private var mColor:uint;
		private var velLen:uint = 500;
		private var goTime:Number = 3000;

		public function Missile(radius:Number = 2, color:uint = 0x000000)
		{
			super();

			mRadius = radius*Starter.scale;
			mColor = color;
		}

		override protected function init():void
		{
			missileGraphic = new Shape();

			missileGraphic.visible = false;

			missileGraphic.graphics.beginFill(mColor, 1);
			missileGraphic.graphics.lineStyle(4, mColor, 1);
			missileGraphic.graphics.drawCircle(0, 0, mRadius);
			missileGraphic.graphics.endFill();

			missile.shapes.add(new Circle(mRadius, null, new Material()));
			missile.isBullet = true;
			missile.userData.graphic = missileGraphic;

			addChild(missileGraphic);
		}

		public function isVisible():Boolean
		{
			if (missileGraphic.visible)
				return true;

			return false;
		}

		public function go(x:Number, y:Number, angel:Number):void
		{
			missile.userData.graphic.visible = true;

			missile.position.x = x;
			missile.position.y = y;

			missile.velocity.x = Math.sin(angel)*velLen;
			missile.velocity.y = -Math.cos(angel)*velLen;

			setTimeout(stop, goTime);
		}

		private function stop():void
		{
			missile.velocity.x = 0;
			missile.velocity.y = 0;

			missile.position.x = 0;
			missile.position.y = 0;

			missile.userData.graphic.visible = false;
		}
	}
}