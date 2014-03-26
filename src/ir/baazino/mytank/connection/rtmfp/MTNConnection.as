package ir.baazino.mytank.connection.rtmfp
{
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	
	import ir.baazino.mytank.connection.ConnectionConfig;

	public class MTNConnection extends NetConnection
	{
		private var groupSpecifier:GroupSpecifier;
		private var isLocal:Boolean;
		private var mGroup:MTNGroup;
		private var serverAddr:String;
		
		public function MTNConnection(_isLocal:Boolean)
		{
			this.isLocal = _isLocal;
			if(isLocal)
				serverAddr = ConnectionConfig.LOCAL_ADDR;
			else
				serverAddr = ConnectionConfig.SERVER_ADDR;
			this.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		public function connect():void 
		{
			super.connect(serverAddr);
		}
		
		public function joinGroup(groupName:String):void
		{
			groupSpecifier = new GroupSpecifier(groupName);
			groupSpecifier.serverChannelEnabled = true;
			groupSpecifier.multicastEnabled = true;
			groupSpecifier.ipMulticastMemberUpdatesEnabled = true;
			groupSpecifier.postingEnabled = true;
			groupSpecifier.routingEnabled = true;
			if(isLocal)
				groupSpecifier.addIPMulticastAddress(ConnectionConfig.MULTICAST_ADDR);
			
			var groupspec:String = groupSpecifier.groupspecWithAuthorizations();
			mGroup = new MTNGroup(this, groupspec);
			mGroup.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			var code:String = event.info.code;
			switch(code)
			{
				case "NetConnection.Connect.Success":
					break;
				case "NetGroup.Connect.Success":
					break;
				case "NetGroup.Neighbor.Connect":
					break;
				case "NetGroup.SendTo.Notify":
					break;
				case "NetGroup.Neighbor.Disconnect":
					break;
		}
	}
}