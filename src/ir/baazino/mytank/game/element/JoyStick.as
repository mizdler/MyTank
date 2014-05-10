package ir.baazino.mytank.game.element  
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	
	import nape.phys.Body;

	import starling.display.Image;
	import starling.display.Shape;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class JoyStick extends AbstractObject
	{
		public static var actor:Actor = Match.playerMap[Match.myId] as Actor;
		[Embed(source='assets/thumb.png')]
		private var thumbImg:Class;
		private var thumbShape:Image;
		private var thumbShape2:Image;
		
		[Embed(source='assets/surround.png')]
		private var surroundImg:Class;
		private var surroundShape:Image;
		
		private var center:Object;
		private var actual:Object;
		
		private var shootShape:Shape;
		private var shootW:Number;
		private var shootH:Number;
		private var shootX:Number;
		private var shootY:Number;
		
		private const radius:Number = 30;
		private const minRadius:Number = 25;
		
		public function JoyStick():void
		{
			super();
			center = new Object();
			actual = new Object();
			actor.rotation = Math.PI/2;
			actor.isMoving = false;
			actor.shoot = false;
		}
		
		override protected function init():void
		{
			thumbShape2 = Image.fromBitmap(new thumbImg());
			thumbShape2.alignPivot();
			
			center.x = Starter.width*0.9 - thumbShape2.width/2;
			center.y = Starter.height*0.9 - thumbShape2.height/2;
			
			thumbShape2.x = center.x;
			thumbShape2.y = center.y;
			thumbShape2.scaleX = thumbShape2.scaleY = Starter.scale;
			thumbShape2.alpha = 0;
			
			thumbShape = Image.fromBitmap(new thumbImg());
			thumbShape.alignPivot();
			thumbShape.x = center.x;
			thumbShape.y = center.y;
			thumbShape.scaleX = thumbShape.scaleY = Starter.scale;
			thumbShape.alpha = 0.7;
			
			surroundShape = Image.fromBitmap(new surroundImg());
			surroundShape.alignPivot();
			surroundShape.x = center.x;
			surroundShape.y = center.y;
			surroundShape.scaleX = surroundShape.scaleY = Starter.scale;
			surroundShape.alpha = 0.5;

			shootW = shootH = 1.4*Starter.mHeight/3;
			shootY = Starter.marginTop + 2*Starter.mHeight/3;
			shootX = Starter.marginLeft;
			
			shootShape = new Shape();
			shootShape.graphics.beginFill(0x000000, 1);
			shootShape.graphics.lineStyle(4, 0x000000, 1);
			shootShape.graphics.drawRect(shootX, shootY, shootW, shootW);
			shootShape.alpha = 0;
			
			addChild(surroundShape);
			addChild(thumbShape);
			addChild(thumbShape2);
			addChild(shootShape);
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}

		protected function touchHandler(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(stage);

			for each(var touch:Touch in touches)
			{
				if(touch.target == thumbShape2)
				{
					if(touch.phase == TouchPhase.MOVED){
						var postion:Point = touch.getLocation(stage);
						thumbShape2.x = postion.x;
						thumbShape2.y = postion.y;
						
						actual.x = thumbShape2.x - center.x;
						actual.y = thumbShape2.y - center.y;
						
						var angle :Number = Math.atan2(actual.y, actual.x);
						var distance:Number = Math.sqrt(Math.pow(actual.x,2)+Math.pow(actual.y,2));
						
						if(distance > radius){
							var maxX:Number = (radius * Math.cos(angle)) + center.x;
							var maxY:Number = (radius * Math.sin(angle)) + center.y;
							thumbShape.x = maxX;
							thumbShape.y = maxY;
						}
						else{
							thumbShape.x = thumbShape2.x;
							thumbShape.y = thumbShape2.y;
						}
						
						if(distance > minRadius){
							actor.isMoving = true;
							actor.rotation = angle + Math.PI/2;
						}
						
					}
					else if(touch.phase == TouchPhase.ENDED){
						actor.isMoving = false;
						thumbShape2.x = center.x;
						thumbShape2.y = center.y;
						
						thumbShape.x = center.x;
						thumbShape.y = center.y;
					}
				}

				if( touch.globalY > shootY && touch.globalY < shootY + shootH &&
					touch.globalX > shootX && touch.globalX < shootX + shootW &&
					touch.phase == TouchPhase.ENDED)
					actor.shoot = true;
			}
			ConnectionManager.sendMsg(CMD.UPDATE + "#" + Match.myId + "#" + actor.x + "#" + actor.y + "#" + actor.rotation + "#" + actor.isMoving + "#" + actor.shoot);
		}
	}
}
