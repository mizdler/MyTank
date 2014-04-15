package ir.baazino.mytank.map
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.map.Painter;
	
	public class Map
	{
		private var map:String;
		private var p1:Player;
		private var p2:Player;

		private var painter:Painter = new Painter();
		
		private var json:URLLoader = new URLLoader();
		private var data:Object;
		
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
			drawObjects();
		}
		
		private function drawBackgrounds():void
		{
			for each (var bg:Object in data.Backgrounds) 
			{
				painter.paint('background', bg.src, new Array());
			}
		}
		
		private function drawObjects():void
		{
			for each (var obj:Object in data.Objects) 
			{
				painter.paint('object', obj.src, obj.pos);
			}
		}

		public function clear()
		{
		}
	}
}