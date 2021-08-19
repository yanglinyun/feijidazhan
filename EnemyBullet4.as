package {

    public class EnemyBullet4 extends EnemyBullet {

        public var degree:Number;

        public function EnemyBullet4(posX:Number, posY:Number, degree:Number, speed:Number = 8, moveArea:Object = null) {
            super(moveArea, posX, posY, speed);
            this.force = 10;
            this.degree = degree;
            // degree 5 5.5 6 6.5 7
            this.rotation = (6 - degree) * 45;

            this.moveWay = new LineMove(this, [degree], [this.speed], [{x: degree < 6 ? MoveGameItem.panel.width - 60 : GameItem.ScreenWidth + 50,
                    y: GameItem.ScreenHeight + this.height}]);
        }
    }

}
