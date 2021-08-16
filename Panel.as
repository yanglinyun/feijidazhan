package  {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class Panel extends StaticGameItem{

		private var missleArr:Array = [];
		public function Panel(posX:Number, posY:Number, width:Number=0, height:Number=0, rotation:Number=0) {
			super(posX, posY, width, height, rotation);
			//this.addEventListener("PlaneLifeChange", updateInfo);
			initMissleArr();
		}

		private function initMissleArr():void
		{
			var  missleArea:MovieClip = (getChildByName("missleArea") as MovieClip)
			for(var i:int=0; i<8; i++){
				var curMissle:MovieClip = ((missleArea.getChildByName("m"+i) as MovieClip).getChildByName("state") as MovieClip);
				missleArr.push(curMissle);
				curMissle.isValid = true;
				curMissle.gotoAndStop(10);
			}
		}
	    
		
		public function updateInfo(curLife:Number, totalLife:Number){
			var textField1:TextField = TextField(getChildByName("myLife"));
			textField1.text=(curLife+"/"+totalLife);
			((getChildByName("lifeBar") as MovieClip).getChildByName("mc") as MovieClip).gotoAndStop(Math.ceil((totalLife - curLife) / totalLife  * 100));
			
		}
		public function updateScore(addScore:Number){
			var textField1:TextField = TextField(getChildByName("score"));
			textField1.text=(parseInt(textField1.text) + addScore+"");
			
			
		}
	}
	
}
