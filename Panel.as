package {
    import flash.events.Event;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class Panel extends StaticGameItem {

        private var missleArr:Array = new Array(8);// 导弹冷却槽
        public static var useMissle:Boolean = false;// 正在使用导弹
        public static var scoreCount:Number = 0;
        public static var enemyPlaneCount:Number = 0;
        public var lifeBar:MovieClip = null;
        public var missleArea:MovieClip = null;

        public function Panel(posX:Number, posY:Number, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(posX, posY, width, height, rotation);
            initMissleArr();
        }
        
        private function initMissleArr():void {
            lifeBar = ((getChildByName("lifeBar") as MovieClip).getChildByName("mc") as MovieClip);
            lifeBar.gotoAndStop(lifeBar.totalFrames - 1);
            missleArea  = (getChildByName("missleArea") as MovieClip)
            for (var i:int = 0; i < missleArr.length; i++) {
                var curMissle:MovieClip = (((missleArea.getChildByName("m" + i) as MovieClip)).getChildByName("state") as MovieClip);
                missleArr[i] = curMissle;
                curMissle.isValid = true;
                curMissle.gotoAndStop(curMissle.totalFrames - 1);
            }
        }

        public function canFireMissle():Boolean {

            for (var i:int = 0; i < missleArr.length; i++) {
                if (missleArr[i].isValid) {
                    useMissle = true;
                    coolMissle(missleArr[i])
                 
                    return true;
                }
            }
            return false;
        }

        public function coolMissle(beCooled:MovieClip) {
            beCooled.isValid = false;
            beCooled.gotoAndPlay(1);
          
            beCooled.addFrameScript(beCooled.totalFrames - 1, function() {
                beCooled.isValid = true;
                beCooled.stop();
            });
        }

        public function updateInfo(curLife:Number, totalLife:Number) {
            var textField1:TextField = TextField(getChildByName("myLife"));
            textField1.text = (curLife + "/" + totalLife);
            lifeBar.gotoAndStop(Math.ceil((totalLife - curLife) / totalLife * 100));

        }

        public function updateScore(addScore:Number) {
            var textField1:TextField = TextField(getChildByName("score"));
            scoreCount = parseInt(textField1.text) + addScore;
            textField1.text = ( scoreCount+ "");
            enemyPlaneCount++;

        }
    }

}
