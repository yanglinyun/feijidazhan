package {

    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class EnemyPlane extends Plane {
        private var _moveArea:MoveArea;
        private var that:EnemyPlane;
        private var timeOutId:uint = 0;
        private var dieTimeOutId:uint = 0;
        protected var bulletExistPlaneDieIntervalId:uint;

        public function EnemyPlane(posX:Number, posY:Number, moveArea:MoveArea, speed:Number) {
            this._moveArea = new MoveArea(GameItem.ScreenWidth, MoveGameItem.panel.width - 50, GameItem.ScreenHeight, 0)
            super(_moveArea, posX, posY, speed);
            //this.randomBorn();
            this.gotoAndStop(1);
            that = this;
            GameItem.stage.addChild(this);
        }

        

        override public function bang(force:Number) {

            this.curLife -= force;

            (((getChildByName("lifeBar") as MovieClip).getChildByName("lifeBar") as MovieClip)).gotoAndStop(Math.round(100 * (totalLife - curLife) / totalLife) + 1)
            //trace("当前血量"+this.curLife)
            if (this.curLife <= 0) {
                this.gotoAndStop(3);
                panel.updateScore(that.totalLife * MyPlane.isDoubleScore);
                // boss死亡游戏结束
                if(this.curLife<=0 && this is EnemyPlane6){
                    Level.gameOver();
                    return;
                }
                dieTimeOutId = setTimeout(function() {
                    clearTimeout(dieTimeOutId);
                    dieTimeOutId = 0;
                    that.dieFreeze();
                }, 500)
            } else {
                this.gotoAndStop(2);

                //timeOutId==0 || clearTimeout(timeOutId);
                timeOutId = setTimeout(function() {
                    clearTimeout(timeOutId);
                    timeOutId = 0;
                    that.gotoAndStop(1);
                }, 500)
            }
        }

      
        protected function dieFreeze(evt:Event = null) {
            // 可能子弹没有被消灭 飞机必须仍然在场
            bulletExistPlaneDieIntervalId = setInterval(function() {

                var allBulletFreeze = true;
                for (var i:Number = 0; i < that.bulletArr.length; i++) {

                    if (!that.bulletArr[i].isFreeze) {
                        allBulletFreeze = false;
                        break;
                    }
                }
                if (allBulletFreeze) {
                    clearInterval(bulletExistPlaneDieIntervalId);
                    that.isFreeze = true;
                    rc(that);
                }

            }, 100)

            that.visible = false;
            Prop.generate(that.x, that.y);
            that.x = -1000;
            
            clearInterval(fireTimeOutId);
            //this.randomBorn();
        }
    }

}
