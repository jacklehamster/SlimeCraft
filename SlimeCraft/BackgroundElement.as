package  {
	
	public class BackgroundElement extends MapElement {

		private var _id:String;
		public function get id():String {
			if(!_id) {
				_id = x + "_" + y;
			}
			return _id;
		}
		
		static public var _recycler:Vector.<BackgroundElement> = new Vector.<BackgroundElement>();
		
		static public function create():BackgroundElement {
			if(_recycler.length) {
				return _recycler.pop();
			} else {
				return new BackgroundElement();
			}
		}
		
		static public function destroy(elem:BackgroundElement):void {
			_recycler.push(elem);
		}
		
		public var rotation:Number;

	}
	
}
