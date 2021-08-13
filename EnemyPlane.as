package  {
	
	import flash.events.Event;
		import flash.display.MovieClip;
	public class EnemyPlane extends Plane{
		
		
		public function EnemyPlane(moveArea:Object,speed:Number)  {
			super(moveArea,0,0,speed );
			this.randomBorn();
			this.gotoAndStop(1);
		}
		protected function randomBorn(){
			(((getChildByName("lifeBar")  as MovieClip ).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
			this.x = Math.random() * (moveArea.x.scale - this.width) + moveArea.x.min;
			trace("randomBorn");
			this.gotoAndStop(1);
			this.curLife = this.totalLife;
			this.y = 0;
			this.isFreeze = false;
			
		}
		override public function bang(force:Number) {
			this.curLife -= force;
			trace("当前血量"+this.curLife)
		}
		override protected function freeze(evt:Event) {
			this.isFreeze = true;
			
			trace("freeze");
			this.randomBorn();
		}
	}
	
}
