package  {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class PlayerEvent extends Event {

		static public const KEY_PRESS:String = "keypress";
		static public const CONFIRM:int = 0;
		static public const NEXT:int = 1;
		
		public var key:int;
		public var player:int;
		
		public function PlayerEvent(type:String, player:int, key:int) {
			super(type);
			this.player = player;
			this.key = key;
		}

		
	}
}
