package {

    public class EnemyBullet6 extends EnemyBullet {

        public function EnemyBullet6(posX:Number, posY:Number, speed:Number = 0, moveArea:Object = null) {
            super(moveArea, posX, posY, speed);
            this.force = 200;
            this.moveWay = new LineMove(this, [6], [this.speed], [{x: 0,
                    y: GameItem.ScreenHeight + this.height}]);
        }

		override public function hit(target:*):Boolean {
            
            if (this.hitTestObject(target)) {
                
                target.bang(this.force);
               
                //trace(GameItem.stage);
                return true;
            }
            return false;
        }
    }

}

