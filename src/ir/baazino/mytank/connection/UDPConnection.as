package ir.baazino.mytank.connection
{ 
	import flash.display.Sprite;
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	
	public class UDPConnection extends Sprite 
	{ 
		private var udpSocket:DatagramSocket;
		private var localIP:String;
		private var targetIP:String;
		
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
			trace("Received from " + event.srcAddress + ":" + event.srcPort + "> " + 
				event.data.readUTFBytes( event.data.bytesAvailable ) ); 
		}
		private function send(msg:String):void
		{
			var data:ByteArray = new ByteArray(); 
			data.writeUTFBytes(msg); 
			udpSocket.send(data);
		}
	}}