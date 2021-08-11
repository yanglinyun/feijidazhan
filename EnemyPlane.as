package  {
	
	import flash.events.Event;
	
	public class EnemyPlane extends Plane{
		
		
		public function EnemyPlane(moveArea:Object,speed:Number)  {
			super(moveArea,0,0,speed );
			this.randomBorn();
			this.gotoAndStop(1);
		}
		protected function randomBorn(){
			this.x = Math.random() * (moveArea.x.scale - this.width) + moveArea.x.min;
			trace("randomBorn");
			this.y = 0;
			this.isFreeze = false;
			this.addEventListener('MoveComplete',freeze);
		}
		override protected function freeze(evt:Event) {
			this.isFreeze = true;
			this.removeEventListener('MoveComplete',freeze);
			trace("freeze");
			this.randomBorn();
		}
	}
	
}
