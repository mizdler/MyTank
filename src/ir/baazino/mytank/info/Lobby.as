package ir.baazino.mytank.info
{
	import feathers.data.ListCollection;
	
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.screen.RoomScreen;
	
	public class Lobby
	{
		public static var playersNumber:Number;
		public static var roomCollection:ListCollection
		
		public static function init():void
		{
			playersNumber = 0;
			roomCollection = new ListCollection();
		}
	}
}