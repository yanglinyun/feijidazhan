package {
    import flash.utils.*;

    class Level {
        // 场景飞机池
        public static var moveItemList:Array = [];
        private static var rowIndex:Number = 0;
        private var levelId:uint;
        public static var bossEffectComplete:Boolean=false;

        public function Level() {
            level1();
        }

        private function level1() {
            LevelRow.generate(config[rowIndex]);

            levelId = setInterval(function() {
                clearInterval(levelId);
                if(!(config[rowIndex][0]==-1 && bossEffectComplete)){// boos动画播完执行
                     rowIndex++;
                    if (rowIndex >= config.length) {
                       // rowIndex = 0;
                        clearInterval(levelId);
                    } else {
                        LevelRow.generate(config[rowIndex++]);
                    }
                }
               

            }, 1000);

        }

        public static function getCurAllProp():Array {
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is Prop && !element.isFreeze;
            });
        }

       



        private var config = [
            // [-1,0,0,0,0,0,0]
            // [1,1,1,1,1,1,1]
            // [1,1,1,1,1,1,1],
            // [2, 0, 0, 0, 0, 0, 0],
            // [0, 2, 0, 0, 0, 0, 0],
            // [0, 0, 2, 0, 0, 0, 0],
            // [0, 0, 0, 2, 0, 0, 0],
            // [0, 0, 0, 0, 2, 0, 0],
            // [0, 0, 0, 0, 0, 2, 0],
            // [0, 0, 0, 0, 0, 0, 2],
            // [0, 0, 0, 0, 0, 3, 0],
            // [0,0,0,0,1,0,0],
            // [0,0,0,2,0,0,0],
            // [0,0,1,0,0,0,0],
            // [0,1,0,0,0,0,0],
            // [1,0,0,0,0,0,0],
            // [0,0,0,4,0,0,0],
            // [0,0,1,0,1,0,0],
            // [0,1,0,0,0,1,0],
            // [1,0,0,0,0,0,1],
            // [0,0,0,1,0,0,0],
            // [0,0,1,0,1,0,0],
            // [0,1,0,0,0,1,0],
            // [1,0,0,0,0,0,1],
            // [0,2,0,2,0,2,0],
            // [0,0,0,3,0,0,0],
            // [0,0,3,0,3,0,0],
            // [0,0,0,4,0,0,0],
            // [0,4,4,4,4,4,0],
            // [0,0,2,0,0,0,0],
             [-1,0,0,0,0,0,0]
            ];

    }
}
