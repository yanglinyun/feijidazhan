package {
    import flash.display.Stage;
    import flash.display.MovieClip;

    public class GameItem extends MovieClip {
        public static var stage:Stage;
        public static var ScreenHeight:Number;
        public static var ScreenWidth:Number;
        public static var keyBoradController:KeyBoradController;

        public function GameItem(posX:Number = 0, posY:Number = 0, width:Number = 0, height:Number = 0, rotation:Number = 0) {
            // 默认元件(x,y)=0 对齐 左上角
            this.x = posX;
            this.y = posY;
            this.width = width != 0 ? width : this.width;
            this.height = height != 0 ? height : this.height;
            this.rotation = rotation;
        }

        public static function rc(Object:*){
            if (GameItem.stage.contains(Object)) {
                GameItem.stage.removeChild(Object);
            }
        }

    }

}
