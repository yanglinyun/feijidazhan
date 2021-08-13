package  {
	import flash.display.Stage;
	import flash.display.MovieClip;
	
	
	public class GameItem extends MovieClip{
		public static var stage:Stage;
		public function GameItem(posX:Number, posY:Number, width:Number=0, height:Number=0, rotation:Number=0) {
			this.x = posX;
			this.y = posY;
			if(width>0){
				this.width = width;
			}
			if(width>0){
				this.height = height;
			}
			this.rotation = rotation;
		}

	}
	
}
