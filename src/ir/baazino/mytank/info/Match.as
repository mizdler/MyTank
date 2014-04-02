package ir.baazino.mytank.info
{
	import feathers.controls.List;
	import feathers.data.ListCollection;
	
	import flash.utils.Dictionary;

	public class Match
	{
		public static var myId:String;
		public static var playerMap:Dictionary;
		
		public static var noneCollection:ListCollection;
		public static var redCollection:ListCollection;
		public static var blueCollection:ListCollection;
		
		public static function init():void
		{
			playerMap = new Dictionary();
			noneCollection = new ListCollection();
			redCollection = new ListCollection();
			blueCollection = new ListCollection();
		}
		
	}
	
}