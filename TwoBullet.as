package  {
	
	import flash.display.MovieClip;
	
		import flash.events.Event;
	public class TwoBullet extends MyBullet {
		
		
		public function TwoBullet(moveArea:Object=null,posX:Number=0, posY:Number=0, speed:Number=10) {
			super(moveArea,posX,posY,speed );
			this.force = 8;
			this.moveWay = new LineMove(this,[2], [speed], [{x:0, y:-this.height}])
		}
	}
	
}