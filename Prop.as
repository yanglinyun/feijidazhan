package {

    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.utils.*;

    public class Prop extends MoveGameItem implements IMoveItemConflict {
        private var _moveArea:MoveArea;
        private var that:Prop;
        private var type:uint; //1-4
        private var dieTimeOutId:uint; //1-4
        private var prop:MovieClip;
        private var myPlane:MyPlane;
        public static var timeOutIdArr:Array;

        public function Prop(posX:Number = 0, posY:Number = 0, moveArea:Object = null, speed:Number = 1, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            this._moveArea = new MoveArea(GameItem.ScreenWidth, MoveGameItem.panel.width - 50, GameItem.ScreenHeight, 0)
            super(moveArea, posX, posY, speed, width, height, rotation);
            that = this;
           
            setType();
           
            timeOutIdArr = new Array(5);
            this.moveWay = new LineMove(this, [6], [this.speed], [{x: 960, y: this._moveArea.yMax + this.height}])
            GameItem.stage.addChild(this);

        }

        private function reBorn(posX:Number=0, posY:Number=0) {
            this.x = posX;
            this.y = posY;
            this.isFreeze = false;
            this.visible = true;
            this.setType(); 
            var curProp:MovieClip = ((this.getChildByName("mc") as MovieClip));
            // 正常动画 不爆炸
            curProp.gotoAndStop(1);
            GameItem.stage.addChild(this);
            trace("道具重用");
            this.addEventListener('MoveComplete', freeze);
        }

        private function setType(){
            type = Math.ceil(Math.random() * 4);
             buff();
        }

        public static function clearAllTimeOut(){
            for(var i:int=0; i<Prop.timeOutIdArr.length; i++){
                clearTimeout(Prop.timeOutIdArr[i]);
            }
        }
        
        public function buff() {
            switch (type) {
                case 1: // tie
                    this.gotoAndStop(1);


                    break;
                case 2: // jiguang
                    this.gotoAndStop(2);


                    break;
                case 3: // money
                    this.gotoAndStop(3);


                    break;
                case 4: // life
                    this.gotoAndStop(4);


                    break;
            }

            prop = ((this.getChildByName("mc") as MovieClip));
            prop.gotoAndStop(1);

        }

        public function bang(myPlane:MyPlane) {
            this.myPlane = myPlane;
            switch (type) {
                case 1: // tie

                    mage();
                    break;
                case 2: // jiguang

                    jiguang();
                    break;
                case 3: // money

                    money();
                    break;
                case 4: // life

                    life();
                    break;
            }
            prop.play()
            dieTimeOutId = setTimeout(function() {
                prop.stop()
                clearTimeout(dieTimeOutId);
                dieTimeOutId = 0;
                that.dieFreeze();
            }, 500)

        }

        protected function dieFreeze(evt:Event = null) {
            that.isFreeze = true;
            rc(that)
        }

        private function mage() {
            this.myPlane.curEffect[4] = 4;
            GameItem.stage.addChild(this.myPlane.effectArr[4]);
            clearTimeout(timeOutIdArr[4]);
            timeOutIdArr[4] = setTimeout(function() {
                that.myPlane.curEffect[4] = 0;
                clearTimeout(timeOutIdArr[4]);
                MyPlane.isDoubleScore = 1;
                if (GameItem.stage.contains(that.myPlane.effectArr[4])) {
                    GameItem.stage.removeChild(that.myPlane.effectArr[4]);

                    var stageProp:Array = Level.getCurAllProp();

                    for (var prop:Number = 0; prop < stageProp.length; prop++) {
                        // 如果磁铁失效 恢复正常运动
                        stageProp[prop].moveWay.curDirection = 6; // 道具->飞机
                        stageProp[prop].moveWay.curFrameSpeed = 2;
                    }

                }
            }, 2000)
        }

        private function jiguang() {
            this.myPlane.curEffect[3] = 3;
            GameItem.stage.addChild(this.myPlane.effectArr[3]);
            clearTimeout(timeOutIdArr[3]);
            timeOutIdArr[3] = setTimeout(function() {
                that.myPlane.curEffect[3] = 0;
                clearTimeout(timeOutIdArr[3]);
                trace("激光移除")
                rc(that.myPlane.effectArr[3])
                
            }, 2000)
        }

        private function money() {
            // 10s内 击中飞机2倍经验
            MyPlane.isDoubleScore = 2;
            GameItem.stage.addChild(this.myPlane.effectArr[2]);
            clearTimeout(timeOutIdArr[2]);
            this.myPlane.curEffect[2] = 2;
            timeOutIdArr[2] = setTimeout(function() {
                that.myPlane.curEffect[2] = 0;
                clearTimeout(timeOutIdArr[2]);
                MyPlane.isDoubleScore = 1;
                rc(that.myPlane.effectArr[2])
              
            }, 2000)
        }

        private function life() {
            this.myPlane.curEffect[1] = 1;
            GameItem.stage.addChild(this.myPlane.effectArr[1]);
            clearTimeout(timeOutIdArr[1]);
            timeOutIdArr[1] = setTimeout(function() {
                that.myPlane.curEffect[1] = 0;
                clearTimeout(timeOutIdArr[1]);
                rc(that.myPlane.effectArr[1])
                
            }, 2000)
            this.myPlane.addLife(200);
        }

        public static function generate(posX:Number, posY:Number) {
            for (var j:int = 0; j < Level.moveItemList.length; j++) {
                if (Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is Prop)) {
                    Level.moveItemList[j].reBorn(posX, posY)
                    return;
                }
            }
            var prop:* = new Prop(posX, posY);
            Level.moveItemList.push(prop);
          
        }

        public static function clearAllProp() {
            for (var j:int = 0; j < Level.moveItemList.length; j++) {
                if (Level.moveItemList[j] is Prop) {
                    Level.moveItemList[j].x = -1000;
                    Level.moveItemList[j].isFreeze = true;
                    
                }
            }
        }

        public function hit(target:*):Boolean {
            return false;
        }
        ;

        public function destory() {
        }
        ;


    }

}
