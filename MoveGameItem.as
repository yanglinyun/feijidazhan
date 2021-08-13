package 
{
	import flash.events.Event;
	public class MoveGameItem extends GameItem
	{
		public var speed:Number;
		protected var moveArea:Object;
		protected var nextPosX:Number;
		protected var nextPosY:Number
		protected var moveWay:Move;
		public var isFreeze:Boolean = false;
		public function MoveGameItem(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super( posX, posY, width, height, rotation);
			this.speed = speed;
			this.moveArea = moveArea;
			this.isFreeze = false;
			this.addEventListener('MoveComplete',freeze);
		}
		
		protected function judgeMoveArea(){
			if(nextPosX<this.moveArea.x.min || nextPosX>this.moveArea.x.max-this.width){
				nextPosX = (nextPosX<this.moveArea.x.min)?this.moveArea.x.min:this.moveArea.x.max-this.width;
			}
			if(nextPosY<this.moveArea.y.min || nextPosY>this.moveArea.y.max-this.height){
				nextPosY = (nextPosY<this.moveArea.y.min)?this.moveArea.y.min:this.moveArea.y.max-this.height;
			}
			
		}
		public function move(isMyPlane:Boolean = false)
		{
			this.moveWay.update();
		}
		
		protected function freeze(evt:Event) {
			this.isFreeze = true;
			this.removeEventListener('MoveComplete',freeze);
		}

	}

}