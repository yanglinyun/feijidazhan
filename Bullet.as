package  {
	
	public class Bullet extends MoveGameItem implements IMoveItemConflict{

		protected var force:Number;
		public function Bullet(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0) {
			super(moveArea, posX, posY, speed, width, height, rotation);
		}
		
		public function hit(){};
		public function destory(){};
		

	}
	
}
