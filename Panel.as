package  {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class Panel extends StaticGameItem{

		public function Panel(posX:Number, posY:Number, width:Number=0, height:Number=0, rotation:Number=0) {
			super(posX, posY, width, height, rotation);
			//this.addEventListener("PlaneLifeChange", updateInfo);
			
		}

		public function updateInfo(curLife:Number, totalLife:Number){
			var textField1:TextField = TextField(getChildByName("myLife"));
			textField1.text=(curLife+"/"+totalLife);
			((getChildByName("lifeBar") as MovieClip).getChildByName("mc") as MovieClip).gotoAndStop((totalLife - curLife) / totalLife * 100);
			
		}
	}
	
}
