package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class CarrotCounter extends Counter {
		
		
		override public function get player():int {
			return name.split("carrotCounter")[1];
		}
		
		override protected function initialize():void {
			super.initialize();
			var setting:PlayerSetting = PlayerSetting.GetSetting(this.player);
			if(setting.ai) {
				visible = false;
			} else {
				setting.addEventListener(Event.CHANGE, updateCounter);
				updateCounter();
			}
		}
		
		override protected function destroy():void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(this.player);
			setting.removeEventListener(Event.CHANGE, updateCounter);
		}
		
		private function updateCounter(e:Event = null):void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(this.player);
			tf.text = "x" + setting.carrots;
		}
		
	}
	
}
