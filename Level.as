package {
    import flash.utils.*;

    class Level {
        // 场景飞机池
        public static var moveItemList:Array = [];
        private static var rowIndex:Number = 0;
        private var levelId:uint;
        public static var bossEffectComplete:Boolean=true;
        public static var  canContinue:Boolean = true;
        public function Level() {
            level1();
        }

        private function level1() {
            LevelRow.generate(config[rowIndex++].slice());

            levelId = setInterval(function() {
                //clearInterval(levelId);
                if (rowIndex >= config.length) {
                      rowIndex = 0;
                        //clearInterval(levelId);
                }
                    //trace(config[rowIndex], Level.canContinue , bossEffectComplete)
                    if(Level.canContinue && bossEffectComplete){// boos动画播完执行
                          
                            LevelRow.generate(config[rowIndex++].slice());
                            Level.canContinue = false;
                         
                    }
                        
               
            }, 1000);

        }

        public static function getCurAllProp():Array {
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is Prop && !element.isFreeze;
            });
        }

       public static function stageNoAnyEnemyPlane():Boolean {
            var tmp:Array = Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane && !element.isFreeze;
            });
            trace("场上"+(tmp.length>0?tmp[0].isFreeze.toString():"0"));
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane && !element.isFreeze && element.x > 0;
            }).length==0?true:false;
        }
       



        private var config = [
            // -404 必须消灭当行全部飞机后面飞机才出现
            // -405 反之
             [1,0,0,0,0,0,0,-404],
            [-1,0,0,0,0,0,0,-404]
           
            // [1,1,1,1,1,1,1,-405],
            // [2, 0, 0, 0, 0, 0, 0,-404],
            // [0, 2, 0, 0, 0, 0, 0,-404],
            // [0, 0, 2, 0, 0, 0, 0,-404],
            // [0, 0, 0, 2, 0, 0, 0,-404],
            // [0, 0, 0, 0, 2, 0, 0,-404],
            // [0, 0, 0, 0, 0, 2, 0,-404],
            // [0, 0, 0, 0, 0, 0, 2,-404],
            // [0, 0, 0, 0, 0, 3, 0,-404],
            // [0,0,0,0,1,0,0,-405],
            // [0,0,0,2,0,0,0,-404],
            // [0,0,1,0,0,0,0,-404],
            // [0,1,0,0,0,0,0,-405],
            // [1,0,0,0,0,0,0,-405],
            // [0,0,0,4,0,0,0,-404],
            // [0,0,1,0,1,0,0,-405],
            // [0,1,0,0,0,1,0,-405],
            // [1,0,0,0,0,0,1,-405],
            // [0,0,0,1,0,0,0,-405],
            // [0,0,1,0,1,0,0,-405],
            // [0,1,0,0,0,1,0,-405],
            // [1,0,0,0,0,0,1,-405],
            // [0,2,0,2,0,2,0,-404],
            // [0,0,0,3,0,0,0,-404],
            // [0,0,3,0,3,0,0,-404],
            // [0,0,0,4,0,0,0,-404],
            // [0,4,4,4,4,4,0,-404],
            // [0,0,2,0,0,0,0,-404],
            // [-1,0,0,0,0,0,0,-404]
            ];

    }
}
