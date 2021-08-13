
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	 import flash.utils.*;

	public class EnemyPlane1 extends EnemyPlane{
		
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane1;
		public function EnemyPlane1(moveArea:Object,speed:Number=3) {
			that =this;
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			//this.getChildByName("lifeBar").getChildByName("lifeBar").gotoAndStop(100);
			this.curLife = this.totalLife = 20;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:moveArea.y.max}])
			fireTimeOutId = setInterval(function(){
					that.fire();
				}, 1200)
		}

		override protected function fire() {
			var bullet:EnemyBullet1;
			for(var i:int=0; i<bulletArr.length; i++){
				if(bulletArr[i].isFreeze){
					trace("========重复利用========");
					bulletArr[i].born(this.x + this.width / 2, this.y);
					trace("========重复利用========");
					return;
				}
			}
			
			bullet = new EnemyBullet1(this.moveArea, this.x + this.width / 2, this.y, 3);
			bulletArr.push(bullet);
			stage.addChild(bullet);
			trace(stage);
			//trace('fire');
			//trace(bullet.x);
			//trace('================');
		}

		override public function bang(force:Number) {
			
			this.curLife -= force;
			trace("当前血量"+this.curLife)
			if(this.curLife<=0){
				this.play();
				this.isFreeze = false;
				this.randomBorn();
				timeOutId || clearTimeout(timeOutId);
			}else{
				this.gotoAndStop(2);
				(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(100 * (totalLife - curLife) / totalLife)
				timeOutId = setTimeout(function(){
					clearTimeout(timeOutId);
					that.gotoAndStop(1);
				}, 1000)
				
				//this.getChildByName("lifeBar").getChildByName("lifeBar").gotoAndStop(100 * curLife / totalLife)
			}
		}
		
	}
	
}
