package  {
	
	import flash.display.MovieClip;
	
		import flash.events.Event;
	public class TwoBullet extends MyBullet {
		
		
		public function TwoBullet(moveArea:Object,posX:Number, posY:Number, speed:Number) {
			super(moveArea,posX,posY,speed );
			this.force = 2;
			this.moveWay = new LineMove(this,[2], [this.speed], [{x:posX, y:-this.height}])
		}
	}
	
}