package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;

	public class test extends Sprite
	{
		var role:Sprite;
		var speed:int = 5;
		var keyObj:Object = {};
		var keyArr:Array = [];
		public function test():void
		{
			role=new Sprite();
			role.graphics.beginFill(0xff00ff);
			role.graphics.drawRect(10,-40,20,40);
			role.graphics.endFill();
			role.x = 150;
			role.y = 200;
			addChild(role);
			stage.focus = this;
			keyOne();
		}



		private function keyOne()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,KeyUpHandler);
		}

		private function KeyDownHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = true;

			if (keyObj[32])
			{
				trace("space");
				//role.y -=  3 * speed;
			}
			if (keyObj[37])
			{
				trace("left");
				role.x -=  speed;
			}
			if (keyObj[38])
			{
				trace("down");
				role.y -=  speed;
			}
			if (keyObj[39])
			{
				trace("right");
				role.x +=  speed;
			}

			if (keyObj[40])
			{
				trace("up");
				role.y +=  speed;
			}

			if (keyObj[13] && keyObj[17])
			{
				trace("八连杀，好无敌。我要发射了。");
				var txt:TextField=new TextField();
				txt.multiline = true;
				txt.wordWrap = true;
				txt.text = "八连杀，好强大。一句就能爆菊花！";
				txt.x=int(50*Math.random());
				txt.y=-int(200*Math.random());
				while (role.numChildren>0)
				{
					role.removeChildAt(0);
				}
				role.addChild(txt);
			}
		}

		private function KeyUpHandler(e:KeyboardEvent)
		{
			keyObj[e.keyCode] = false;
		}

		private function keyTwo()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}

		private function keyDownHandler(e:KeyboardEvent)
		{
			var num = keyArr.indexOf(e.keyCode);
			if (num<0)
			{
				keyArr.push(e.keyCode);
			}
		}

		private function keyUpHandler(e:KeyboardEvent)
		{
			var num = keyArr.indexOf(e.keyCode);
			if (num>=0)
			{
				keyArr.splice(num,1);
			}

		}

		private function enterFrameHandler(e:Event)
		{
			trace(keyArr);
		}
	}
}