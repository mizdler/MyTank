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
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.connection.socket.TCPClient;
	import ir.baazino.mytank.connection.socket.TCPServer;
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.HOTSPOT_STATE;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.ServerMethods;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	import ir.baazino.mytank.screen.GameScreen;
	
	import mx.core.FlexGlobals;
	
	import org.osmf.events.TimeEvent;
	import ir.baazino.mytank.connection.socket.TCPClient;
	import ir.baazino.mytank.connection.socket.TCPServer;
	import ir.baazino.mytank.connection.socket.UDPConnection;

	public class ConnectionManager
	{
		private static var serverIP:String;
		private static var datagramSocket:DatagramSocket;
		private static var serverSocket:ServerSocket;
		private static var clientSockets:Array = new Array(); 
		
		private static var isServer:Boolean;
		private static var timer:Timer;
		
		private static var server:TCPServer;
		private static var client:TCPClient;
		private static var udp:UDPConnection;
		
		public static const SERVER_ID:String = "0";
		public static const CLIENT_ID:String = "1";
		
		
		public function ConnectionManager()
		{
		}

		public static function joinHotspot():void
		{
			isServer = false;
			Starter.textLog.text += "Activating Wifi...\n";
			Starter.textLog.invalidate();
			ANE.wifi.joinHotspot();
			
			var checkTimer:Timer = new Timer(1000);
			checkTimer.addEventListener(TimerEvent.TIMER, checkWifi);
			checkTimer.start();
			
			function checkWifi(event:TimerEvent):void
			{
				if(ANE.wifi.isWifiConnected())
				{
					checkTimer.stop();
					Match.myId = CLIENT_ID;
					Match.playerMap[SERVER_ID] = new Actor();
					Match.playerMap[Match.myId] = new Actor();
					Starter.textLog.text += "Wifi Connected!\n";
					var dhcpInfo:String = ANE.wifi.getDhcpInfo();
					var splited:Array = dhcpInfo.split("/");
					Starter.textLog.text += "ServerIP : " + splited[0] + "\n";
					Starter.textLog.text += "ClientIP : " + splited[1] + "\n";
					client = new TCPClient(splited[0]);
					udp = new UDPConnection(splited[1], splited[0]);
					udp.connect();
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
				    
			var checkTimer:Timer = new Timer(1000);
			checkTimer.addEventListener(TimerEvent.TIMER, checkHotspot);
			checkTimer.start();
			
			function checkHotspot(event:TimerEvent):void
			{
				var state:String = ANE.wifi.getHotspotState();
				trace(state);
				if(state == HOTSPOT_STATE.WIFI_AP_STATE_ENABLED)
				{
					checkTimer.stop();
					Match.myId = SERVER_ID;
					Match.playerMap[Match.myId] = new Actor();
					Starter.textLog.text += "Hotspot Activated!\n";
					server = new TCPServer();
				}
			}

		}
		
		public static function onReceive(event:ProgressEvent):void 
		{
			var socket:Socket = event.target as Socket;
			if(socket.bytesAvailable<=0)
				return;
			var msg:String = socket.readUTFBytes(socket.bytesAvailable);
			var splited:Array = msg.split("#");
			var cmd:String = splited[0];
			var id:String = splited[1];
			
			if(cmd == CMD.join)
			{
				Match.playerMap[id] = new Actor();
				udp = new UDPConnection(server.localIP, server.remoteIP);
				udp.connect();
			}
			else if(cmd == CMD.start)
			{
				Starter.navigator.showScreen(SCREEN.game);
			}
			
		} 
		
		public static function sendTCP(msg:String):void
		{
			if(isServer)
				server.sendMsg(msg);
			else
				client.sendMsg(msg);
		}

		public static function closeTCP():void
		{
			if(server != null)
				server.closeSocket();
			if(client != null)
				client.closeSocket();
		}
		
		public static function sendUDP(msg:String):void
		{
			if(udp != null)
				udp.sendMsg(msg);
		}
		public static function closeUDP():void
		{
			if(udp != null)
				udp.closeSocket();
		}

	}
}