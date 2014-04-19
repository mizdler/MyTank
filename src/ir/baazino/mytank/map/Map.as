package ir.baazino.mytank.map
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
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Map extends Sprite
	{
		private var map:String;
		private var p1:Player;
		private var p2:Player;
		
		public var bodies:Dictionary = new Dictionary();
		
		private var json:URLLoader = new URLLoader();
		private var data:Object;
		private var len:int = 0;
		
		private var marginLeft:Number = 0;
		private var marginTop:Number = 0;
		
		public function Map(player1:Player, player2:Player)
		{
			p1 = player1;
			p2 = player2;
		}

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
			
		}
		
		private function addBg(e:Event):void
		{
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
			
			image.scaleX = Starter.scale;
			image.scaleY = Starter.scale;
			
			if (image.width != Starter.width) 
				marginLeft = (Starter.width - image.width)/2;
			if (image.height != Starter.height) 
				marginTop = (Starter.height - image.height)/2;
			
			image.x = marginLeft;
			image.y = marginTop;

			addChild(image);
			len++;
			drawObjects();
		}
		
		private function addObj(name:String, x:Number, y:Number):Function
		{
			x = x*Starter.scale + marginLeft;
			y = y*Starter.scale + marginTop;
			
			return function(e:Event):void {
				var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
				var image:Image = new Image(Texture.fromBitmap(loadedBitmap));

				image.scaleX = Starter.scale;
				image.scaleY = Starter.scale;
				image.x = x;
				image.y = y;
				image.alignPivot();
				
				bodies[name] = PhysicsData.createBody(name);
				bodies[name].type = BodyType.STATIC;
				
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