package ir.baazino.mytank.game
{
	import flash.geom.Point;
	import flash.utils.Dictionary;

	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import starling.display.Shape;
	import starling.display.Sprite;

	public class Field extends Sprite
	{
		public var body:Dictionary = new Dictionary();

		private var maze_width:int;
		private var maze_height:int;
		private var wall_size:int = 60;
		private var initPos:int = 2;

		public var cell_count:int;

		private var maze:Array = new Array();
		private var moves:Array = new Array();
		private var dra:Shape = new Shape();

		private var w:Number;
		private var h:Number;

		public function Field(width:Number, height:Number)
		{
			super();

			w = width;
			h = height;

			maze_width = w/wall_size;
			maze_height = h/wall_size;

			mazer();
		}

		private function mazer():void
		{
			cell_count = maze_width*maze_height;

			var pos:int = Math.floor(Math.random()*cell_count);
			var visited:int = 1;

			for (var i:int = 0; i<cell_count; i++) {
				maze[i] = new Array(0,1,1,1,1);
			}

			maze[pos][0] = 1;

			while (visited < cell_count) {
				var possible:String = "";

				if ((Math.floor(pos/maze_width) == Math.floor((pos-1)/maze_width)) && (maze[pos-1][0] == 0))
					possible = possible + "W";

				if ((Math.floor(pos/maze_width) == Math.floor((pos+1)/maze_width)) && (maze[pos+1][0] == 0))
					possible = possible + "E";

				if (((pos+maze_width)<cell_count) && (maze[pos+maze_width][0] == 0))
					possible = possible + "S";

				if (((pos-maze_width)>=0) && (maze[pos-maze_width][0] == 0))
					possible = possible + "N";


				if (possible) {
					visited++;
					moves.push(pos);
					var way:String = possible.charAt(Math.floor(Math.random()*possible.length));
					switch (way) {
						case "N" :
							maze[pos][1] = 0;
							maze[pos-maze_width][2] = 0;
							pos -= maze_width;
							break;
						case "S" :
							maze[pos][2] = 0;
							maze[pos+maze_width][1] = 0;
							pos += maze_width;
							break;
						case "E" :
							maze[pos][3] = 0;
							maze[pos+1][4] = 0;
							pos++;
							break;
						case "W" :
							maze[pos][4] = 0;
							maze[pos-1][3] = 0;
							pos--;
							break;
					}
					maze[pos][0] = 1;
				} else
					pos = moves.pop();
			}

			addChild(dra);
			dra.graphics.lineStyle(4);
			dra.graphics.moveTo(initPos,initPos);

			var start_y:int = initPos - wall_size;
			var start_x:int = 0;

			for (i = 0; i<cell_count; i++) {
				body[i] = new Body(BodyType.STATIC);
				start_x += wall_size;

				if ((i%maze_width) == 0) {
					start_y += wall_size;
					start_x = initPos;
				}
				if (maze[i][2] == 1) {
					dra.graphics.moveTo(start_x,start_y+wall_size);
					dra.graphics.lineTo(start_x+wall_size,start_y+wall_size);

					body[i].shapes.add(new Polygon(Polygon.rect(start_x, start_y+wall_size-2, wall_size, 4)));
				}
				if (maze[i][3] == 1) {
					dra.graphics.moveTo(start_x+wall_size,start_y);
					dra.graphics.lineTo(start_x+wall_size,start_y+wall_size);

					body[i].shapes.add(new Polygon(Polygon.rect(start_x+wall_size-2, start_y, 4, wall_size)));
				}
			}

			dra.graphics.moveTo(initPos,initPos);
			dra.graphics.lineTo(w-initPos,initPos);
			dra.graphics.lineTo(w-initPos,h-initPos);
			dra.graphics.lineTo(initPos,h-initPos);
			dra.graphics.lineTo(initPos,initPos);
			
			body[cell_count] = new Body(BodyType.STATIC);
			body[cell_count].shapes.add(new Polygon(Polygon.rect(initPos, initPos - wall_size, w, wall_size+3)));
			
			body[cell_count+1] = new Body(BodyType.STATIC);
			body[cell_count+1].shapes.add(new Polygon(Polygon.rect(w-initPos-3, initPos, wall_size, h-initPos)));
			
			body[cell_count+2] = new Body(BodyType.STATIC);
			body[cell_count+2].shapes.add(new Polygon(Polygon.rect(initPos-wall_size,initPos, wall_size+3,h-initPos)));
			
			body[cell_count+3] = new Body(BodyType.STATIC);
			body[cell_count+3].shapes.add(new Polygon(Polygon.rect(initPos,h-initPos-3,w,wall_size)));
			
			cell_count = cell_count + 4;
		}
	}
}