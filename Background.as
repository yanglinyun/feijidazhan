package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Background extends MoveGameItem
	{
		public function Background(moveArea:Object=null, posX:Number = 0, posY:Number = 0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super(moveArea, posX, posY, speed, width, height, rotation);
			this.addEventListener('MoveComplete',repeat);
			this.moveWay = new LineMove(this,[2], [this.speed], [{x:0, y:-1200}]);
		}
		
		public function repeat(evt:Event)
		{
			this.x = 0;
			this.y = 0;
		}
	}

}