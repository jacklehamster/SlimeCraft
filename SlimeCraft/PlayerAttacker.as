package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class PlayerAttacker extends PlayerDependent {
		
		static public var _playerAttackers:Array = [];
		
		override protected function initialize():void {
			_playerAttackers[player] = this;
			stop();
			active = false;
		}
		
		static public function Get(player:int):PlayerAttacker {
			return _playerAttackers[player];
		}
		
		override public function get player():int {
			return name.split("attacker")[1];
		}
		
		public function show(state:String):void {
			active = true;
			visible = playerSetting.ai == 0;
			gotoAndPlay(1);
			attackSwitch.icon.gotoAndStop(state.toUpperCase());
		}
		
		
		public function switchSelection():void {
			attackSwitch.play();
		}
		
		public function get attackSwitch():AttackSwitch {
			return getChildByName("attackSwitch"+player) as AttackSwitch;
		}
		
		public function hide():void {
			gotoAndPlay("HIDE");
			addEventListener(Event.ENTER_FRAME,
				function(e:Event):void {
					if(currentFrame==totalFrames) {
						active = false;
						gotoAndStop(1);
						e.currentTarget.removeEventListener(e.type,arguments.callee);
					}
				});
		}
		
	}
	
}
