package  {
		
	public class EnemyBullet1 extends EnemyBullet {
			
		public function EnemyBullet1(moveArea:Object,posX:Number, posY:Number, speed:Number) {
			super(moveArea,posX,posY,speed );
			this.force = 2;
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:posX, y:-this.height}])
		}
	}
	
}
