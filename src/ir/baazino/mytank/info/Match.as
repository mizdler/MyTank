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
			
			var item1:Object = new Object();
			item1.id = 1;
			item1.playerName = "dummy1";
			
			var item2:Object = new Object();
			item2.id = 2;
			item2.playerName = "dummy2";
			
			var item3:Object = new Object();
			item3.id = 3;
			item3.playerName = "dummy3";
			
			Match.noneCollection.addItem(item1);
			Match.redCollection.addItem(item2);
			Match.blueCollection.addItem(item3);
		}
		         
	}
	
}