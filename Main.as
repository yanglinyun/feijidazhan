package {
    import flash.events.KeyboardEvent;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.MovieClip;

    public class Main extends Sprite {
        private var ScreenWidth:Number;
        private var ScreenHight:Number;

        private var background:Background;
        private var panel:Panel = new Panel(0, 0);
        private var myPlaneMoveArea:Object = {x: {max: ScreenWidth, min: panel.width - 50, scale: ScreenWidth - panel.width + 50}, y: {max: ScreenHight, min: 200, scale: ScreenHight - 200}};
        private var myPlane:MyPlane;
        private var level:Level;
        private var keyBoradController:KeyBoradController;

        private var fp:FPSShow;

        public function Main() {
            ScreenWidth = stage.stageWidth;
            ScreenHight = stage.stageHeight;
            fp = new FPSShow();
            GameItem.stage = stage;
            MoveGameItem.panel = panel;
            GameItem.ScreenHeight = stage.stageHeight;
            GameItem.ScreenWidth = stage.stageWidth;
            keyBoradController = new KeyBoradController();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(evt:Event):void {
            this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            // 背景注册
            background = new Background()
            MoveGameItem.background = background;
            addChild(background);
            Level.moveItemList.push(background);
            // 左面板注册;
            addChild(panel);
            panel.name = "panel"
            myPlane = new MyPlane();
            // 我方飞机注册
            keyBoradController.addKeyUpDown(myPlane);
            addChild(myPlane);
            Level.moveItemList.push(myPlane);


            level = new Level();

            this.addEventListener(Event.ENTER_FRAME, onEnterframe);

        }


        private function onEnterframe(evt:Event):void {
            updateMoveItems();
        }

        private function updateMoveItems():void {
            // 更新运动物件

            for (var i:int = 0; i < Level.moveItemList.length; i++) {

                if (!Level.moveItemList[i].isFreeze) {
                    Level.moveItemList[i].move();
                    if (Level.moveItemList[i] is Plane) {
                        // 自己撞敌机或道具
                        for (var j2:Number = 0; j2 < Level.moveItemList.length; j2++) {
                            var enemyPlaneOrProp:* = Level.moveItemList[j2];
                            if ((enemyPlaneOrProp is EnemyPlane && enemyPlaneOrProp.curLife > 0) || enemyPlaneOrProp is Prop) {
                                if (myPlane.hit(enemyPlaneOrProp)) {
                                    break;
                                }
                            }
                        }
                        // 检测子弹
                        Level.moveItemList[i].bulletArr.forEach(function(bullet:Bullet, index:int, arr:Array) {

                            // bullet为普通 而非 导弹
                            if (!bullet.isFreeze && !(bullet is MissleBullet)) {
                                bullet.move(); //子弹移动

                                //==========使用导弹===========//
                                if (Panel.useMissle) { // 导弹清屏-10点
                                    for (var j:Number = 0; j < Level.moveItemList.length; j++) {
                                        var enemyPlane:* = Level.moveItemList[j];
                                        if (enemyPlane is EnemyPlane && enemyPlane.curLife > 0) {
                                            enemyPlane.bang(10) //-10点
                                        }
                                    }
                                    Panel.useMissle = false;

                                }
                                //==========敌机子弹打到我==============================//
                                if (Level.moveItemList[i] is EnemyPlane && myPlane.curLife > 0) {
                                    bullet.hit(myPlane);
                                } else if (Level.moveItemList[i] is MyPlane) {
                                    // 我的激光清线

                                    if (myPlane.curEffect[3] > 0) {
                                        for (var j3:Number = 0; j3 < Level.moveItemList.length; j3++) {
                                            var enemyPlane3:* = Level.moveItemList[j3];
                                            if (enemyPlane3 is EnemyPlane && enemyPlane3.curLife > 0) {

                                                if (enemyPlane3.y <= myPlane.y && (enemyPlane3.x >= myPlane.x && enemyPlane3.x <= myPlane.x + myPlane.width)) {
                                                    trace("对线")
                                                    enemyPlane3.bang(enemyPlane3.totalLife);
                                                }

                                            }
                                        }
                                    }
                                    //==========我子弹打到敌机==============================//
                                    for (var j2:Number = 0; j2 < Level.moveItemList.length; j2++) {
                                        var enemyPlane2:* = Level.moveItemList[j2];
                                        if (enemyPlane2 is EnemyPlane && enemyPlane2.curLife > 0) {

                                            if (bullet.hit(enemyPlane2)) {
                                                break;
                                            }

                                        }
                                    }
                                }
                            }
                        })
                    }

                }
            }
        }
    }

}
