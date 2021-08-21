package {
    import flash.utils.*;

    class Level {
        // 场景飞机池
        public static var moveItemList:Array = [];
        private static var rowIndex:Number = 0;
        private var levelId:uint;
        public static var bossEffectComplete:Boolean=true;
        public static var  canContinue:Boolean = true;
        public static var  isGameOver:Boolean = false;
        public static var gEndPanel:GameEndPanel;
        
        public function Level() {
            level1();
        }

        private function level1() {
            LevelRow.generate(config[rowIndex++].slice());

            levelId = setInterval(function() {
                //clearInterval(levelId);
                if(isGameOver){
                    bossEffectComplete = true;
                    canContinue = true;
                    return;
                }
                if (rowIndex >= config.length) {
                    // Level.gameOver();
                      rowIndex = 0;
                     
                }
                    //trace(config[rowIndex], Level.canContinue , bossEffectComplete)
                    if(Level.canContinue && bossEffectComplete){// boos动画播完执行
                        LevelRow.generate(config[rowIndex++].slice());
                    }
                        
               
            }, 1000);

        }

        public static function getCurAllProp():Array {
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is Prop && !element.isFreeze;
            });
        }
        
        public static function getAllEnemyPlane():Array {
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane && element.curLife > 0;
            });
        }

        public static function stageHasBoss():Boolean {
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane6 && !element.isFreeze;
            }).length>0?true:false;
        }

       public static function stageNoAnyEnemyPlane():Boolean {
            var tmp:Array = Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane && !element.isFreeze;
            });
            
            return Level.moveItemList.filter(function(element:*, index:int, arr:Array):Boolean {
                return element is EnemyPlane && !element.isFreeze && element.x > 0;
            }).length==0?true:false;
        }
       // 游戏结束
        public static function gameOver(){
            isGameOver = true;
            Prop.clearAllProp();
            for(var i:int=0; i<Level.moveItemList.length; i++){
                // 卸载场内所有移动物件 除 背景
                var item:MoveGameItem = Level.moveItemList[i];
                if(!item.isFreeze && (item is Plane || item is Prop)){
                    if(item is EnemyPlane6){
                        EnemyPlane6.gameOver();
                    }
                    if(item is Plane){
                      (item as Plane).destory();
                    }
                   
                    item.x = -1000;
                    item.isFreeze = false;
                    
                    GameItem.rc(item);
                }
            }   
            gEndPanel = GameEndPanel.getInstance();
        }

        // 阵型配置 1-6 各类敌机
        private var config = [
            // -404 必须消灭当行全部飞机后面飞机才出现
            // -404 反之
            [1,1,1,1,1,1,1,-405],
            [1,0,1,0,1,0,1,-405],
            [1, 0, 0, 0, 0, 0, 1,-405],
            [0, 1, 0, 0, 0, 1, 0,-405],
            [0, 0, 1, 0, 1, 0, 0,-405],
            [0, 0, 0, 1, 0, 0, 0,-405],
            [0, 0, 1, 0, 1, 0, 0,-405],
            [0, 1, 0, 0, 0, 1, 0,-405],
            [1, 0, 0, 0, 0, 0, 1,-405],
            [2, 0, 0, 0, 0, 0, 2,-404],
            [0, 3, 0, 0, 0, 3, 0,-404],
            [0, 0, 4, 0, 0, 4, 0,-404],
            [4, 3, 4, 4, 4, 3, 4,-404],
            [1, 0, 0, 0, 0, 0, 1,-405],
            [0, 1, 0, 0, 0, 1, 0,-405],
            [0, 0, 1, 0, 1, 0, 0,-405],
            [0, 0, 0, 1, 0, 0, 0,-405],
            [0, 0, 1, 0, 1, 0, 0,-405],
            [0, 1, 0, 0, 0, 1, 0,-405],
            [1, 0, 0, 0, 0, 0, 1,-405],
            [-1,0,0,0,0,0,0,-404]

            //[1,1,1,1,1,1,1,-404]
            ];

    }
}
