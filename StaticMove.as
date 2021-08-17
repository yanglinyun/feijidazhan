package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;// 发送事件类

	public class StaticMove extends Move
	{
        private var that:MoveGameItem;
		public function StaticMove(artRes:MoveGameItem, direction:Array=null, frameSpeed:Array=null, moveNode:Array=null)
		{
			super(artRes, [], [], []);
            that = artRes;
		}

		override public function update()
		{
            
            this.artRes.dispatchEvent(new Event('MoveComplete'));
        }
	}

}