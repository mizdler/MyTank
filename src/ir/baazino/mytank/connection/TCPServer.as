package ir.baazino.mytank.connection
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.DatagramSocket;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Match;
	
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
				
				Starter.textLog.text += "socketSupported: " + socketSupported + "\n";
				Starter.textLog.text += "UDPSupported: " + UDPSupported + "\n";
				
				serverSocket = new ServerSocket(); 
				
				serverSocket.addEventListener(Event.CONNECT, connectHandler); 
				serverSocket.addEventListener(Event.CLOSE,onClose); 
				
				serverSocket.bind(ConnectionConfig.TCP_PORT);
				serverSocket.listen(); 
				localIP = serverSocket.localAddress;
				Starter.textLog.text += "localIP : " + serverSocket.localAddress + "\n";
				trace( "TCP Listening on " + serverSocket.localPort ); 
				Starter.textLog.text += "TCP Listening on " + serverSocket.localPort + "\n";
				
			} 
			catch(e:ErrorEvent)
			{
				Starter.textLog.text += e.text + "\n";
				trace(e); 
			} 
		} 
		
		public function connectHandler(event:ServerSocketConnectEvent):void 
		{ 
			clientSocket = event.socket as Socket;
			remoteIP = clientSocket.remoteAddress;
			clientSocket.addEventListener( ProgressEvent.SOCKET_DATA, ConnectionManager.onReceive); 
			clientSocket.addEventListener( Event.CLOSE, onClientClose ); 
			clientSocket.addEventListener( IOErrorEvent.IO_ERROR, onIOError ); 
			sendMsg(CMD.join + "/" + Match.myId);		
			
			trace( "Sending connect message" );
			Starter.textLog.text += "Sending connect message\n";
		} 
		
		public function socketDataHandler(event:ProgressEvent):void 
		{ 
			var socket:Socket = event.target as Socket 
			
			var message:String = socket.readUTFBytes( socket.bytesAvailable ); 
			trace( "Received: " + message); 
			Starter.textLog.text += "Received: " + message + "\n"
				
			message = "Echo -- " + message; 
			socket.writeUTFBytes( message ); 
			socket.flush(); 
			trace( "Sending: " + message );
			Starter.textLog.text +=  "Sending: " + message + "\n";
		} 
		
		private function onClientClose( event:Event ):void 
		{ 
			trace( "Connection to client closed." ); 
			Starter.textLog.text += "Connection to client closed.\n"
		} 
		
		private function onIOError( errorEvent:IOErrorEvent ):void 
		{ 
			trace( "IOError: " + errorEvent.text );
			Starter.textLog.text += "IOError: " + errorEvent.text + "\n"; 
		} 
		
		private function onClose( event:Event ):void 
		{ 
			trace( "Server socket closed by OS." ); 
			Starter.textLog.text += "Server socket closed by OS.\n";
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