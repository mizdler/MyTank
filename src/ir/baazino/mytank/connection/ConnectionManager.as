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
	import ir.baazino.mytank.connection.rtmfp.MTNConnection;
	import ir.baazino.mytank.connection.socket.TCPClient;
	import ir.baazino.mytank.connection.socket.TCPServer;
	import ir.baazino.mytank.connection.socket.UDPConnection;
	import ir.baazino.mytank.game.element.Player;
	import ir.baazino.mytank.helper.ANE;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.helper.HOTSPOT_STATE;
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.helper.SERVER_FUNCTION;
	import ir.baazino.mytank.helper.Storage;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	import ir.baazino.mytank.screen.GameScreen;
	import ir.baazino.mytank.screen.WaitingScreen;
	
	import mx.core.FlexGlobals;
	
	import org.osmf.events.TimeEvent;

	public class ConnectionManager
	{
		public static const SERVER_ID:String = "0";
		public static const CLIENT_ID:String = "1";
		
		private static var datagramSocket:DatagramSocket;
		private static var serverSocket:ServerSocket;
		private static var clientSockets:Array = new Array(); 
		
		private static var isServer:Boolean;
		private static var timer:Timer;
		
		private static var server:TCPServer;
		private static var client:TCPClient;
		private static var udp:UDPConnection;
		
		private static var mConnection:MTNConnection;
		private static var isRTMFP:Boolean;

		public static function joinHotspot():void
		{
			isServer = false;
			WaitingScreen.textLog.text += "Activating Wifi...\n";
			WaitingScreen.textLog.invalidate();
			
			if(Starter.isIOS)
				checkWifi(null);
			else
			{
				ANE.wifi.joinHotspot(Storage.loadWifiPassword());
				var checkTimer:Timer = new Timer(1000);
				checkTimer.addEventListener(TimerEvent.TIMER, checkWifi);
				checkTimer.start();
			}
			
			function checkWifi(event:TimerEvent):void
			{
				if(ANE.wifi.isWifiConnected())
				{
					if(checkTimer != null)
						checkTimer.stop();
					Match.myId = CLIENT_ID;
					Match.playerMap[SERVER_ID] = new Actor();
					Match.playerMap[Match.myId] = new Actor();
					WaitingScreen.textLog.text += "Wifi Connected!\n";
					var dhcpInfo:String = ANE.wifi.getDhcpInfo();
					var splited:Array = dhcpInfo.split("#");
					var serverIP:String = splited[0];
					if(Starter.isIOS)
						serverIP = serverIP.substr(0, serverIP.lastIndexOf(".")) + ".1";
					WaitingScreen.textLog.text += "ServerIP : " + serverIP + "\n";
					WaitingScreen.textLog.text += "ClientIP : " + splited[1] + "\n";
					client = new TCPClient(serverIP);
					udp = new UDPConnection(splited[1], serverIP);
					udp.connect();
				}
				else if(Starter.isIOS)
					ANE.wifi.showWifiAlert();
			}
			
		}	
		
		public static function createHotspot():void
		{
			if(server != null)
				server.closeSocket();
			isServer = true;
			WaitingScreen.textLog.text += "Activating Hotspot...\n";
			trace("Activating Hotspot...");
			ANE.wifi.createHotspot(Storage.loadWifiPassword());
				    
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
					WaitingScreen.textLog.text += "Hotspot Activated!\n";
					server = new TCPServer();
				}
			}

		}
		
		public static function connectLocal():void
		{
			isRTMFP = true;
			mConnection = new MTNConnection(true);
			mConnection.connectNet();
		}
		
		public static function onTCPReceive(event:ProgressEvent):void 
		{
			var socket:Socket = event.target as Socket;
			if(socket.bytesAvailable<=0)
				return;
			var msg:String = socket.readUTFBytes(socket.bytesAvailable);
			var splited:Array = msg.split("#");
			var cmd:String = splited[0];
			var id:String = splited[1];
			
			switch(cmd)
			{
				case CMD.JOIN:
					Match.playerMap[id] = new Actor();
					udp = new UDPConnection(server.localIP, server.remoteIP);
					udp.connect();
					break;
				case CMD.START:
					Starter.navigator.showScreen(SCREEN.GAME);
					break;
			}
			
		} 
		
		public static function sendMsg(msg:String):void
		{
			if(isRTMFP)
				mConnection.sendMsg(msg);
			else
			{
				if(msg.substr(0,4)==CMD.UPDATE)
					sendUDP(msg);
				else
					sendTCP(msg);
			}
		}
		
		private static function sendTCP(msg:String):void
		{
			if(isServer)
				server.sendMsg(msg);
			else
				client.sendMsg(msg);
		}
		
		private static function sendUDP(msg:String):void
		{
			udp.sendMsg(msg);
		}
		
		private static function sendRTMFP(msg:String):void
		{
			mConnection.sendMsg(msg);
		}
		
		public static function closeTCP():void
		{
			if(server)
				server.closeSocket();
			if(client)
				client.closeSocket();
		}
		
		public static function closeUDP():void
		{
			if(udp)
				udp.closeSocket();
		}
		
		public static function closeRTMFP():void
		{
			if(mConnection)
				mConnection.closeRTMFP();
		}
		
	}
}