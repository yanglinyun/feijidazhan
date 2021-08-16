
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane1 extends EnemyPlane{
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane1;
		public function EnemyPlane1(moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 20;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:this.moveArea.yMax}])
			fireTimeOutId = setInterval(function(){
					that.fire(EnemyBullet1);
				}, 800)
		}

		override protected function fire(bulletType:*) {
			var bullet:EnemyBullet1;
			for(var i:int=0; i<bulletArr.length; i++){
				if(bulletArr[i].isFreeze && (bulletArr[i] is bulletType)){
					bulletArr[i].born(this.x, this.y + this.height - 20);
					return;
				}
			}
			
			bullet = new bulletType(this.moveArea, this.x, this.y + this.height  - 20, 8);
			bulletArr.push(bullet);
			stage.addChild(bullet);
		}

		override public function bang(force:Number) {
			
			this.curLife -= force;
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(100 * (totalLife - curLife) / totalLife)
			trace("当前血量"+this.curLife)
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
		
	}
	
}
