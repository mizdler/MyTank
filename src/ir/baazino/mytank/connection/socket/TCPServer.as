package ir.baazino.mytank.connection.socket
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.DatagramSocket;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Match;
	import ir.baazino.mytank.screen.WaitingScreen;
	
	import mx.core.FlexGlobals;

	public class TCPServer
	{
		private var serverSocket:ServerSocket; 
		private var clientSocket:Socket;
		public var localIP:String;
		public var remoteIP:String;
		
		public function TCPServer() 
		{ 
			try 
			{
				var socketSupported:Boolean = ServerSocket.isSupported;
				var UDPSupported:Boolean = DatagramSocket.isSupported;
				
				WaitingScreen.textLog.text += "socketSupported: " + socketSupported + "\n";
				WaitingScreen.textLog.text += "UDPSupported: " + UDPSupported + "\n";
				
				serverSocket = new ServerSocket(); 
				
				serverSocket.addEventListener(Event.CONNECT, connectHandler); 
				serverSocket.addEventListener(Event.CLOSE,onClose); 
				
				serverSocket.bind(ConnectionConfig.TCP_PORT);
				serverSocket.listen(); 
				localIP = serverSocket.localAddress;
				WaitingScreen.textLog.text += "localIP : " + serverSocket.localAddress + "\n";
				trace( "TCP Listening on " + serverSocket.localPort ); 
				WaitingScreen.textLog.text += "TCP Listening on " + serverSocket.localPort + "\n";
				
			} 
			catch(e:ErrorEvent)
			{
				WaitingScreen.textLog.text += e.text + "\n";
				trace(e);
			} 
		} 
		
		public function connectHandler(event:ServerSocketConnectEvent):void 
		{ 
			clientSocket = event.socket as Socket;
			remoteIP = clientSocket.remoteAddress;
			clientSocket.addEventListener( ProgressEvent.SOCKET_DATA, ConnectionManager.onTCPReceive); 
			clientSocket.addEventListener( Event.CLOSE, onClientClose ); 
			clientSocket.addEventListener( IOErrorEvent.IO_ERROR, onIOError ); 
			sendMsg(CMD.JOIN + "/" + Match.myId);		
			
			trace( "Sending connect message" );
			WaitingScreen.textLog.text += "Sending connect message\n";
		} 
		
		public function socketDataHandler(event:ProgressEvent):void 
		{ 
			var socket:Socket = event.target as Socket 
			
			var message:String = socket.readUTFBytes( socket.bytesAvailable ); 
			trace( "Received: " + message); 
			WaitingScreen.textLog.text += "Received: " + message + "\n"
				
			message = "Echo -- " + message; 
			socket.writeUTFBytes( message ); 
			socket.flush(); 
			trace( "Sending: " + message );
			WaitingScreen.textLog.text +=  "Sending: " + message + "\n";
		} 
		
		private function onClientClose( event:Event ):void 
		{ 
			trace( "Connection to client closed." ); 
			WaitingScreen.textLog.text += "Connection to client closed.\n"
		} 
		
		private function onIOError( errorEvent:IOErrorEvent ):void 
		{ 
			trace( "IOError: " + errorEvent.text );
			WaitingScreen.textLog.text += "IOError: " + errorEvent.text + "\n"; 
		} 
		
		private function onClose( event:Event ):void 
		{ 
			trace( "Server socket closed by OS." ); 
			WaitingScreen.textLog.text += "Server socket closed by OS.\n";
		} 
		
		public function sendMsg(msg:String):void
		{
			if(clientSocket == null)
				return;
			clientSocket.writeUTFBytes(msg); 
			clientSocket.flush(); 
		}
		public function closeSocket():void
		{
			if(clientSocket != null)
				clientSocket.close();
			if(serverSocket != null)
				serverSocket.close();
		}
	}
}