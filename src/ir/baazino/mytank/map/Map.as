package ir.baazino.mytank.map
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ir.baazino.mytank.game.element.Player;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Map extends Sprite
	{
		private var map:String;
		private var p1:Player;
		private var p2:Player;
		
		private var json:URLLoader = new URLLoader();
		private var data:Object;
		
		public var loader:Loader = new Loader();
		
		public function Map(player1:Player, player2:Player)
		{
			p1 = player1;
			p2 = player2;
		}

		public function load(name:String)
		{
			map = name;
			json.load(new URLRequest("/maps/"+map+"/"+map+".json"));
			json.addEventListener(Event.COMPLETE, decode);
		}
		
		private function decode(e:Event):void
		{
			data = JSON.parse(json.data);
			
			drawBackgrounds();
			//drawObjects();
		}
		
		private function drawBackgrounds():void
		{
			for each (var bg:Object in data.Backgrounds) 
			{
				loader.load(new URLRequest(bg.src));
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, add);
		}
		
		private function drawObjects():void
		{
			for each (var obj:Object in data.Objects) 
			{
				
			}
		}
		
		private function add(e:Event):void
		{
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			var image:Image = new Image(Texture.fromBitmap(loadedBitmap));
			addChild(image);
		}

		public function clear()
		{
		}
	}
}