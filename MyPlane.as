package  {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class MyPlane extends Plane{

		public function MyPlane(moveArea:Object) {
			super(0,0);
			// 居中显示
			midDisplay(moveArea);
			this.gotoAndStop(1);
			this.addEventListener(KeyboardEvent.KEY_DOWN,keyUpFunction);
			
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
		private function keyUpFunction(evt:KeyboardEvent):void{
			trace(evt.keyCode);
			switch(evt.keyCode){
				case 37: // left
					this.x -= 2;
					break;
				case 38: // up
					this.y -= 2;
					break;
				case 39: // right
					this.x += 2;
					break;
				case 40: // down
					this.y += 2;
					break;
				case 32: // space
					this.fire();
					break;
			}
		} 

	}
	
}
