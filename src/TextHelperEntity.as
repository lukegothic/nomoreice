package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	public class TextHelperEntity extends Entity
	{
		public var _text:Text;
		//[Embed(source = 'assets/font/wst_ital.fon', embedAsCFF = "false", fontFamily = 'My Font')]
		//private const MY_FONT:Class;


		public function TextHelperEntity(text:String, x:int, y:int, textWidth:int, textHeight:int, size:int = 16, textColor:uint = 0xFFFFFF ) 
		{
			this.x = x;
			this.y = y;
			_text = new Text(text, 0, 0, textWidth, textHeight);
			_text.color = textColor;
			_text.size = size;
			//_text.font = "My Font";
			graphic = _text;
		}
	}
}