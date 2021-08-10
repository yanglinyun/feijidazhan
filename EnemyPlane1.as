package  {
	
	import flash.events.Event;
	
	
	public class EnemyPlane1 extends EnemyPlane{
	
		public function EnemyPlane1(moveArea:Object,speed:Number) {
			super(moveArea,speed );
			this.moveWay = new LineMove(this,[6], [this.speed], [{x:960, y:moveArea.y.max}])
		}
		
	}
	
}
