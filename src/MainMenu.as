package 
{
	
	import net.flashpunk.World;
	import net.flashpunk.utils.Input; 
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;

	public class MainMenu extends World
	{
		
		[Embed(source = 'assets/TITLE1.png')] private var MainMenuIMG:Class; 
		[Embed(source = 'assets/sounds/music1.mp3')] private var MUSICMENU:Class;
		private var _sfxMusicMenu:Sfx = new Sfx(MUSICMENU);
		
		public function MainMenu():void 
		{
			addGraphic(new Image(MainMenuIMG), 0, 0, 0);
			add(new TextHelperEntity("Press <SPACE>", 350, 500, 400, 32, 32, 0x000000))
			
			_sfxMusicMenu.loop();
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.SPACE))
			{
				_sfxMusicMenu.stop();
				FP.world = null;
				FP.world = new Instructions();
				
			}
		}
	}
	
}