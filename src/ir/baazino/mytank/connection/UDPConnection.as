package ir.baazino.mytank.connection
{ 
	import flash.display.Sprite;
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Match;
	
	public class UDPConnection extends Sprite 
	{ 
		private var udpSocket:DatagramSocket;
		private var localIP:String;
		private var targetIP:String;
		public static var c:Number = 0;
		
		public function UDPConnection(localIP:String, targetIP:String) 
		{
			this.localIP = localIP;
			this.targetIP = targetIP;
		}
		public function connect():void
		{
			udpSocket = new DatagramSocket(); 
			udpSocket.addEventListener(DatagramSocketDataEvent.DATA, onReceive); 
			udpSocket.bind(ConnectionConfig.UDP_PORT, localIP); 
			udpSocket.connect(targetIP, ConnectionConfig.UDP_PORT);
			udpSocket.receive();
		}
		
		private function onReceive(event:DatagramSocketDataEvent):void 
		{
			var msg:String = event.data.readUTFBytes(event.data.bytesAvailable);
			var splited:Array = msg.split("/");
			var cmd:String = splited[0];
			var id:String = splited[1];
			if(cmd == CMD.update)
			{
				Match.playerMap[id].x = splited[2];
				Match.playerMap[id].y = splited[3];
				Match.playerMap[id].rotation = splited[4];
				Match.playerMap[id].isMoving = splited[5];
			}
		}
		public function sendMsg(msg:String):void
		{
			var data:ByteArray = new ByteArray(); 
			data.writeUTFBytes(msg); 
			udpSocket.send(data);
		}
	}}