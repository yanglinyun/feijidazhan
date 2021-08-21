package {
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.utils.*;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.utils.*;
	import flash.display.MovieClip;
	
    public class MyPlane extends Plane {

        private var keyObj:Object = {}; // 按键记录对象
        private var _moveArea:MoveArea; // 个人飞机移动范围
        private var _speed:Number = 7; 
        private var that:MyPlane;
        private var bangTimeOutId:uint;
        private var fireThrottle:Boolean = false; //1s 一次
        private var missleTypeArr;
        public static var isDoubleScore:uint = 1; // 双倍经验
        public var curEffect:Array; // 当前特效 0 正常 非0对应特效
        public var effectArr:Array; // 特效集合
       
        public function MyPlane() {

            this._moveArea = new MoveArea(GameItem.ScreenWidth, MoveGameItem.panel.width - 50, GameItem.ScreenHeight, 225)
            super(this._moveArea, 0, 0, _speed);
            // 居中显示
            
            that = this;
            
            effectArr = [null, new LifeEffect(), new MoneyEffect(), new JiGunagEffect(), new MagaEffect()];
            // 配置子弹
            bulletTypeArr = [
                {
                    type:TwoBullet,
                    x:  this.width / 2,
                    y: 0
                },
                {
                    type:ThreeBullet,
                    x:  this.width / 2 - 30,
                    y:  20
                },
                {
                    type:ThreeBullet,
                    x:  this.width / 2 + 30,
                    y:  20
                }
            ];
            // 配置炸弹
            missleTypeArr = [
                {
                    type:MissleBullet,
                    x:  this.width / 2,
                    y: 0
                }
            ]
            init();
           
        }

        private function init() {
            midDisplay();
            this.gotoAndStop(1); // 正常状态
            this.totalLife = this.curLife = 5000; // 血量
            // 面板初始化
            panel.updateInfo(this.curLife, this.totalLife)
            // 加载特效
            curEffect = [0, 0, 0, 0, 0];
            fireTimeOutId =setInterval(fire, 400, bulletTypeArr);
            this.isFreeze = false;
            this.visible = true;
             GameItem.stage.addChild(this);
        }
        override protected function reBorn(posX:Number=0, posY:Number=0) {
            
            init();
           
        }
        
        public function addLife(num:Number) {
            this.curLife = (this.curLife + num) >= this.totalLife ? this.totalLife : (this.curLife + num);
            panel.updateInfo(this.curLife, this.totalLife)
        }

        // 飞机碰敌机 或 子弹
        override public function hit(target:*):Boolean {
            if (this.hitTestObject(target)) {
                if (target is Plane) {
                    target.bang(target.totalLife);
                    this.bang(target.curLife);
                } else if (target is Prop) {
                    target.bang(this);

                }

                return true;
            }
            return false;
        }

        override public function bang(force:Number) {

            this.curLife -= force;
            // 玩家死亡游戏结束
            if (this.curLife <= 0) {
                Level.gameOver();
                return;
            } else {
                if (keyObj[37]) { // 左移损害
                    this.gotoAndStop(6);
                } else if (keyObj[39]) { // 右移损害
                    this.gotoAndStop(4);
                } else {
                    this.gotoAndStop(2);
                }

                bangTimeOutId = setTimeout(function() {
                    clearTimeout(bangTimeOutId);
                    that.gotoAndStop(1);
                }, 500)
            }
            
            panel.updateInfo(this.curLife, this.totalLife)
        }
        
        public function KeyDownHandler(e:KeyboardEvent) {
            keyObj[e.keyCode] = true;
            if(Level.isGameOver && keyObj[32]){
                Level.isGameOver = false;
                reBorn();
				
				if(Level.gEndPanel){
					GameItem.rc(Level.gEndPanel);
				}
                
                return;
            }
            // 清屏导弹
            if (keyObj[32] && panel.canFireMissle()) {
                if(!fireThrottle){
                	fireThrottle = true;
                	fireTimeOutId = setTimeout(function ():void
                	{
                		clearTimeout(fireTimeOutId)
                		fireThrottle = false;
                	},1000);
                	this.fire(missleTypeArr);
                }
                

            }

        }

        public function KeyUpHandler(e:KeyboardEvent) {
            keyObj[e.keyCode] = false;



        }

        public function getTwoPointDirection(src:MoveGameItem, target:MoveGameItem):Number {
            var direction:Number = 0;
            if (src.x < target.x) {
                if (src.y > target.y) {
                    direction = 1
                } else {
                    direction = 7

                }
            } else {
                if (src.y > target.y) {
                    direction = 3
                } else {
                    direction = 5
                }
            }
            return direction;
        }

        override public function move(isMyPlane:Boolean = false) {
            nextPosX = this.x;
            nextPosY = this.y;

            if (keyObj[37]) {
                nextPosX -= this.speed;
                this.gotoAndStop(5);
            }
            if (keyObj[38]) {
                nextPosY -= this.speed;
            }
            if (keyObj[39]) {
                this.gotoAndStop(3);
                nextPosX += this.speed;
            }
            if (keyObj[40]) {
                nextPosY += this.speed;
            }
            // 判断是否越位 更新nextPos
            this.judgeMoveArea()

            // 更新飞机位置
            this.x = nextPosX
            this.y = nextPosY
            // 如果存在跟踪到导弹
            var enemyBullet7Arr:Array = EnemyPlane6.getCurAllEnemyBullet7();
             
            for(var j:Number = 0; j < enemyBullet7Arr.length; j++){
                if(enemyBullet7Arr[j].y< this.y){
                    
                    enemyBullet7Arr[j].moveWay.curDirection = getTwoPointDirection(enemyBullet7Arr[j], this); // 道具->飞机
                    enemyBullet7Arr[j].rotation = enemyBullet7Arr[j].moveWay.curDirection * 45;
                    enemyBullet7Arr[j].moveWay.curFrameSpeed = 10;
                }
            }
            for (var i:Number = 1; i <= this.curEffect.length - 1; i++) {
                if (this.curEffect[i] > 0) {
                    if (i >= 3) {
                        effectArr[i].update(this.x + this.width / 2, this.y + this.height / 2);
                        if (i == 4) {
                            var stageProp:Array = Level.getCurAllProp();

                            for (var prop:Number = 0; prop < stageProp.length; prop++) {

                                stageProp[prop].moveWay.curDirection = getTwoPointDirection(stageProp[prop], this); // 道具->飞机
                                stageProp[prop].moveWay.curFrameSpeed = 10;
                            }
                        }
                    } else {
                        effectArr[i].update(this.x + effectArr[i].width / 2, this.y + effectArr[i].height / 2);
                    }

                }
            }


        }

        override public function destory() {
            // 释放子弹
            for(var i:int=0; i<bulletArr.length; i++){
                var bullet:Bullet = bulletArr[i];
                if(!bullet.isFreeze){
                    bullet.isFreeze = false;
                    
                }
                GameItem.rc(bullet);

            }
            // 释放定时发射子弹
            clearInterval(fireTimeOutId);
            this.isFreeze = true;
            // 飞机道具特效清除
            Prop.clearAllTimeOut();
            GameItem.rc(this)
            

        }

        

    }

}
