package {
    import flash.events.Event;

    public class MoveGameItem extends GameItem {
        public static var panel:Panel; // 设置子弹飞机MoveArea用
        public static var background:Background; // 设置子弹左出界用
        public var speed:Number;
        public var isFreeze:Boolean = false; // 下一帧是否渲染
        protected var moveArea:Object;
        protected var nextPosX:Number; // 下一帧更新位置X
        protected var nextPosY:Number; // 下一帧更新位置Y
        public var moveWay:Move; // 运动方式

        public function MoveGameItem(moveArea:Object = null, posX:Number = 0, posY:Number = 0, speed:Number = 1, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(posX, posY, width, height, rotation);
            this.speed = speed;
            this.moveArea = moveArea;
            this.addEventListener('MoveComplete', freeze);
        }

        protected function judgeMoveArea() {
            if (nextPosX < this.moveArea.xMin || nextPosX > this.moveArea.xMax - this.width) {
                ////trace("falseX")
                nextPosX = (nextPosX < this.moveArea.xMin) ? this.moveArea.xMin : this.moveArea.xMax - this.width;
            }
            if (nextPosY < this.moveArea.yMin || nextPosY > this.moveArea.yMax - this.height) {
                ////trace("falseY")
                nextPosY = (nextPosY < this.moveArea.yMin) ? this.moveArea.yMin : this.moveArea.yMax - this.height;
            }


        }

        public function move(isMyPlane:Boolean = false) {
            this.moveWay.update();
        }

        protected function freeze(evt:Event = null) {
            this.isFreeze = true;
          
            if (GameItem.stage.contains(this)) {
                GameItem.stage.removeChild(this);
            }

            this.removeEventListener('MoveComplete', freeze);
        }

    }

}
