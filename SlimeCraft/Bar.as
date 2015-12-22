package  {
	
	public class Bar extends MC {

		public function set progress(value:Number):void {
			visible = value>0 && value<1;
			gotoAndStop(1 + Math.floor(value * totalFrames));
		}
		
		override protected function initialize():void {
			stop();
			visible = false;
		}

	}
	
}
