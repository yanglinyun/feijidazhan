
package {

    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class EnemyPlane1 extends EnemyPlane {
        private var timeOutId:uint;

        private var that:EnemyPlane1;

        public function EnemyPlane1(posX:Number, posY:Number, moveArea:MoveArea = null, speed:Number = 3) {
            that = this;
            super(posX, posY, moveArea, speed);
            (((getChildByName("lifeBar") as MovieClip).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
            this.curLife = this.totalLife = 40;
            this.moveWay = new LineMove(this, [6], [this.speed], [{x: 960, y: this.moveArea.yMax + this.height}])
            bulletTypeArr = [
                {
                    type:EnemyBullet1,
                    x: 0, 
                    y: this.height - 20
                }];
            fireTimeOutId = setInterval(fire, 1000, bulletTypeArr);

        }

        public function myReBorn(posX:Number, posY:Number) {
            reBorn(posX, posY);
            fireTimeOutId = setInterval(fire, 1000, bulletTypeArr);
        }

        override protected function freeze(evt:Event = null) {
            // 静止
            this.removeEventListener('MoveComplete', freeze);
            clearInterval(fireTimeOutId);
            this.isFreeze = true;
             rc(this);

        }
    }

}
