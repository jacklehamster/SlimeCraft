package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MC extends MovieClip {

		private var postInitialized:Boolean = false;
		
		private var _active:Boolean = true;
		public function set active(value:Boolean):void {
			visible = _active = value;
		}
		
		public function get active():Boolean {
			return _active;
		}
		
		public function MC() {
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE,
				function(e:Event):void {
					initialize();
				}
			);
			addEventListener(Event.REMOVED_FROM_STAGE,
				function(e:Event):void {
					destroy();
					removeEventListener(Event.ENTER_FRAME,_refresh);
				}
			);
			addEventListener(Event.ENTER_FRAME,_refresh);
		}
		
		private function _refresh(e:Event):void {
			if(!root) {
				removeEventListener(Event.ENTER_FRAME,_refresh);
				return;
			}
			refresh();
			if(!postInitialized) {
				postInitialize();
				postInitialized = true;
			}
		}
		
		protected function refresh():void {
			removeEventListener(Event.ENTER_FRAME,_refresh);
		}
		
		protected function initialize():void {
			
		}
		
		protected function postInitialize():void {
			
		}
		
		protected function destroy():void {
			
		}

	}
	
}
