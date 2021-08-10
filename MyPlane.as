package  {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class MyPlane extends Plane{


		private var keyObj:Object = {};
		
		private var keyArr:Array = [];
		
		public function MyPlane(moveArea:Object,speed:Number) {
			super(moveArea,0,0,speed );
			// 居中显示
			midDisplay(moveArea);
			this.gotoAndStop(1);
			this.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			this.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			this.totalLife = this.curLife = 800;
		}
		private function midDisplay(moveArea:Object){
			trace(moveArea.y.max, this.height);
			this.x = moveArea.x.min + moveArea.x.scale / 2 - this.width / 2;
			this.y = moveArea.y.max - this.height;
			trace(this.x, this.y);
			
		}
		override protected function fire() {
			trace('fire');
		}
		public function KeyDownHandler(e:KeyboardEvent)
		{
			nextPosX = this.x;
			nextPosY = this.y;
			keyObj[e.keyCode] = true;

			if (keyObj[32])
			{
				trace("space");
				this.fire();
				//role.y -=  3 * speed;
			}
			if (keyObj[37])
			{
				trace("left");
				nextPosX-=  this.speed;
				this.gotoAndStop(5);
			}
			if (keyObj[38])
			{
				trace("down");
				nextPosY -=  this.speed;
				
			}
			if (keyObj[39])
			{
				trace("right");
				this.gotoAndStop(3);
				nextPosX +=  this.speed;
			}

			if (keyObj[40])
			{
				trace("up");
				nextPosY +=  this.speed;
			}
			this.judgeMoveArea()
			e.updateAfterEvent();
		}

		public function KeyUpHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = false;
			e.updateAfterEvent();
		}

	}
	
}
