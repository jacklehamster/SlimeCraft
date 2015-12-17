package  {
	import flash.geom.Point;
	
	public class Layer extends PlayerDependent {

		public function get Player():int {
			return (parent as SceneLayer).Player;
		}
		
		public function coverageWidth():Number {
			return stage.stageWidth / 4 * zoom;
		}
		
		public function coverageHeight():Number {
			return stage.stageHeight / 4 * zoom * 2;
		}
		
		public function get position():Point {
			return (parent as SceneLayer).position;
		}
		public function get zoom():Number {
			return (parent as SceneLayer).zoom;
		}

	}
	
}
