package {

    import flash.display.MovieClip;
    import flash.events.Event;

    public class Background extends MoveGameItem {
        public function Background(moveArea:Object = null, posX:Number = 0, posY:Number = 0, speed:Number = 1, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            super(moveArea, posX, posY, speed, width, height, rotation);
            this.moveWay = new LineMove(this, [2], [this.speed], [{x: 0, y: -1200}]);
        }

        override protected function freeze(evt:Event = null) {
            // 背景循环滚动 
            // 其本轮运动完成 触发冷冻方法是重置 
            // 重新开始滚动
            this.x = 0;
            this.y = 0;
        }
    }

}
