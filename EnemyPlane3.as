
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane3 extends EnemyPlane{
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane3;
		private	var mustCombArr:Array = [EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3];
		public function EnemyPlane3(moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 40;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:150}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr.concat());

		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var _mustCombArr:Array = [EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3];
			var threeBulletArr:Array = [];
			//trace("============================");
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(_mustCombArr.length==0 && threeBulletArr[0].degree ==5 
				&& threeBulletArr[1].degree ==5.5
				&& threeBulletArr[2].degree ==6
				&& threeBulletArr[3].degree ==6.5
				&& threeBulletArr[4].degree ==7 ){
					threeBulletArr[0].born(this.x -40, this.y + this.height  - 40);
					threeBulletArr[1].born(this.x -10, this.y + this.height  - 10);
					threeBulletArr[2].born(this.x , this.y + this.height);
					threeBulletArr[3].born(this.x +10, this.y + this.height  - 10);
					threeBulletArr[4].born(this.x +40, this.y + this.height  - 40);
					
					
					stage.addChild(threeBulletArr[0]);
					stage.addChild(threeBulletArr[1]);
					stage.addChild(threeBulletArr[2]);
					stage.addChild(threeBulletArr[3]);
					stage.addChild(threeBulletArr[4]);
			
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
		
			var b1:EnemyBullet3 = new mustCombArr[0](this.x -40, this.y + this.height  - 40, 5);
			var b2:EnemyBullet3 = new mustCombArr[1](this.x -10, this.y + this.height  - 10, 5.5);
			var b3:EnemyBullet3 = new mustCombArr[2](this.x , this.y + this.height, 6);
			var b4:EnemyBullet3 = new mustCombArr[3](this.x +10, this.y + this.height  -10, 6.5);
			var b5:EnemyBullet3 = new mustCombArr[4](this.x +40, this.y + this.height  -40, 7);
			

			bulletArr.push(b1,b2,b3,b4,b5);
			
			stage.addChild(b1);
			stage.addChild(b2);
			stage.addChild(b3);
			stage.addChild(b4);
			stage.addChild(b5);
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
