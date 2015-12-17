package  {
	import flash.text.TextField;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class BasePlayerButton extends PlayerDependent {
		
		override protected function initialize():void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			if(setting.ai) {
				visible = false
			} else {
				setting.addEventListener(Event.CHANGE, playerSettingsUpdate);
				playerSettingsUpdate();
			}
		}
		
		override protected function destroy():void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			setting.removeEventListener(Event.CHANGE, playerSettingsUpdate);
		}

		override public function get player():int {
			return name.split("key_")[1].split("_")[0];
		}

		public function get key():int {
			return name.split("key_")[1].split("_")[1];
		}
		
		protected function get textField():TextField {
			return null;
		}
		
		private function playerSettingsUpdate(e:Event = null):void {
			var setting:PlayerSetting = PlayerSetting.GetSetting(player);
			if(textField) {
				textField.text = setting.charKeys[key];
			}
		}
	}
	
}
