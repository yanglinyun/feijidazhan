
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane4 extends EnemyPlane{
		private var timeOutId:uint;
		private var fireTimeOutId:uint;
		private var that:EnemyPlane4;
		private	var mustCombArr:Array = [EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4];
		public function EnemyPlane4(posX:Number, posY:Number,moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(posX,posY,moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 80;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:150}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr.concat());

		}

		private function fireThreeBullet(bulletComb:Array) {
			var bullet:*;
			var _mustCombArr:Array = [EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4, EnemyBullet4];
			var threeBulletArr:Array = [];
			//trace("============================");
			for(var i:int=0; i<bulletArr.length; i++){
				
				if(_mustCombArr.length==0 
				&& threeBulletArr[0].degree ==5 
				&& threeBulletArr[1].degree ==5.5
				&& threeBulletArr[2].degree ==6
				&& threeBulletArr[3].degree ==6
				&& threeBulletArr[4].degree ==6
				&& threeBulletArr[5].degree ==6
				&& threeBulletArr[6].degree ==6
				&& threeBulletArr[7].degree ==6.5
				&& threeBulletArr[8].degree ==7 
				){
					threeBulletArr[0].born(this.x -40, this.y + this.height  - 40);
					threeBulletArr[1].born(this.x -30, this.y + this.height  - 10);
					threeBulletArr[2].born(this.x -15 , this.y + this.height -10);
					threeBulletArr[3].born(this.x -10, this.y + this.height + 30);
					threeBulletArr[4].born(this.x , this.y + this.height + 30);
					threeBulletArr[5].born(this.x +10, this.y + this.height + 30);
					threeBulletArr[6].born(this.x +15, this.y + this.height -10);
					threeBulletArr[7].born(this.x +30, this.y + this.height  -10);
					threeBulletArr[8].born(this.x +40, this.y + this.height  -40);
					
					stage.addChild(threeBulletArr[0]);
					stage.addChild(threeBulletArr[1]);
					stage.addChild(threeBulletArr[2]);
					stage.addChild(threeBulletArr[3]);
					stage.addChild(threeBulletArr[4]);
					stage.addChild(threeBulletArr[5]);
					stage.addChild(threeBulletArr[6]);
					stage.addChild(threeBulletArr[7]);
					stage.addChild(threeBulletArr[8]);
			
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
		
			var b1:EnemyBullet4 = new mustCombArr[0](this.x -40, this.y + this.height  - 40, 5);
			var b2:EnemyBullet4 = new mustCombArr[1](this.x -30, this.y + this.height  - 10, 5.5);
			var b3:EnemyBullet4 = new mustCombArr[2](this.x -15 , this.y + this.height -10, 6);
			var b4:EnemyBullet4 = new mustCombArr[3](this.x -10, this.y + this.height + 30, 6);
			var b5:EnemyBullet4 = new mustCombArr[4](this.x , this.y + this.height + 30, 6);
			var b6:EnemyBullet4 = new mustCombArr[5](this.x +10, this.y + this.height + 30, 6);
			var b7:EnemyBullet4 = new mustCombArr[6](this.x +15, this.y + this.height -10, 6);
			var b8:EnemyBullet4 = new mustCombArr[7](this.x +30, this.y + this.height  -10, 6.5);
			var b9:EnemyBullet4 = new mustCombArr[8](this.x +40, this.y + this.height  -40, 7);
			

			bulletArr.push(b1,b2,b3,b4,b5,b6,b7,b8,b9);
			
			stage.addChild(b1);
			stage.addChild(b2);
			stage.addChild(b3);
			stage.addChild(b4);
			stage.addChild(b5);
			stage.addChild(b6);
			stage.addChild(b7);
			stage.addChild(b8);
			stage.addChild(b9);
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
