package ir.baazino.mytank.map
{
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.map.Painter;
	import ir.baazino.mytank.map.Parser;
	
	public class Map
	{
		private var map:String;
		private var p1:Player;
		private var p2:Player;
		
		private var parser:Parser;
		private var painter:Painter;
		
		public function Map(player1:Player, player2:Player)
		{
			p1 = player1;
			p2 = player2;
		}

		public function load(name:String)
		{
			map = name;
			parser = new Parser(name);
		}

		public function clear()
		{
		}
	}
}