
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane1 extends EnemyPlane{
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane1;
		private	var mustCombArr:Array = [TwoBullet, ThreeBullet, ThreeBullet];;
		public function EnemyPlane1(moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 20;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:this.moveArea.yMax}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr);

		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var threeBulletArr:Array = [];
		
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(mustCombArr.length==0){
					break;// 查询完毕
				}
				if(bulletArr[i].isFreeze && (bulletArr[i] is mustCombArr[0])){
			
					threeBulletArr.push(bulletArr[i]);
					mustCombArr.shift();
				}
			}
			if(mustCombArr.length==0) {
				threeBulletArr[0].born(this.x + this.width / 2, this.y);
				threeBulletArr[1].born(this.x + this.width / 2 - 30, this.y + 20);
				threeBulletArr[2].born(this.x + this.width / 2 + 30, this.y + 20);
				return;
			}
			
			// 新new
			var twoBullet:TwoBullet = new bulletComb[0](this.x + this.width / 2, this.y);
			var leftThreeBullet:ThreeBullet = new bulletComb[1](this.x + this.width / 2 - 30, this.y + 20);
			var rightThreeBullet:ThreeBullet = new bulletComb[2](this.x + this.width / 2 + 30, this.y + 20);
			
			
			bulletArr.push(twoBullet);
			bulletArr.push(leftThreeBullet);
			bulletArr.push(rightThreeBullet);

		
			stage.addChild(twoBullet);
			stage.addChild(leftThreeBullet);
			stage.addChild(rightThreeBullet);
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
