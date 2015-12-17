package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	
	public class Inline extends PlayerDependent {
		
		override protected function initialize():void 
		{
			visible = false;
			gotoAndStop(player);
			Game.Instance.addEventListener(PlayerEvent.KEY_PRESS,onKey);
		}
		
		override protected function destroy():void {
			Game.Instance.removeEventListener(PlayerEvent.KEY_PRESS,onKey);
		}
		
		public function get PlayerButton():BasePlayerButton {
			return (parent as BasePlayerButton);
		}
		
		private function onKey(e:PlayerEvent):void {
			if(PlayerButton.key ==  e.key && e.player == player) {
				visible = true;
				alpha = 1;
			}
		}
		
		override protected function refresh():void {
			if(visible) {
				alpha -= .1;
				if(alpha <= 0) {
					visible = false;
				}
			}
		}
		
	}
	
}
