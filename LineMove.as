package {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher; // 发送事件类

    public class LineMove extends Move {

        public function LineMove(artRes:MoveGameItem, direction:Array, frameSpeed:Array, moveNode:Array) {
            super(artRes, direction, frameSpeed, moveNode);
        }

        override public function update() {

            var artResX:Number = this.artRes.x;
            var artResY:Number = this.artRes.y;


            switch (this.curDirection) {

                case 0:
                    artResX += this.curFrameSpeed;

                    break;
                case 1:
                    artResY -= this.curFrameSpeed * Math.sin(45);
                    artResX += this.curFrameSpeed * Math.cos(45);

                    break;
                case 2:
                    artResY -= this.curFrameSpeed;

                    break;
                case 3:
                    artResY -= this.curFrameSpeed * Math.sin(45);
                    artResX -= this.curFrameSpeed * Math.cos(45);

                    break;
                case 4:
                    artResX -= this.curFrameSpeed;

                    break;
                case 5:
                    artResY += this.curFrameSpeed * Math.sin(45);
                    artResX -= this.curFrameSpeed * Math.cos(45);

                    break;
                case 5.5:
                    artResY += this.curFrameSpeed * Math.cos(45 / 2 * Math.PI / 180);
                    artResX -= this.curFrameSpeed * Math.sin(45 / 2 * Math.PI / 180);

                    break;
                case 6:
                    artResY += this.curFrameSpeed;

                    break;
                case 6.5:

                    artResY += this.curFrameSpeed * Math.cos(45 / 2 * Math.PI / 180);
                    artResX += this.curFrameSpeed * Math.sin(45 / 2 * Math.PI / 180);

                    break;
                case 7:
                    artResY += this.curFrameSpeed * Math.sin(45);
                    artResX += this.curFrameSpeed * Math.cos(45);

                    break;
                default:
                    break;
            }

            var isEnd:Boolean = false;
            curMoveNode.x = (curDirection >= 3 && curDirection < 6) ? MoveGameItem.panel.width - 60 : 960;
            if (curDirection <= 4) {
                if (curDirection >= 3) {
                    isEnd = artResX < curMoveNode.x || artResY < curMoveNode.y;
                } else {
                    isEnd = artResX > curMoveNode.x || artResY < curMoveNode.y;
                }
            } else {
                if (curDirection >= 6) {
                    isEnd = artResX > curMoveNode.x || artResY > curMoveNode.y;
                } else {
                    isEnd = artResX < curMoveNode.x || artResY > curMoveNode.y;

                }

            }

            if (isEnd) {
                if (this.moveNode.length <= 0) {
                    // 派发运动结束事件
                    //trace("结束")

                    this.artRes.dispatchEvent(new Event('MoveComplete'));
                }
            } else {
                //	//trace("子弹移动" + this.artRes.y);
                this.artRes.x = artResX;
                this.artRes.y = artResY;
            }

        }

    }

}
