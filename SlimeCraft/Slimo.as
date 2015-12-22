package  {
	
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	
	
	public class Slimo extends Element {

		static public var frameStructure:Object; 
		override protected function initialize():void {
			if(!frameStructure) {
				frameStructure = {};
				for(var i:int = 0; i<this.currentLabels.length; i++) {
					var frameLabel:FrameLabel = currentLabels[i];
					var nextFrame:int = i==currentLabels.length-1 ? totalFrames+1 : (currentLabels[i+1] as FrameLabel).frame;
					frameStructure[frameLabel.name] = [];
					for(var frame:int = frameLabel.frame; frame < nextFrame; frame++) {
						frameStructure[frameLabel.name].push(frame);
					}
				}
			}
		}
		
		public var state:String;
		public var transformation:String;
		public var updatedTime:int;
		public var frameOrigin:int;
		private var _player:int;
		
		public function set player(value:int):void {
			_player = value;
		}
		
		public function get player():int {
			return _player;
		}
		
		override protected function refresh():void {
			var frames:Array = frameStructure[transformation ? transformation : state];
			if(frames) {
				var frame:int = transformation ? frames[Math.min(Math.floor((Game.Instance.frame - frameOrigin) / Config.FRAME_LIMIT[transformation]),frames.length-1)]
					: frames[Math.floor((Game.Instance.frame - frameOrigin) / Config.FRAME_LIMIT[state])% frames.length];
				gotoAndStop(frame);
				switch(state) {
					case "Egg":
						var progress:Number = (Game.Instance.frame - updatedTime) / Config.EGG_SPAWN;
						break;
				}
			}
		}
		
		public function update(state:String, updatedTime:int, frameOrigin:int):void {
			this.state = state;
			this.updatedTime = updatedTime;
			this.frameOrigin = frameOrigin;
		}
		
		public function forceRefresh():void {
			refresh();
		}
	}
	
}
