package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Plane extends MoveGameItem implements IMoveItemConflict{
		
		protected var totalLife:Number;
		protected var curLife:Number;
		protected var bulletTypeArr:Array;
		
		public function Plane(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super(moveArea, posX, posY, speed, width, height, rotation);
			
		}
		
		protected function fire(){
			
		}
		
		public function hit(){};
		public function destory(){};


	}
	
}
