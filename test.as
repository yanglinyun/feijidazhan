
package 
{
	import flash.display.Sprite;

	public class test extends Sprite
	{

		public function test()
		{

		
			var myXML = new XML();
			myXML.load("data.xml");
			myXML.ignoreWhite = true;
			
			myXML.onLoad = function(success){
			if(success){
			trace(myXML)
			}
			};
			
		}

	}
}