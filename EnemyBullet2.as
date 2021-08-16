package  {
		
	public class EnemyBullet2 extends EnemyBullet {
			
		public function EnemyBullet2(posX:Number, posY:Number, isLeft:Boolean, speed:Number = 8, moveArea:Object = null) {
			super(moveArea,posX,posY,speed );
			this.force = 20;
			this.rotation = (isLeft?5:7) * 45;
			this.moveWay = new LineMove(this,[isLeft?5:7], [this.speed],
			 [{x:isLeft?MoveGameItem.panel.width - 50:GameItem.ScreenWidth + 50,
			 y: GameItem.ScreenHeight + this.height}])
		}
	}
	
}
