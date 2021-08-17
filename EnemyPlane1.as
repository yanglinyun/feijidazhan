
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
			this.curLife = this.totalLife = 40;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:this.moveArea.yMax}])
			fireTimeOutId = setInterval(fire, 400, EnemyBullet1);

		}

		override protected function fire(bulletType:*) {
			var bullet:EnemyBullet1;
			for(var i:int=0; i<bulletArr.length; i++){
				if(bulletArr[i].isFreeze && (bulletArr[i] is bulletType)){
					bulletArr[i].born(this.x, this.y + this.height - 20);
					stage.addChild(bulletArr[i]);
					return;
				}
			}
			
			bullet = new bulletType(this.moveArea, this.x, this.y + this.height  - 20, 8);
			bulletArr.push(bullet);
			stage.addChild(bullet);
		}

		
		
	}
	
}
