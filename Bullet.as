package  {
		import flash.events.Event;
	public class Bullet extends MoveGameItem implements IMoveItemConflict{

		protected var force:Number = 10;
		public function Bullet(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0) {
			super(moveArea, posX, posY, speed, width, height, rotation);
			this.addEventListener('MoveComplete',freeze);
		}
		
		public function hit(target:*){
			if(this.hitTestObject(target)){
				trace("hit")
				target.bang(this.force);
				this.isFreeze = true;
				GameItem.stage.removeChild(this);
				trace(GameItem.stage);
			}
		};
		public function destory(){};
		public function born(posX:Number, posY:Number){
			// this.x = Math.random() * (moveArea.x.scale - this.width) + moveArea.x.min;
			// trace("randomBorn");
			// this.y = 0;
			this.isFreeze = false;
	
			this.addEventListener('MoveComplete',freeze);
			
			this.x = posX;
			this.y = posY;
			trace(GameItem.stage);
			GameItem.stage.addChild(this);
			
		}
		override protected function freeze(evt:Event) {
			this.isFreeze = true;
			this.removeEventListener('MoveComplete',freeze);
			trace("freeze");
			
		}

		

		

	}
	
}
