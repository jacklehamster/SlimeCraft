package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class HUD extends PlayerDependent {
		
		static private var HUDs:Object = {};
		
		static public function GetHud(player:int):HUD {
			return HUDs["hud" + player];
		}
		
		override protected function initialize():void {
			HUDs[name] = this;
			active = false;
			stop();
		}
		
		override public function get player():int {
			return name.split("hud")[1];
		}
		
		public function show(state:String):void {
			if(state!="KO") {
				active = true;
				visible = playerSetting.ai == 0;
				gotoAndPlay(1);
				zicon.gotoAndStop(state);
				var switcher:ActionSwitch = zicon[zicon.currentLabel + "Switcher"];
				switcher.gotoAndStop(1);
				addEventListener(Event.ENTER_FRAME,updateCoster);
				moreVegetables.visible = false;
				moreQueens.visible = false;
			}
		}
		
		public function hide():void {
			moreVegetables.visible = false;
			moreQueens.visible = false;
			gotoAndPlay("HIDE");
			removeEventListener(Event.ENTER_FRAME,updateCoster);
		}
		
		private function updateCoster(e:Event):void {
			var switcher:ActionSwitch = zicon[zicon.currentLabel + "Switcher"];
			var label:String = switcher.currentLabel;
			var description:String = Config.DESC[label];
			var cost:int = Config.COST[label];
			var coster:MovieClip = zicon.coster;
			coster.visible = cost!=0 && description!=null;
			if(coster.visible) {
				coster.tf_desc.text = description;
				coster.tf.text = cost.toString();
			}
		}
		
		public function switchSelection():void {
			moreVegetables.visible = false;
			moreQueens.visible = false;
			var switcher:ActionSwitch = zicon[zicon.currentLabel + "Switcher"];
			switcher.play();
		}
		
		public function get action():String {
			var switcher:ActionSwitch = zicon[zicon.currentLabel + "Switcher"];
			return switcher.currentLabel;
		}
	}
	
}
