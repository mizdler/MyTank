package ir.baazino.mytank.game.element  
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import nape.phys.Body;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class JoyStick extends AbstractObject
	{
		public static var info:Object = new Object();
		[Embed(source='../assets/thumb.png')]
		private var thumbImg:Class;
		private var thumbShape:Image;
		private var thumbShape2:Image;
		
		[Embed(source='../assets/surround.png')]
		private var surroundImg:Class;
		private var surroundShape:Image;
		
		[Embed(source='../assets/shoot.png')]
		private var shootImg:Class;
		private var shootShape:Image;
		
		private var center:Object;
		private var actual:Object;
		
		private const radius:Number = 30;
		private const minRadius:Number = 25;
		private var tank:Body;
		
		public var speed:Number = 0.7;
		
		public function JoyStick(_tank:Body):void
		{
			super();
			center = new Object();
			actual = new Object();
			tank = _tank;
			info.rotation = Math.PI/2;
			info.isMoving = false;
			info.shoot = false;
		}
		
		override protected function init():void
		{
			thumbShape2 = Image.fromBitmap(new thumbImg());
			
			center.x = stage.stageWidth*0.8 - thumbShape2.width/2;
			center.y = stage.stageHeight*0.9 - thumbShape2.height/2;
			
			thumbShape2.x = center.x;
			thumbShape2.y = center.y;
			thumbShape2.alpha = 0;
			
			thumbShape = Image.fromBitmap(new thumbImg());
			thumbShape.x = center.x;
			thumbShape.y = center.y;
			thumbShape.alpha = 0.7;
			
			surroundShape = Image.fromBitmap(new surroundImg());
			surroundShape.x = stage.stageWidth*0.8 - surroundShape.width/2;
			surroundShape.y = stage.stageHeight*0.9 - surroundShape.height/2;
			surroundShape.alpha = 0.5;
			
			shootShape = Image.fromBitmap(new shootImg());
			shootShape.x = 0;
			shootShape.y = stage.stageHeight - shootShape.height;
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
				if(touch.target == thumbShape2){
					if(touch.phase == TouchPhase.MOVED){
						var postion:Point = touch.getLocation(stage);
						thumbShape2.x = postion.x - thumbShape2.width/2;
						thumbShape2.y = postion.y - thumbShape2.height/2;
						
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
							info.isMoving = true;
							info.rotation = angle + Math.PI/2;
						}
						
					}
					else if(touch.phase == TouchPhase.ENDED){
						info.isMoving = false;
						thumbShape2.x = center.x;
						thumbShape2.y = center.y;
						
						thumbShape.x = center.x;
						thumbShape.y = center.y;
					}
				}
				else if(touch.target == shootShape && touch.phase == TouchPhase.ENDED){
					JoyStick.info.shoot = true;
				}
			
		}
	}
}
