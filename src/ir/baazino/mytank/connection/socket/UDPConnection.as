package ir.baazino.mytank.connection.socket
{ 
	import flash.display.Sprite;
	import flash.events.DatagramSocketDataEvent;
	import flash.events.Event;
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	import ir.baazino.mytank.connection.ConnectionConfig;
	import ir.baazino.mytank.helper.CMD;
	import ir.baazino.mytank.info.Actor;
	import ir.baazino.mytank.info.Match;
	
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
			udpSocket.addEventListener(DatagramSocketDataEvent.DATA, onUDPReceive); 
			udpSocket.bind(ConnectionConfig.UDP_PORT, localIP); 
			udpSocket.connect(targetIP, ConnectionConfig.UDP_PORT);
			udpSocket.receive();
		}
		
		private function onUDPReceive(event:DatagramSocketDataEvent):void 
		{
			var msg:String = event.data.readUTFBytes(event.data.bytesAvailable);
			trace(msg + "\n");
			var splited:Array = msg.split("#");
			var cmd:String = splited[0];
			var id:String = splited[1];
			var actor:Actor = Match.playerMap[id] as Actor;
			
			if(cmd == CMD.UPDATE)
			{
				actor.x = splited[2];
				actor.y = splited[3];
				actor.rotation = splited[4];
				actor.isMoving = splited[5]=="true"?true:false;
				actor.shoot = splited[6]=="true"?true:false;
			}
		}
		public function sendMsg(msg:String):void
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(msg);
			udpSocket.send(data);
		}
		public function closeSocket():void
		{
			if(udpSocket != null)
				udpSocket.close();
		}
	}}