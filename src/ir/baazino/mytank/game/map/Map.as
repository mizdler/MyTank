package ir.baazino.mytank.game.map
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import ir.baazino.mytank.game.element.Player;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Map extends Sprite
	{
		private var map:String;
		
		public var bodies:Dictionary = new Dictionary();
		
		private var json:URLLoader = new URLLoader();
		private var data:Object;
		private var len:int = 0;
		
		public function load(name:String):void
		{
			map = name;
			json.load(new URLRequest("/maps/"+map+"/"+map+".json"));
			json.addEventListener(Event.COMPLETE, decode);
		}
		
		private function decode(e:Event):void
		{
			data = JSON.parse(json.data);
			
			drawBackgrounds();
		}
		
		private function drawBackgrounds():void
		{
			var loader:Loader = new Loader();

			for each (var bg:Object in data.Backgrounds) 
				loader.load(new URLRequest(bg.src));

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, addBg);
		}
		
		private function drawObjects():void
		{
			for each (var obj:Object in data.Objects) 
			{
				var loader:Loader = new Loader();
				loader.load(new URLRequest(obj.src));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, addObj(obj.name, obj.pos[0], obj.pos[1]));
			}
		}
		
		private function drawWalls():void
		{
			bodies["left-wall"] = new Body(BodyType.STATIC);
			bodies["left-wall"].shapes.add(new Polygon(Polygon.rect(-10, 0, Starter.marginLeft+10, Starter.height)));
			bodies["right-wall"] = new Body(BodyType.STATIC);
			bodies["right-wall"].shapes.add(new Polygon(Polygon.rect(Starter.width - Starter.marginLeft, 0, Starter.marginLeft+10, Starter.height)));
			
			bodies["up-wall"] = new Body(BodyType.STATIC);
			bodies["up-wall"].shapes.add(new Polygon(Polygon.rect(Starter.marginLeft, -10, Starter.width - 2*Starter.marginLeft, Starter.marginTop+10)));
			bodies["down-wall"] = new Body(BodyType.STATIC);
			bodies["down-wall"].shapes.add(new Polygon(Polygon.rect(Starter.marginLeft, Starter.height - Starter.marginTop, Starter.width - 2*Starter.marginLeft, Starter.marginTop+10)));
		}
		
		private function addBg(e:Event):void
		{
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
			
			image.scaleX = Starter.scale;
			image.scaleY = Starter.scale;
			
			if (image.width != Starter.width) 
				Starter.marginLeft = (Starter.width - image.width)/2;
			if (image.height != Starter.height) 
				Starter.marginTop = (Starter.height - image.height)/2;
			
			image.x = Starter.marginLeft;
			image.y = Starter.marginTop;
			
			Starter.mWidth = image.width;
			Starter.mHeight = image.height;

			addChild(image);
			len++;

			drawWalls();
			drawObjects();
		}
		
		private function addObj(name:String, x:Number, y:Number):Function
		{
			x = x*Starter.scale + Starter.marginLeft;
			y = y*Starter.scale + Starter.marginTop;
			
			return function(e:Event):void {
				var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
				var image:Image = new Image(Texture.fromBitmap(loadedBitmap));

				image.alignPivot();
				image.scaleX = Starter.scale;
				image.scaleY = Starter.scale;
				image.x = x;
				image.y = y;
				
				bodies[name] = PhysicsData.createBody(name);
				bodies[name].type = BodyType.STATIC;
				bodies[name].align();
				
				bodies[name].userData.graphic = image;
				bodies[name].scaleShapes(Starter.scale, Starter.scale);
				bodies[name].position.x = x;
				bodies[name].position.y = y;

				addChild(image);
				len++;
			};
		}
		
		public function isFinished():Boolean
		{
			if(len != 0)
				return (len == data.Count);
			return false;
		}

		public function clear():void
		{
		}
	}
}