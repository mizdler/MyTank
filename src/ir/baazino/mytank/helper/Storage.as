package ir.baazino.mytank.helper
{
	import flash.net.SharedObject;
	
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
		
		public static function loadWifiPassword():String
		{
			if(shared.data.wifiPass)
				return shared.data.wifiPass;
			else
				return "12345678";
		}
		public static function saveWifiPassword(password:String):void
		{
			shared.data.wifiPass = password;
			shared.flush();
		}
		
	}
}