package  {
	
	import flash.events.Event;
	
	public class MyBullet1 extends MyBullet{
		
		
		public function MyBullet1(moveArea:Object,posX:Number, posY:Number, speed:Number)  {
			super(moveArea,posX,posY,speed );
			this.moveWay = new LineMove(this,[2], [this.speed], [{x:960, y:moveArea.y.min}])
		}

		
		
	}
	
}
