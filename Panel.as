package {
    import flash.events.Event;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.utils.*;

    public class Panel extends StaticGameItem {

        private var missleArr:Array = new Array(8);
        public static var useMissle:Boolean = false;
        public static var score:Number = 0;
        public static var enemyPlaneCount:Number = 0;
        public function Panel(posX:Number, posY:Number, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(posX, posY, width, height, rotation);
            //this.addEventListener("PlaneLifeChange", updateInfo);
            initMissleArr();
        }

        private function initMissleArr():void {

            var missleArea:MovieClip = (getChildByName("missleArea") as MovieClip)
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
                    trace("可用key " + i);
                    return true;
                }
            }
            return false;
        }

        public function coolMissle(beCooled:MovieClip) {
            beCooled.isValid = false;
            beCooled.gotoAndPlay(1);
            trace("space")
            beCooled.addFrameScript(beCooled.totalFrames - 1, function() {
                beCooled.isValid = true;
                beCooled.stop();
            });
        }

        public function updateInfo(curLife:Number, totalLife:Number) {
            var textField1:TextField = TextField(getChildByName("myLife"));
            textField1.text = (curLife + "/" + totalLife);
            ((getChildByName("lifeBar") as MovieClip).getChildByName("mc") as MovieClip).gotoAndStop(Math.ceil((totalLife - curLife) / totalLife * 100));

        }

        public function updateScore(addScore:Number) {
            var textField1:TextField = TextField(getChildByName("score"));
            score = parseInt(textField1.text) + addScore;
            textField1.text = ( score+ "");
            enemyPlaneCount++;

        }
    }

}
