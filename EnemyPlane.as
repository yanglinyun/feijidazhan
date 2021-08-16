package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;

	public class EnemyPlane extends Plane{
		private var _moveArea:MoveArea;
		
		public function EnemyPlane(moveArea:MoveArea,speed:Number)  {
			this._moveArea = new MoveArea(
				GameItem.ScreenWidth, 
				MoveGameItem.panel.width-50,
				GameItem.ScreenHeight,
				0
			)
			super(_moveArea,0,0,speed );
			this.randomBorn();
			this.gotoAndStop(1);
		}
		protected function randomBorn(){
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.x = 20 + Math.random() * (moveArea.xScale - this.width - 20) + moveArea.xMin;
			trace("randomBorn");
			this.gotoAndStop(1);
			this.curLife = this.totalLife;
			this.y = 0;
			this.isFreeze = false;
			
		}
		override public function bang(force:Number) {
			this.curLife -= force;
			trace("当前血量"+this.curLife)
		}
		override protected function freeze(evt:Event) {
			this.isFreeze = true;
			this.randomBorn();
		}
	}
	
}
