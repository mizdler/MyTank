package ir.baazino.mytank.connection
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Match;

	public class TCPClient
	{
		private var socket:Socket;
		public var date:Date;
		
		public function TCPClient(serverIP:String)
		{
			socket = new Socket();
			
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, ConnectionManager.onReceive);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			
			socket.connect(serverIP, ConnectionConfig.TCP_PORT);
			Starter.textLog.text += "localIP : " + socket.localAddress + "\n";
			Starter.textLog.text += "connecting to server : " + serverIP + " ...\n";
			
			trace("connected to server " + serverIP);
		}
		
		private function onConnect(e:Event):void 
		{
			Starter.textLog.text += "connected to server!" + "\n";
			sendMsg(CMD.join + "/" + Match.myId);
		}
		
		private function onReceived(e:ProgressEvent):void {
			date = new Date();
			Starter.textLog.text += date.milliseconds + "\n";
			if (socket.bytesAvailable > 0)
			{
				var msg:String = socket.readUTFBytes(socket.bytesAvailable);
				trace(msg);
				Starter.textLog.text += "received: " + msg + "\n";
			}
		}
		
		public function sendMsg(msg:String):void
		{
			socket.writeUTFBytes(msg); 
			socket.flush();
		}
		
		private function onClose(e:Event):void 
		{
			socket.close();
			Starter.textLog.text += "socket closed\n";
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace("IO Error: " + e);
			Starter.textLog.text += "IO Error: " + e + "\n";
		}
		
		private function onSecError(e:SecurityErrorEvent):void 
		{
			trace("Security Error: "+e);
			Starter.textLog.text += "Security Error: " + e + "\n";
		}
		

		public function closeSocket():void
		{
			socket.close();
		}
	}
}