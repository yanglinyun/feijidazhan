package  {
	
	import flash.events.Event;
	
	public class EnemyBullet extends Bullet{
		
		
		public function EnemyBullet(moveArea:Object,posX:Number, posY:Number, speed:Number)  {
			super(moveArea,posX,posY,speed );
		}
		// protected function born(){
		// 	// this.x = Math.random() * (moveArea.x.scale - this.width) + moveArea.x.min;
		// 	// trace("randomBorn");
		// 	// this.y = 0;
		// 	this.isFreeze = false;
		// 	this.addEventListener('MoveComplete',freeze);
		// }
		// override protected function freeze(evt:Event) {
		// 	this.isFreeze = true;
		// 	this.removeEventListener('MoveComplete',freeze);
		// 	trace("freeze");
		// 	this.born();
		// }
	}
	
}
