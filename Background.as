package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Background extends MoveGameItem
	{


		public function Background(posX:Number, posY:Number, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super(posX, posY, width, height, rotation);
			this.addEventListener('MoveComplete',repeat);
		}

		public function repeat(evt:Event)
		{
			this.x = 0;
			this.y = 0;
		}
	}

}