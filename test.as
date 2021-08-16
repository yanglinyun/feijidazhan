package 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class test extends Sprite
	{
		private var TestTime:Timer = new Timer(1000);
		private var timeCount = 0;
		public function test()
		{
			//trace(stage.stageWidth, stage.stageHeight);
			// TestTime.addEventListener(TimerEvent.TIMER,OnTimer);
			// TestTime.start();

			// stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
		}

		

		private function OnTimer(e:TimerEvent)
		{
			//trace(timeCount);
			//trace("========================================");
			timeCount = 0;
		}
		public function KeyDownHandler(e:KeyboardEvent)
		{
			timeCount++;
			
		}
	}
};