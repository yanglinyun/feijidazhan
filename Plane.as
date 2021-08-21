package {

    import flash.display.MovieClip;
    import flash.events.Event;
	import flash.utils.*;
	
    public class Plane extends MoveGameItem implements IMoveItemConflict {

        public var totalLife:Number;
        public var curLife:Number;
        public var bulletArr:Array = []; // 飞机子弹对象池
        protected var bulletTypeArr:Array;
        protected var fireTimeOutId:uint;
        
        public function Plane(moveArea:Object = null, posX:Number = 0, posY:Number = 0, speed:Number = 1, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(moveArea, posX, posY, speed, width, height, rotation);

        }

        // 可移动区域居中显示
        protected function midDisplay() {
            this.x = this.moveArea.xMin + this.moveArea.xScale / 2 - this.width / 2;
            this.y = this.moveArea.yMax - this.height;

        }

        protected function reBorn(posX:Number=0, posY:Number=0) {
            (((getChildByName("lifeBar") as MovieClip).getChildByName("lifeBar") as MovieClip)).gotoAndStop(0)
            this.x = posX;
            this.y = posY;
            //trace("randomBorn");
            this.gotoAndStop(1);
            this.curLife = this.totalLife;
            this.isFreeze = false;
            this.visible = true;
            GameItem.stage.addChild(this);
             this.addEventListener('MoveComplete', freeze);
        }

        public function bang(force:Number) {

        }

        
        // 定时发射子弹
        protected function fire(bulletComb:*) {
            var _bulletComb:Array = bulletComb.slice();
            var _bulletCombItem:Object;
            for (var i:int = 0; i < bulletArr.length; i++) {

                if (_bulletComb.length == 0) {
                    break; // 查询完毕
                }
                var typeArr:Array = _bulletComb.map(function(item){
                    return item.type;
                })
                var _bulletCombIndex:int = typeArr.indexOf(bulletArr[i])
                
                if (bulletArr[i].isFreeze && (_bulletCombIndex!=-1)) {
                    _bulletCombItem = _bulletComb.splice(_bulletCombIndex,1)[0];
                    _bulletCombItem.type.born(this.x + _bulletCombItem.x, this.y + _bulletCombItem.y);
                    GameItem.stage.addChild(_bulletCombItem.type);
                }
            }

            for(var j:Number=0; j<_bulletComb.length; j++){
                _bulletCombItem = _bulletComb[j];
                var newBullet:Bullet =  new (_bulletCombItem.type)(this.x +_bulletCombItem.x, this.y + _bulletCombItem.y)
                bulletArr.push(newBullet);
                GameItem.stage.addChild(newBullet);
            }

        }

        public function hit(target:*):Boolean {
            return false;
        }

        public function destory() {
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
            GameItem.rc(this)

        }


    }

}
