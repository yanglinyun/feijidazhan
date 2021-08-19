package {

    import flash.display.MovieClip;
    class LevelRow {
        protected static var stageWidth = GameItem.ScreenWidth - MoveGameItem.panel.width;
        protected static var baseX = MoveGameItem.panel.width;
        private static var enemyTypeArr:Array = [null, EnemyPlane1, EnemyPlane2, EnemyPlane3, EnemyPlane4];
        private static var bossEffect:MovieClip = new BossEffect( MoveGameItem.panel.width, 0).getChildByName("mc") as MovieClip;
        public static function generate(row:Array) {
            if(row[0]==-1){
                // 播放boss动画
                bossEffect.x = MoveGameItem.panel.width;
                bossEffect.gotoAndPlay(1);
                GameItem.stage.addChild(bossEffect);
                bossEffect.addFrameScript(bossEffect.totalFrames - 1, function() {
                    Level.bossEffectComplete = false;
                    bossEffect.stop();
                    
                    if (GameItem.stage.contains(bossEffect)) {
                         GameItem.stage.removeChild(bossEffect);
                    }
                   
                    Level.bossEffectComplete = true;

                    // 替换real boss 
                    for (var j:int = 0; j < Level.moveItemList.length; j++) {
                        if (Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is EnemyPlane6)) {
                            Level.moveItemList[j].myReBorn(10 + baseX + 250, 110);

                            continue;
                        }
                    }

                    var enemyPlane:* = new EnemyPlane6(10 + baseX + 250, 110);
                    Level.moveItemList.push(enemyPlane); // x = 960 屏幕宽度 防止提前碰边界
                });
               
                return;
            }
            for (var i:int = 0; i < row.length; i++) {
                // // 添加敌机
                if (row[i] == 0) {
                    continue;
                }
                for (var j:int = 0; j < Level.moveItemList.length; j++) {
                    if (Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is enemyTypeArr[row[i]])) {
                        Level.moveItemList[j].myReBorn(10 + baseX + stageWidth / 7 * i, 0);

                        continue;
                    }
                }

                var enemyPlane:* = new enemyTypeArr[row[i]](10 + baseX + stageWidth / 7 * i, 0);
                Level.moveItemList.push(enemyPlane); // x = 960 屏幕宽度 防止提前碰边界

            }
        }
    }
}
