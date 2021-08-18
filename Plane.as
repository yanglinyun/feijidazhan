package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Plane extends MoveGameItem implements IMoveItemConflict{
		
		public var totalLife:Number;
		public var curLife:Number;
		protected var bulletTypeArr:Array;
		public var bulletArr:Array = []; // 飞机子弹对象池
		
		public function Plane(moveArea:Object=null, posX:Number=0, posY:Number=0, speed:Number=1, width:Number=0, height:Number=0, rotation:Number=0)
		{
			super(moveArea, posX, posY, speed, width, height, rotation);
			
		}

		// 可移动区域居中显示
		protected function midDisplay(){
			this.x = this.moveArea.xMin + this.moveArea.xScale / 2 - this.width / 2;
			this.y = this.moveArea.yMax - this.height;
			
		}
		public function bang(force:Number){

		}
		
		protected function fire(bulletType:*){
			
		}
		
		public function hit(target:*):Boolean{
			return false;
		};
		public function destory(){};


	}
	
}
