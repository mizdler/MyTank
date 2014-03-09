package ir.baazino.mytank.connection
{
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.events.TimerEvent;
	import flash.net.DatagramSocket;
	import flash.net.GroupSpecifier;
	import flash.net.NetGroup;
	import flash.net.Responder;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.sampler.NewObjectSample;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.connection.TCPClient;
	import ir.baazino.mytank.connection.TCPServer;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.HOTSPOT_STATE;
	import ir.baazino.mytank.helper.Screens;
	import ir.baazino.mytank.helper.ServerMethods;
	import ir.baazino.mytank.screen.GameScreen;
	
	import mx.core.FlexGlobals;
	
	import org.osmf.events.TimeEvent;

	public class ConnectionManager
	{
		private static var _isConnectedToServer:Boolean;
		
		private static var serverIP:String;
		private static var datagramSocket:DatagramSocket;
		private static var serverSocket:ServerSocket;
		private static var clientSockets:Array = new Array(); 
		
		private static var isServer:Boolean;
		private static var timer:Timer;
		
		private static var server:TCPServer;
		private static var client:TCPClient;
		
		public function ConnectionManager()
		{
		}

		
		public static function get isConnectedToServer():Boolean
		{
			return _isConnectedToServer;
		}

		public static function set isConnectedToServer(value:Boolean):void
		{
			_isConnectedToServer = value;
		}
		
		public static function joinHotspot():void
		{
			isServer = false;
			Starter.textLog.text += "Activating Wifi...\n";
			Starter.textLog.invalidate();
			ANE.wifi.joinHotspot();
			
			var checkDelay:Timer = new Timer(1000);
			checkDelay.addEventListener(TimerEvent.TIMER, checkHotspot);
			checkDelay.start();
			
			function checkHotspot(event:TimerEvent):void
			{
				if(ANE.wifi.isWifiConnected())
				{
					checkDelay.stop();
					Starter.textLog.text += "Wifi Connected!\n";
					var dhcpInfo:String = ANE.wifi.getDhcpInfo();
					var splited:Array = dhcpInfo.split("/");
					Starter.textLog.text += "ServerIP : " + splited[0] + "\n";
					client = new TCPClient(splited[0]);
				}
			}
			
		}	
		
		public static function createHotspot():void
		{
			if(server != null)
				server.closeSocket();
			isServer = true;
			Starter.textLog.text += "Activating Hotspot...\n";
			trace("Activating Hotspot...");
			ANE.wifi.createHotspot();
				    
			var checkDelay:Timer = new Timer(1000);
			checkDelay.addEventListener(TimerEvent.TIMER, checkHotspot);
			checkDelay.start();
			
			function checkHotspot(event:TimerEvent):void
			{
				var state:String = ANE.wifi.getHotspotState();
				trace(state);
				if(state == HOTSPOT_STATE.WIFI_AP_STATE_ENABLED)
				{
					checkDelay.stop();
					Starter.textLog.text += "Hotspot Activated!\n";
					runServer();
				}
			}

		}
		
		public static function runServer():void
		{
			if(false)
				do{
					var dhcpInfo:String = ANE.wifi.getDhcpInfo();
					var splited:Array = dhcpInfo.split("/");
					trace(splited[0]);
				}while(splited[0] != "192.168.1.1")
			
			Starter.textLog.text += "Dhcp is Ok!\n";
			server = new TCPServer();
		}
		
		
		public static var c:Number = 0;
		public static function onReceive( event:ProgressEvent ):void 
		{
			var socket:Socket = event.target as Socket;
			if(socket.bytesAvailable<=0)
				return;
			var msg:String = socket.readUTFBytes(socket.bytesAvailable);
			//Starter.textLog.text += "> " + msg + "\n";
			
			if(msg.substr(0,4) == "upda"){
				c++;
				if(c==60){
					trace(c);
					Starter.textLog.text += "> " + c + "\n";
					c=0;
				}
			}
			else if(msg.substr(0,4) == "Star"){
				Starter.navigator.showScreen(Screens.gameId);
			}
			
		} 
		
		public static function sendTCP(msg:String):void
		{
			if(isServer)
				server.sendMsg(msg);
			else
				client.sendMsg(msg);
		}
		public static function closeSocket():void
		{
			if(server != null)
				server.closeSocket();
			if(client != null)
				client.closeSocket();
		}

	}
}