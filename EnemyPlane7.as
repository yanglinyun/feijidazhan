package {

    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class EnemyPlane7 extends EnemyPlane {
        private var timeOutId:uint;

        private var that:EnemyPlane7;

        public function EnemyPlane7(posX:Number, posY:Number, moveArea:MoveArea = null, speed:Number = 3) {
            that = this;
            super(posX, posY, moveArea, speed);
            (((getChildByName("lifeBar") as MovieClip).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
            this.curLife = this.totalLife = 500;
            this.moveWay = new LineMove(this, [6], [0], [{x: 960, y: this.moveArea.yMax + this.height}])
            fireTimeOutId = setInterval(fire, 400, EnemyBullet7);

        }

        public function myReBorn(posX:Number, posY:Number) {
            reBorn(posX, posY);
            fireTimeOutId = setInterval(fire, 400, EnemyBullet7);
        }

        override protected function fire(bulletType:*) {
            var bullet:EnemyBullet7;
            for (var i:int = 0; i < bulletArr.length; i++) {
                if (bulletArr[i].isFreeze && (bulletArr[i] is bulletType)) {
                    bulletArr[i].born(this.x, this.y + this.height - 20);

                    GameItem.stage.addChild(bulletArr[i]);
                    return;
                }
            }

            bullet = new bulletType(this.x, this.y + this.height - 20, false, true);
            bulletArr.push(bullet);
            GameItem.stage.addChild(bullet);
        }

        override protected function freeze(evt:Event = null) {
            // 静止
            this.removeEventListener('MoveComplete', freeze);
            clearInterval(fireTimeOutId);

            this.isFreeze = true;
            if (GameItem.stage.contains(this)) {
                GameItem.stage.removeChild(this);
            }

        }




    }

}
