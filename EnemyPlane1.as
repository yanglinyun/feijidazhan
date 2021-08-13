
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class EnemyPlane1 extends EnemyPlane{
	
		public function EnemyPlane1(moveArea:Object,speed:Number=3) {
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			//this.getChildByName("lifeBar").getChildByName("lifeBar").gotoAndStop(100);
			this.curLife = this.totalLife = 20;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:moveArea.y.max}])
		}
		override public function bang(force:Number) {
			this.curLife -= force;
			trace("当前血量"+this.curLife)
			if(this.curLife<=0){
				this.play();
				this.isFreeze = false;
				this.randomBorn();
			}else{
				this.gotoAndStop(2);
					this.gotoAndStop(2);
				(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(100 * curLife / totalLife)
				//this.getChildByName("lifeBar").getChildByName("lifeBar").gotoAndStop(100 * curLife / totalLife)
			}
		}
		
	}
	
}
