package ir.baazino.mytank.map
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Parser
	{
		private var json:URLLoader;
		private var data:Object;
		
		public function Parser(name:String)
		{
			json.load(new URLRequest("/../assets/maps/"+name+"/"+name+".json");
			json.addEventListener(Event.COMPLETE, decode);
		}
		
		private function decode():void
		{
			data = JSON.parse(json.data);
		}

		public function get(key:String)
		{
		}
	}
}