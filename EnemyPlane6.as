
package {

    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class EnemyPlane6 extends EnemyPlane {
        private var timeOutId:uint;

        private var that:EnemyPlane6;
        private var mustCombArr:Array = [EnemyBullet6, EnemyBullet7, EnemyBullet7];
        public static var moveItemList:Array = [];
        private static var genzhongMissleTimeOutId:uint;
        private static var jiguang:EnemyBullet6;// 激光
        private static var fireTimeOutId_s;
        public function EnemyPlane6(posX:Number = 0, posY:Number = 0, moveArea:MoveArea = null, speed:Number = 3) {
            that = this;
            super(posX, posY, moveArea, speed);
            (((getChildByName("lifeBar") as MovieClip).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
            this.curLife = this.totalLife = 2500;
            this.moveWay = new StaticMove(this);
			fireThreeBullet(mustCombArr.concat());
            EnemyPlane6.fireTimeOutId_s = setInterval(fireThreeBullet, 5000, mustCombArr.concat());
			
        }

        public function myReBorn(posX:Number, posY:Number) {
            reBorn(posX, posY);
			fireThreeBullet(mustCombArr.concat());
            EnemyPlane6.fireTimeOutId_s = setInterval(fireThreeBullet, 5000, mustCombArr.concat());
        }
        
         public static function getCurAllEnemyBullet7():Array {
            return moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyBullet7 && !element.isFreeze;
            });
        }

        private function fireThreeBullet(bulletComb:Array) {
            var bullet:*;
            var _mustCombArr:Array = [EnemyBullet6, EnemyBullet7, EnemyBullet7];
            var threeBulletArr:Array = [];
			
            //trace("============================");
            //7秒激光 8秒跟踪
            var isExistFreezeEnemyBullet6:Boolean = false;
            for (var i:int = 0; i < moveItemList.length; i++) {
                if (moveItemList[i].isFreeze && (moveItemList[i] is EnemyBullet6)) {
					jiguang = moveItemList[i];
                    jiguang.born(this.x, this.y+ this.height / 2 - 50);
                    GameItem.stage.addChild(jiguang);
                    isExistFreezeEnemyBullet6 = true;
                    break;
                }

            }
            if (!isExistFreezeEnemyBullet6) {
                jiguang = new EnemyBullet6(this.x , this.y + this.height / 2 - 50);
                moveItemList.push(jiguang);
                bulletArr.push(jiguang);
                GameItem.stage.addChild(jiguang);
				jiguang.gotoAndPlay(1)
			
			
            }
            isExistFreezeEnemyBullet6 = false;
            _mustCombArr.shift();
            // 跟踪导弹
          
            EnemyPlane6.genzhongMissleTimeOutId = setTimeout(function() {
                clearTimeout(EnemyPlane6.genzhongMissleTimeOutId);
				
                
				 jiguang.isFreeze = true;
                 rc(jiguang);

                for (var i:int = 0; i < moveItemList.length; i++) {
					
                    if (_mustCombArr.length == 0 && threeBulletArr[0].isLeft && !threeBulletArr[1].isLeft) {
                        threeBulletArr[0].born(that.x - 20,that.y + that.height / 2 );
						threeBulletArr[1].born(that.x + 20, that.y + that.height / 2 );

                        GameItem.stage.addChild(threeBulletArr[0]);
                        GameItem.stage.addChild(threeBulletArr[1]);
                        return;
                    }

                    if (moveItemList[i].isFreeze && (moveItemList[i] is EnemyBullet7)) {

                        threeBulletArr.push(moveItemList[i]);

                        _mustCombArr.shift();
                            //trace("重复", i);
                    }
                }

				
                var leftBullet:EnemyBullet7 = new mustCombArr[1](that.x - 50, that.y + that.height / 2, true);
                var rightBullet:EnemyBullet7 = new mustCombArr[2](that.x + 50, that.y + that.height / 2, false);


                moveItemList.push(leftBullet);
                bulletArr.push(leftBullet);
                moveItemList.push(rightBullet);
                bulletArr.push(rightBullet);

                GameItem.stage.addChild(leftBullet);
                GameItem.stage.addChild(rightBullet);
            }, 3000);

        }

        // 老王挂
        public static function gameOver(){
            // 激光挂
            clearTimeout(EnemyPlane6.genzhongMissleTimeOutId);
			jiguang.isFreeze = true;
            rc(EnemyPlane6.jiguang);
            clearInterval(EnemyPlane6.fireTimeOutId_s);
            trace("out "+ genzhongMissleTimeOutId + " interval " + fireTimeOutId_s);
        }
        override protected function freeze(evt:Event = null) {
            // 静止
            this.removeEventListener('MoveComplete', freeze);
        }



    }

}
