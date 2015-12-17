package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class Game extends MC {
		private var _frame:int = 0;
		static public var Instance:Game;
		public var playerCount:int;
		
		public function Game():void {
			Instance = this;
		}
		
		override protected function initialize():void {
			Instance = this;
			playerCount = 4;
			stage.focus = this;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
			for(var player:int = 1; player<=4; player++) {
				var setting:PlayerSetting = PlayerSetting.GetSetting(player);
				setting.init();
				setting.setKeys(Config.KEYS[player][0][0],Config.KEYS[player][1][0],
								Config.KEYS[player][0][1],Config.KEYS[player][1][1]);
				setting.addCarrot(20);
//				setting.addCarrot(35);
				setting.setAI(Config.AI[player]);
			}
			mouseEnabled = mouseChildren = true;
		}
		
		override protected function destroy():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
		}
		
		private function onKey(e:KeyboardEvent):void {
			for(var player:int = 1; player<=4; player++) {
				var ps:PlayerSetting = PlayerSetting.GetSetting(player);
				if(e.keyCode==ps.keys[0]) {
					dispatchEvent(new PlayerEvent(PlayerEvent.KEY_PRESS, player, 0))
				} else if(e.keyCode==ps.keys[1]) {
					dispatchEvent(new PlayerEvent(PlayerEvent.KEY_PRESS, player, 1))
				}
			}
		}
		
		override protected function refresh():void {
			_frame++;
			var player:int;
			var ps:PlayerSetting;
			if(frame%100==0) {
				for(player = 1; player<=4; player++) {
					ps = PlayerSetting.GetSetting(player);
					ps.addCarrot(1);
					if(ps.ai) {
						ps.addCarrot(ps.ai==1?1:ps.ai==2?2:5);
					}
				}
			}
			if(frame%3==0) {
				player = 1+(frame / 3)%4;
				ps = PlayerSetting.GetSetting(player);
				if(ps.ai>0) {
					if(Math.random()<.5) {
						dispatchEvent(new PlayerEvent(PlayerEvent.KEY_PRESS, player, 1))
					} else if(Math.random()<.5) {
						dispatchEvent(new PlayerEvent(PlayerEvent.KEY_PRESS, player, 0))
					}
				}
			}
/*			if(frame%100==0) {
				player = 1+(frame / 100)%4;
				var sceneLayer:SceneLayer = SceneLayer.GetSceneLayer(player);
				sceneLayer.zoom = 1 / (ObjectMap.Instance.countUnits(null,player)+7);
			}*/
			ObjectMap.Instance.process();
		}
		
		public function get frame():int {
			return _frame;
		}
	}
	
}
