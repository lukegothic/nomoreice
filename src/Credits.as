package 
{
	
	import net.flashpunk.World;
	import net.flashpunk.utils.Input; 
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class Credits extends World
	{
		
		[Embed(source = 'assets/CREDITS.png')] private var InstructionsIMG:Class; 
		
		public function Credits():void 
		{
			addGraphic(new Image(InstructionsIMG), 0, 0, 0);
			add(new TextHelperEntity("Press <SPACE> to continue", 270, 550, 500, 32, 32, 0x000000))

		}
		
		override public function update():void
		{
			if (Input.pressed(Key.SPACE))
			{
				FP.world = null;
				FP.world = new MainMenu();
				
			}
		}
	}
	
}