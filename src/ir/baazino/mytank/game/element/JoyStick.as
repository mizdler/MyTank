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
		
		[Embed(source='assets/shoot.png')]
		private var shootImg:Class;
		private var shootShape:Image;
		
		private var center:Object;
		private var actual:Object;
		
		private const radius:Number = 30;
		private const minRadius:Number = 25;
		
		public var speed:Number = 0.7;
		
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
			
			shootShape = Image.fromBitmap(new shootImg());
			shootShape.x = 100;
			shootShape.y = stage.stageHeight - shootShape.height - 100;
			shootShape.alpha = 0.7;
			
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
				else if(touch.target == shootShape && touch.phase == TouchPhase.ENDED)
					actor.shoot = true;
			}
			ConnectionManager.sendMsg(CMD.UPDATE + "#" + Match.myId + "#" + actor.x + "#" + actor.y + "#" + actor.rotation + "#" + actor.isMoving + "#" + actor.shoot);
		}
	}
}
