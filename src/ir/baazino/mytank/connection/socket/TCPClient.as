package ir.baazino.mytank.connection.socket
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.connection.ConnectionManager;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Match;
	import ir.baazino.mytank.screen.WaitingScreen;

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
			socket.addEventListener(ProgressEvent.SOCKET_DATA, ConnectionManager.onTCPReceive);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
			
			socket.connect(serverIP, ConnectionConfig.TCP_PORT);
			WaitingScreen.textLog.text += "localIP : " + socket.localAddress + "\n";
			WaitingScreen.textLog.text += "connecting to server : " + serverIP + " ...\n";
			
			trace("connected to server " + serverIP);
		}
		
		private function onConnect(e:Event):void 
		{
			WaitingScreen.textLog.text += "connected to server!" + "\n";
			sendMsg(CMD.JOIN + "#" + Match.myId);
		}
		
		private function onReceived(e:ProgressEvent):void {
			date = new Date();
			WaitingScreen.textLog.text += date.milliseconds + "\n";
			if (socket.bytesAvailable > 0)
			{
				var msg:String = socket.readUTFBytes(socket.bytesAvailable);
				trace(msg);
				WaitingScreen.textLog.text += "received: " + msg + "\n";
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
			WaitingScreen.textLog.text += "socket closed\n";
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace("IO Error: " + e);
			WaitingScreen.textLog.text += "IO Error: " + e + "\n";
		}
		
		private function onSecError(e:SecurityErrorEvent):void 
		{
			trace("Security Error: "+e);
			WaitingScreen.textLog.text += "Security Error: " + e + "\n";
		}
		

		public function closeSocket():void
		{
			socket.close();
		}
	}
}