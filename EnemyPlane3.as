
package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.*;

	public class EnemyPlane3 extends EnemyPlane{
		private var timeOutId:uint;
		
		private var that:EnemyPlane3;
		private	var mustCombArr:Array = [EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3, EnemyBullet3];
		public function EnemyPlane3(posX:Number, posY:Number,moveArea:MoveArea=null,speed:Number=3) {
			that = this;
			super(posX,posY,moveArea,speed );
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.curLife = this.totalLife = 40;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:150}])
			fireTimeOutId = setInterval(fireThreeBullet, 400, mustCombArr.concat());

		}

		public function myReBorn(posX:Number, posY:Number) {
			reBorn(posX, posY);
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
					
					
					GameItem.stage.addChild(threeBulletArr[0]);
					GameItem.stage.addChild(threeBulletArr[1]);
					GameItem.stage.addChild(threeBulletArr[2]);
					GameItem.stage.addChild(threeBulletArr[3]);
					GameItem.stage.addChild(threeBulletArr[4]);
			
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
			
			GameItem.stage.addChild(b1);
			GameItem.stage.addChild(b2);
			GameItem.stage.addChild(b3);
			GameItem.stage.addChild(b4);
			GameItem.stage.addChild(b5);
		}

	

		override protected function freeze(evt:Event=null) {
			// 静止
			this.removeEventListener('MoveComplete',freeze);
		}
		
		
	}
	
}
