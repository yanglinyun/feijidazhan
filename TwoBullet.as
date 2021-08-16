package  {
	
	import flash.display.MovieClip;
	
		import flash.events.Event;
	public class TwoBullet extends MyBullet {
		
		
		public function TwoBullet(posX:Number=0, posY:Number=0, moveArea:Object=null, speed:Number=10) {
			super(moveArea,posX,posY,speed );
			this.force = 10;
			this.moveWay = new LineMove(this,[2], [speed], [{x:0, y:-this.height}])
		}
	}
	
}