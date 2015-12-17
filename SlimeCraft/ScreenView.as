package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class ScreenView extends PlayerDependent {
		
		override public function get player():int {
			return Player;
		}
		
		public function get sceneLayer():SceneLayer {
			return _sceneLayer;
		}

		private var _player:int = 0;
		public function get Player():int {
			if(!_player) {
				_player = name.split("sceneView")[1];
			}
			return _player;
		}
		
		private var mousePoint:Point = null;
		override protected function initialize():void {
			mouseEnabled = true;
			addEventListener(MouseEvent.MOUSE_DOWN,onMouse);
		}
		
		private function onMouse(e:MouseEvent):void {
			switch(e.type) {
				case MouseEvent.MOUSE_DOWN:
					stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouse);
					stage.addEventListener(MouseEvent.MOUSE_UP, onMouse);
					mousePoint = new Point(e.stageX, e.stageY);
					break;
				case MouseEvent.MOUSE_UP:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouse);
					stage.removeEventListener(MouseEvent.MOUSE_UP, onMouse);
					break;
				case MouseEvent.MOUSE_MOVE:
					sceneLayer.position.x -= (e.stageX - mousePoint.x)/2 * sceneLayer.zoom;
					sceneLayer.position.y -= (e.stageY - mousePoint.y) * sceneLayer.zoom;
					mousePoint = new Point(e.stageX, e.stageY);
					break;
			}
			e.updateAfterEvent();
		}
	}
	
}
