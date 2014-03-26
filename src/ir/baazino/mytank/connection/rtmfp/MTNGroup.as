package ir.baazino.mytank.connection.rtmfp
{
	import flash.net.NetConnection;
	import flash.net.NetGroup;

	public class MTNGroup extends NetGroup
	{
		public function MTNGroup(connection:MTNConnection, groupspec:String)
		{
			super(connection, groupspec);
		}
	}
}