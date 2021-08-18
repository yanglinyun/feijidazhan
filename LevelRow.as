package{
    class LevelRow{
        protected static var stageWidth = GameItem.ScreenWidth - MoveGameItem.panel.width;
        protected static var baseX =MoveGameItem.panel.width;
        private static var enemyTypeArr:Array = 
        [null,EnemyPlane1,EnemyPlane2,EnemyPlane3,EnemyPlane4];
        public static function generate(row:Array) {
            for(var i:int=0; i<row.length; i++){
                // // 添加敌机
                if(row[i]==0){
                   continue;
                }
                for(var j:int=0; j<Level.moveItemList.length; j++){
                    if(Level.moveItemList[j].isFreeze && (Level.moveItemList[j] is enemyTypeArr[row[i]])){
                       Level.moveItemList[j].myReBorn(10 + baseX + stageWidth/7 * i, 0);
                       
                        continue;
                    }
			    }
                
                var enemyPlane:* = new enemyTypeArr[row[i]](10 + baseX + stageWidth/7 * i, 0);
                Level.moveItemList.push(enemyPlane);// x = 960 屏幕宽度 防止提前碰边界
             
            }
        }
    }
}