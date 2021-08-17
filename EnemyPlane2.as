
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
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:150}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr.concat());

		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var _mustCombArr:Array = [EnemyBullet2, EnemyBullet2];
			var threeBulletArr:Array = [];
			//trace("============================");
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(_mustCombArr.length==0 && threeBulletArr[0].isLeft && !threeBulletArr[1].isLeft){
					threeBulletArr[0].born(this.x - 20, this.y + 20);
					threeBulletArr[1].born(this.x + 20, this.y + 20);
					stage.addChild(threeBulletArr[0]);
					stage.addChild(threeBulletArr[1]);
					return;
				}
				
				if(bulletArr[i].isFreeze && (bulletArr[i] is EnemyBullet2)){
			
					threeBulletArr.push(bulletArr[i]);
					
					_mustCombArr.shift();
					//trace("重复", i);
				}
			}
			//trace("============================");
			
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

		override protected function freeze(evt:Event) {
			// 静止
			this.removeEventListener('MoveComplete',freeze);
		}

		
		
	}
	
}
