package {
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.events.EventDispatcher;

    public class KeyBoradController {
        private var stage:Stage = GameItem.stage;
        public static var keyDownArr:Array = [];
        public static var keyUpArr:Array = [];

        public function KeyBoradController() {
            //trace(stage.stageWidth);
            keyTwo();
        }

        public function addKeyDown(obj:MovieClip):void {
            keyDownArr.push(obj);
        }

        public function addKeyUpDown(obj:MovieClip):void {
            keyDownArr.push(obj);
            keyUpArr.push(obj);
        }

        public function clearKeyUpDown():void {
           keyDownArr = [];
           keyUpArr = [];
        }


        public function addKeyUp(obj:MovieClip):void {
            keyUpArr.push(obj);
        }

        private function keyTwo() {

            this.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
        }

        private function KeyDownHandler(evt:KeyboardEvent) {

            for (var i:int = 0; i < keyDownArr.length; i++) {
               keyDownArr[i].KeyDownHandler(evt);
            }

        }

        private function KeyUpHandler(evt:KeyboardEvent) {
            for (var i:int = 0; i < keyUpArr.length; i++) {
                keyDownArr[i].KeyUpHandler(evt);
            }

        }
    }

}
