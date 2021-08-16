package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;
	
	public class EnemyPlane extends Plane{
		private var _moveArea:MoveArea;
		private var that:EnemyPlane;
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
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
			that = this;
		}
		protected function randomBorn(){
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.x = 20 + Math.random() * (moveArea.xScale - this.width - 20) + moveArea.xMin;
			//trace("randomBorn");
			this.gotoAndStop(1);
			this.curLife = this.totalLife;
			this.y = 0;
			this.isFreeze = false;
			
		}
		override public function bang(force:Number) {
			
			this.curLife -= force;
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(100 * (totalLife - curLife) / totalLife)
			//trace("当前血量"+this.curLife)
			if(this.curLife<=0){
				that.gotoAndStop(3);
				// timeOutId || clearTimeout(timeOutId);
				panel.updateScore(that.totalLife);
				timeOutId = setTimeout(function(){
					clearTimeout(timeOutId);
					that.isFreeze = false;
					that.randomBorn();
				}, 100)
			}else{
				this.gotoAndStop(2);
				
				timeOutId = setTimeout(function(){
					clearTimeout(timeOutId);
					that.gotoAndStop(1);
				}, 1000)
			}
		}
		override protected function freeze(evt:Event) {
			this.isFreeze = true;
			this.randomBorn();
		}
	}
	
}
