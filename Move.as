package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher; // 发送事件类

    public class Move {
        public var curDirection:Number; // 0~7 逆时针 * 45°= 实际度数 
        protected var curMoveNode:Object; // 当前终点(x, y)
        public var curFrameSpeed:int; // 当前帧速度
        public var direction:Array; // 8个方向
        protected var frameSpeed:Array;
        protected var moveNode:Array;
        protected var artRes:MoveGameItem;

        // 初始化移动事件
        public function Move(artRes:MoveGameItem, direction:Array, frameSpeed:Array, moveNode:Array) {
            this.direction = direction;
            this.artRes = artRes;
            this.frameSpeed = frameSpeed;
            this.moveNode = moveNode;
            this.curDirection = this.direction.shift();
            this.curMoveNode = this.moveNode.shift();
            this.curFrameSpeed = this.frameSpeed.shift();

        }

        // 运动更新处理函数
        public function update() {

        }

    }

}
