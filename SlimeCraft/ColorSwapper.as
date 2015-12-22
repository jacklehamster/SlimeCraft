package  {
	
	import flash.display.MovieClip;
	
	
	public class ColorSwapper extends PlayerDependent {
		
		
		override protected function postInitialize():void {
			var colorFilters:Array = Swappers.Instance["player"+player+"Filter"].filters;
			filters = colorFilters;
		}
	}
	
}
