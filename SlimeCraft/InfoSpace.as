package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	
	
	public class InfoSpace extends MC {
		
		public function get textfield():TextField {
			return tf as TextField;
		}
		
		public function get sceneLayer():SceneLayer {
			return (parent as ScreenView).sceneLayer;
		}
		
		override protected function initialize():void {
			if(Config.DEBUG) {
				addEventListener(Event.ENTER_FRAME, onFrame);
			} else {
				visible = false;
			}
		}
		
		private function onFrame(e:Event):void {
			textfield.text = sceneLayer.position + ". zoom:" + sceneLayer.zoom;
		}
	}
	
}
