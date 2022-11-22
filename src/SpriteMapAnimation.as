package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Luke
	 */
	public class SpriteMapAnimation extends Entity
	{
		public var spawnanimation:Spritemap;
		public function SpriteMapAnimation(s:Spritemap) 
		{
			spawnanimation = s;
			graphic = spawnanimation;
		}
		
	}

}