package{
    class Formation {
        protected var _artRes:*;
        protected var _setInterval:uint;
        protected var stageWidth = GameItem.ScreenWidth - MoveGameItem.panel.width;
        protected var baseX =MoveGameItem.panel.width;
        public function Formation(artRes:*) {
            this._artRes = artRes;
        }

        public function generate(artRes:*) {

        }
    }
}