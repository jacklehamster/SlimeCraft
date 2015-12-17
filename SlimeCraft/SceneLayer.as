package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class SceneLayer extends PlayerDependent {
		
		static public var _sceneLayers:Array = [];
		
		public var position:Point = new Point();
		public var zoom:Number = .1;
		
		public function get Player():int {
			return (parent as ScreenView).Player;
		}
		
		static public function GetSceneLayer(player:int):SceneLayer {
			return _sceneLayers[player];
		}
		
		override protected function initialize():void {
			_sceneLayers[Player] = this;
			position.setTo.apply(position,Config.STARTING_POSITIONS[Player]);
			if(Config.DEBUG) {
				stage.addEventListener(KeyboardEvent.KEY_DOWN,
					function(e:KeyboardEvent):void {
						if(e.keyCode==Keyboard.Z) {
	//						zoom -= .01;
						}
					});
			}
		}
	}
	
}
