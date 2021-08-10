package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Plane extends MoveGameItem implements IMoveItemConflict{
		
		protected var totalLife:Number;
		protected var curLife:Number;
		protected var bulletTypeArr:Array;
		
		public function Plane(posX:Number, posY:Number, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super(posX, posY, width, height, rotation);
			
		}
		
		protected function fire(){
			
		}
		
		public function hit(){};
		public function destory(){};


	}
	
}
