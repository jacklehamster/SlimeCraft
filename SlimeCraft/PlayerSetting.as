package  {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class PlayerSetting extends EventDispatcher {
		
		static private var _playerSettings:Array = [];
		
		public var keys:Array = [];
		public var charKeys:Array = [];
		public var selection:String = null;
		public var carrots:int = 0;
		public var ai:int = 0;
		
		public function init():void {
			keys = [];
			ai = 0;
			selection = null;
			carrots = 0;
		}

		static public function GetSetting(player:int):PlayerSetting {
			if(!_playerSettings[player]) {
				_playerSettings[player] = new PlayerSetting();
			}
			return _playerSettings[player];
		}

		public function setKeys(key1:int, key2:int, char1:String, char2:String):void {
			keys = [key1, key2];
			charKeys = [char1, char2];
			broadcastUpdate();
		}
		
		public function setAI(value:int):void {
			ai = value;
			broadcastUpdate();
		}
		
		public function addCarrot(num:int):void {
			carrots+=num;
			broadcastUpdate();
		}
		
		private function broadcastUpdate():void {
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
}
