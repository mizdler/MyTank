package ir.baazino.mytank.connection
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.DatagramSocket;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	
	import mx.core.FlexGlobals;

	public class TCPServer
	{
		private var serverSocket:ServerSocket; 
		private var clientSocket:Socket;
		
		[Bindable]
		public static var traceMsg:String = "Server:\n";
		
		public function TCPServer(serverIP:String) 
		{ 
			try 
			{ 
				var isSupported:Boolean = ServerSocket.isSupported;
				var isSupported2:Boolean = DatagramSocket.isSupported;
				
				serverSocket = new ServerSocket(); 
				
				serverSocket.addEventListener( Event.CONNECT, connectHandler ); 
				serverSocket.addEventListener( Event.CLOSE, onClose ); 
				
				serverSocket.bind( ConnectionConfig.PORT ); 
				
				serverSocket.listen(); 
				trace( "Listening on " + serverSocket.localPort ); 
				traceMsg += "Listening on " + serverSocket.localPort + "\n";
				
			} 
			catch(e:SecurityError) 
			{ 
				trace(e); 
			} 
		} 
		
		public function connectHandler(event:ServerSocketConnectEvent):void 
		{ 
			clientSocket = event.socket as Socket; 
			
			clientSocket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler); 
			clientSocket.addEventListener( Event.CLOSE, onClientClose ); 
			clientSocket.addEventListener( IOErrorEvent.IO_ERROR, onIOError ); 
			
			clientSocket.writeUTFBytes("Connected."); 
			clientSocket.flush(); 
			
			trace( "Sending connect message" );
			traceMsg += "Sending connect message\n";
		} 
		
		public function socketDataHandler(event:ProgressEvent):void 
		{ 
			var socket:Socket = event.target as Socket 
			
			var message:String = socket.readUTFBytes( socket.bytesAvailable ); 
			trace( "Received: " + message); 
			traceMsg += "Received: " + message + "\n"
				
			message = "Echo -- " + message; 
			socket.writeUTFBytes( message ); 
			socket.flush(); 
			trace( "Sending: " + message );
			traceMsg +=  "Sending: " + message + "\n";
		} 
		
		private function onClientClose( event:Event ):void 
		{ 
			trace( "Connection to client closed." ); 
			traceMsg += "Connection to client closed.\n"
		} 
		
		private function onIOError( errorEvent:IOErrorEvent ):void 
		{ 
			trace( "IOError: " + errorEvent.text );
			traceMsg += "IOError: " + errorEvent.text + "\n"; 
		} 
		
		private function onClose( event:Event ):void 
		{ 
			trace( "Server socket closed by OS." ); 
			traceMsg += "Server socket closed by OS.\n";
		} 
		
		public function sendMsg(msg:String):void
		{
			clientSocket.writeUTFBytes(msg); 
			clientSocket.flush(); 
		}
	}
}