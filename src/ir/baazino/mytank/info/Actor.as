package ir.baazino.mytank.info
{
	public class Actor
	{
		public function Actor()
		{
			x = 75;
			y = 40;
			rotation = Math.PI/2;
			isMoving = false;
			shoot = false;
		}
		public var x:Number;
		public var y:Number;
		public var rotation:Number;
		public var isMoving:Boolean;
		public var shoot:Boolean;
	}
}