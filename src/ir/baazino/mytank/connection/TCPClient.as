package ir.baazino.mytank.connection
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	public class TCPClient
	{
		private var socket:Socket;
		[Bindable]
		public static var traceMsg:String = "Client:\n";
		
		public function TCPClient(serverIP:String)
		{
			socket = new Socket();
			
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onReceived);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			
			socket.connect(serverIP, ConnectionConfig.PORT);
			
			trace("connected to server " + serverIP);
			traceMsg += "connected to server " + serverIP + "\n";
		}
		
		private function onConnect(e:Event):void 
		{
			socket.writeUTFBytes("salam server");
			socket.flush();
			traceMsg += "message sent\n";
		}
		
		private function onClose(e:Event):void 
		{
			socket.close();
			traceMsg += "socket closed\n";
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace("IO Error: "+e);
			traceMsg += "IO Error: " + e + "\n";
		}
		
		private function onSecError(e:SecurityErrorEvent):void 
		{
			trace("Security Error: "+e);
			traceMsg += "Security Error: " + e + "\n";
		}
		
		private function onReceived(e:ProgressEvent):void {
			if (socket.bytesAvailable>0) {
				var msg:String = socket.readUTFBytes(socket.bytesAvailable);
				trace(msg);
				traceMsg += "received: " + msg + "\n";
			}
		}
		
		public function sendMsg(msg:String):void
		{
			socket.writeUTFBytes(msg); 
			socket.flush(); 
		}
	}
}