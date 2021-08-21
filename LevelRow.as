package {
    import flash.utils.*;
    import flash.display.MovieClip;

    class LevelRow {
        protected static var stageWidth = GameItem.ScreenWidth - MoveGameItem.panel.width;
        protected static var baseX = MoveGameItem.panel.width;
        private static var enemyTypeArr:Array = [null, EnemyPlane1, EnemyPlane2, EnemyPlane3, EnemyPlane4];
        private static var bossEffect:MovieClip = new BossEffect( MoveGameItem.panel.width, 0).getChildByName("mc") as MovieClip;
        public static function generate(row:Array) {
            if(row[row.length-1]==-404){// 当前关卡飞机必须全部消灭 否则暂停
                Level.canContinue = false;
               
                var stageNoAnyEnemyPlaneId:uint = setInterval(function(){
                    //trace("前关卡飞机必须全部消灭 检测中" + Level.stageNoAnyEnemyPlane())
                    if(Level.stageNoAnyEnemyPlane() && (row[0]==-1?Level.bossEffectComplete:true)){// 并且boss出厂动画完毕才开始检测当前光卡是否完毕
                        clearInterval(stageNoAnyEnemyPlaneId);
                        Level.canContinue = true;
                       
                    }
                },1000);//1s 检测一次
                row.pop();
            }else if(row[row.length-1]==-405){// 当前关卡飞机不必全部消灭 剧情人继续
            
                 Level.canContinue = true;
                 Level.bossEffectComplete = true;
                 row.pop();
            }

            if(row[0]==-1){
                // 播放boss动画
                Level.canContinue = false;
                Level.bossEffectComplete = false;
                bossEffect.x = MoveGameItem.panel.width;
                bossEffect.gotoAndPlay(1);
                GameItem.stage.addChild(bossEffect);
                bossEffect.addFrameScript(bossEffect.totalFrames - 1, function() {
                    Level.bossEffectComplete = false;
                    bossEffect.stop();
                    GameItem.rc(bossEffect)
                    
                   
                    Level.bossEffectComplete = true;

                    // 替换real boss 
                    for (var j:int = 0; j < Level.moveItemList.length; j++) {
                        if (Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is EnemyPlane6)) {
                            Level.moveItemList[j].myReBorn(10 + baseX + 250, 110);
                            break;
                        }
                    }

                    var enemyPlane:* = new EnemyPlane6(10 + baseX + 250, 110);
                    Level.moveItemList.push(enemyPlane); // x = 960 屏幕宽度 防止提前碰边界

                    // 替换real 小boss
                    var EnemyPlane7Arr:Array = [];
                    for (var j2:int = 0; j2 < Level.moveItemList.length; j2++) {
                        if(EnemyPlane7Arr.length==2){
                            EnemyPlane7Arr[0].myReBorn(enemyPlane.x - 230, enemyPlane.y + 80);
                            EnemyPlane7Arr[1].myReBorn(enemyPlane.x + 230, enemyPlane.y + 80);
                           
                            return;
                        }
                        if (Level.moveItemList[j2].isFreeze && (Level.moveItemList[j2] is EnemyPlane7)) {
                           EnemyPlane7Arr.push(Level.moveItemList[j2])
                        }
                    }

                    var enemyPlane71:EnemyPlane7 = new EnemyPlane7(enemyPlane.x - 230, enemyPlane.y + 80);
                    Level.moveItemList.push(enemyPlane71); // x = 960 屏幕宽度 防止提前碰边界
                    var enemyPlane72:EnemyPlane7 = new EnemyPlane7(enemyPlane.x + 230, enemyPlane.y + 80);
                    Level.moveItemList.push(enemyPlane72); // x = 960 屏幕宽度 防止提前碰边界
                });
               
                return;
            }

            
            for (var i:int = 0; i < row.length; i++) {
                // // 添加敌机
                if (row[i] == 0) {
                    continue;
                }
                var reload:Boolean = false;
                for (var j:int = 0; j < Level.moveItemList.length; j++) {
                    if (Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is enemyTypeArr[row[i]])) {
                        Level.moveItemList[j].myReBorn(10 + baseX + stageWidth / 7 * i, 0);
                        reload = true;
                        break;
                    }
                }
                if(!reload){
                    var enemyPlane:* = new enemyTypeArr[row[i]](10 + baseX + stageWidth / 7 * i, 0);
                    Level.moveItemList.push(enemyPlane); // x = 960 屏幕宽度 防止提前碰边界
                }
            }
        }
    }
}
