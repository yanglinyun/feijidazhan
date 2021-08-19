package {

    public class EnemyBullet7 extends EnemyBullet {

        public var isLeft:Boolean;

        public function EnemyBullet7(posX:Number, posY:Number, isLeft:Boolean, speed:Number = 8, moveArea:Object = null) {
            super(moveArea, posX, posY, speed);
            this.isLeft = isLeft;
            this.force = 80;
            this.rotation = (isLeft ? 5 : 7) * 45;
            this.moveWay = new LineMove(this, [isLeft ? 5 : 7], [this.speed], [{x: isLeft ? MoveGameItem.panel.width - 60 : GameItem.ScreenWidth + 50,
                    y: GameItem.ScreenHeight + this.height}])
        }
    }

}
