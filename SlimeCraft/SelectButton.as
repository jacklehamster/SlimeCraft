package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class SelectButton extends MC {
		
		public function get player():int {
			return name.split("setAI_")[1].split("_")[0];
		}
		
		public function get aiValue():int {
			return name.split("setAI_")[1].split("_")[1];
		}
		
		override protected function initialize():void {
			mouseChildren = false;
			mouseEnabled = true;
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_DOWN,onClick);
		}
		
		override protected function postInitialize():void {
			updateButton();
		}
		
		override protected function destroy():void {
			removeEventListener(MouseEvent.MOUSE_DOWN,onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			
			Config.AI[player] = aiValue;
			updateButton();
		}
		
		public function updateButton():void {
			if(Config.AI[player]==aiValue) {
				var rect:Rectangle = getRect(parent);
				var sel:MovieClip = MovieClip(parent)["sel"+player] as MovieClip;
				sel.x = rect.x-10;
				sel.y = rect.y-10;
				sel.width = rect.width+20;
				sel.height = rect.height+30;
			}
		}
	}
	
}
