package {

    public class EnemyBullet1 extends EnemyBullet {

        public function EnemyBullet1(moveArea:Object, posX:Number, posY:Number, speed:Number = 8) {
            super(moveArea, posX, posY, speed);
            this.force = 2;
            this.moveWay = new LineMove(this, [6], [this.speed], [{x: 960, y: GameItem.ScreenHeight + this.height}])
        }
    }

}
