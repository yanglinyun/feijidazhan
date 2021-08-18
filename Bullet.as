package  {
		import flash.events.Event;
	public class Bullet extends MoveGameItem implements IMoveItemConflict{

		protected var force:Number = 10;
		private var _moveArea:MoveArea;
		
		public function Bullet(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0) {
			this._moveArea = new MoveArea(
				GameItem.ScreenWidth, 
				MoveGameItem.panel.width-50,
				GameItem.ScreenHeight,
				0
			)
			super(_moveArea, posX, posY, speed, width, height, rotation);
			this.addEventListener('MoveComplete',freeze);
		}
		
		public function hit(target:*):Boolean{
			if(this.hitTestObject(target)){
				
				target.bang(this.force);
				this.isFreeze = true;
				if(GameItem.stage.contains(this)){
					GameItem.stage.removeChild(this);
				}
				//trace(GameItem.stage);
				return true;
			}
			return false;
		};
		public function destory(){};
		public function born(posX:Number, posY:Number){
			// this.x = Math.random() * (moveArea.x.scale - this.width) + moveArea.x.min;
			// //trace("randomBorn");
			// this.y = 0;
			this.isFreeze = false;
	
			this.addEventListener('MoveComplete',freeze);
			
			this.x = posX;
			this.y = posY;
		
			GameItem.stage.addChild(this);
			
		}
		override protected function freeze(evt:Event=null) {
			this.isFreeze = true;
			if(GameItem.stage.contains(this)){
				stage.removeChild(this);
			}
			this.removeEventListener('MoveComplete',freeze);
		
			
		}

		

		

	}
	
}
