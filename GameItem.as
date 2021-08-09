package  {
	import flash.display.Sprite;
	
	public class GameItem extends Sprite{
		
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
