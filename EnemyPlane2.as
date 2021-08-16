
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane2 extends EnemyPlane{
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane2;
		private	var mustCombArr:Array = [EnemyBullet2, EnemyBullet2];
		public function EnemyPlane2(moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 40;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:this.moveArea.yMax}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr.concat());

		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var threeBulletArr:Array = [];
		
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(bulletComb.length==0){
					threeBulletArr[0].born(this.x - 20, this.y + 20);
					threeBulletArr[1].born(this.x + 20, this.y + 20);
					return;
				}
				if(bulletArr[i].isFreeze && (bulletArr[i] is bulletComb[0])){
			
					threeBulletArr.push(bulletArr[i]);
					trace("重复" + threeBulletArr);
					bulletComb.shift();
				}
			}
			
			// 新new
		
			var leftBullet:EnemyBullet2 = new mustCombArr[0](this.x - 20, this.y + 20, true);
			var rightBullet:EnemyBullet2 = new mustCombArr[1](this.x + 20, this.y + 20, false);
			
			
			bulletArr.push(leftBullet);
			bulletArr.push(rightBullet);
		
			stage.addChild(leftBullet);
			stage.addChild(rightBullet);
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

		
		
	}
	
}
