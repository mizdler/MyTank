package ir.baazino.mytank.helper
{
	import flash.display.BitmapData;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	
	public class Storage
	{
		private static var shared:SharedObject = SharedObject.getLocal("MYTANK_STORAGE");
		
		public static function loadPlayerName():String
		{
			return ANE.info.loadPlayerName();
		}
		public static function savePlayerName(playerName:String):void
		{
			ANE.info.savePlayerName(playerName);	
		}
		
		public static function saveWifiPassword(password:String):void
		{
			shared.data.wifiPass = password;
			shared.flush();
		}
		public static function loadWifiPassword():String
		{
			if(shared.data.wifiPass)
				return shared.data.wifiPass;
			else
				return "12345678";
		}
		
		public static function saveAvatar(avatar:ByteArray):void
		{
			shared.data.avatar = avatar;
			shared.flush();
		}
		public static function loadAvatar():ByteArray
		{
			if(shared.data.avatar)
				return shared.data.avatar;
			return null;
		}
		
	}
}