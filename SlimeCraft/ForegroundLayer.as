package  {
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	
	
	public class ForegroundLayer extends Layer {
		
		
		
		override protected function postInitialize():void {
			Game.Instance.addEventListener(PlayerEvent.KEY_PRESS,onKey);
		}
		
		override protected function destroy():void {
			Game.Instance.removeEventListener(PlayerEvent.KEY_PRESS,onKey);
		}
		
		private function onKey(e:PlayerEvent):void {
			if(e.player == this.Player) {
				var hud:HUD = HUD.GetHud(Player);
				var attacker:PlayerAttacker = PlayerAttacker.Get(Player);
				if(e.key==PlayerEvent.NEXT) {
					if(attacker.active) {
						attacker.switchSelection();
					} else if(hud.active) {
						hud.switchSelection();
					} else {
						var next:String = ObjectMap.Instance.nextUnit(playerSetting.selection, Player);
						playerSetting.selection = next;
					}
				} else if(e.key==PlayerEvent.CONFIRM) {
					var unit:UnitElement = ObjectMap.Instance.GetUnit(playerSetting.selection);
					if(attacker.active) {
						if(unit) {
							unit.performAttack(attacker.attackSwitch.currentLabel);
						}
						attacker.hide();
					} else if(hud.active) {
						var action:String = hud.action;
						if(unit) {
							if(action=="LAY" && ObjectMap.Instance.countUnits("Queen",Player)*5<=
								ObjectMap.Instance.countUnits("Egg",Player)) {
								hud.moreQueens.visible = true;
							} else if(!unit.canPerformAction(action)) {
								hud.moreVegetables.visible = true;
								return;
							}
							unit.performAction(action);
						}
						hud.hide();
					} else {
						if(unit) {
							hud.show(unit.state);
						}
					}
				}
			}
		}
		
		public function addUnit(unit:UnitElement):void {
			var child:Slimo = SetSprite(unit.id, Slimo, unit.x, unit.y) as Slimo;
			child.update(unit.state,0, unit.frameOrigin);
			child.transformation = unit.transformation;
			child.player = Config.UNCOLORED[child.state] ? 0 : unit.player;
			if(unit.state=="KO" || unit.transformation) {
				child.progressbar.visible = false;
			} else if(unit.life < unit.MAXLIFE) {
				child.progressbar.progress = unit.life / unit.MAXLIFE;
			}
			child.forceRefresh();
		}
		
		public function selectUnit(unit:UnitElement):void {
			var select:Selector = SetSprite("select_"+this.Player, Selector, unit.x, unit.y, true) as Selector;
			select.gotoAndStop(Player);
			select.visible = true;
		}
		
		public function markUnit(unit:UnitElement, addedElems:Object):void {
			var id:String = "mark_"+unit.id;
			addedElems[id] = true;
			var markor:Markor = SetSprite(id, Markor, unit.x, unit.y) as Markor;
			markor.gotoAndStop(unit.player);
			markor.visible = true;
		}
		
		private function deselect():void {
			var select:Selector = getChildByName("select_"+Player) as Selector;
			if(select) {
				select.visible = false;
			}
		}
		
		public function SetSprite(id:String, classObj:Class, x:Number, y:Number, progressive:Boolean = false):Element {
			var child:Element = getChildByName(id) as Element;
			if(!child || !(child is classObj)) {
				child = new classObj();
				child.name = id;
				addChild(child);
			}
			var scaleFactor:Number = .1/zoom;
			var xx:Number = (x - position.x)*20*scaleFactor;
			var yy:Number = (y - position.y)*10*scaleFactor;
			child.x += (xx-child.x) * (progressive?.9:1);
			child.y += (yy-child.y) * (progressive?.9:1);
			child.scaleX = child.scaleY = scaleFactor/4;
			return child;
		}
		
		private function cleanUnits(addedElems:Object):void {
			for(var i:int = numChildren-1; i>=0; i--) {
				var child:DisplayObject = getChildAt(i);
				if((child is Slimo || child is Markor) && !addedElems[child.name]) {
					removeChildAt(i);
				}
			}
		}
		
		override protected function refresh():void {
			if(!playerSetting.selection) {
				playerSetting.selection = ObjectMap.Instance.nextUnit(null, player);
			}
			var objMap:ObjectMap = ObjectMap.Instance;
			var rect:Rectangle = new Rectangle();
			rect.x = position.x - 5/zoom/10;
			rect.y = position.y - 5/zoom/10;
			rect.width = coverageWidth() + 10/zoom/10;
			rect.height = coverageHeight() + 10/zoom/10;
			var elements:Vector.<MapElement> = objMap.GetElements(rect);
			
			var addedElems:Object = {};
			for each(var unit:UnitElement in elements) {
				addedElems[unit.id] = true;
				addUnit(unit);
				if(playerSetting.selection==unit.id && playerSetting.ai==0) {
					selectUnit(unit);
				} else if(unit.attackingPlayer) {
					//markUnit(unit, addedElems);
				}
			}
			if(!addedElems[playerSetting.selection]) {
				deselect();
			}
			cleanUnits(addedElems);
		}
	}
}
