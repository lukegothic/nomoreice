package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	//[Embed(source = 'assets/sounds/death.png')] private var MUSICMENU:Class;
	//[Embed(source = 'assets/sounds/lose.png')] private var MUSICJUEGO:Class;
	//[Embed(source = 'assets/sounds/win.png')] private var MUSICMENU:Class;
	//[Embed(source = 'assets/sounds/tecla.png')] private var MUSICJUEGO:Class;
	//[Embed(source = 'assets/sounds/save.png')] private var MUSICMENU:Class;
	//[Embed(source = 'assets/sounds/no.png')] private var MUSICJUEGO:Class;
	

	[SWF(width="960", height="600")]
	public class Main extends Engine 
	{	
	

		
		public function Main():void 
		{
			super(960, 600, 60, false);
			FP.world = new MainMenu();
		}
		override public function init():void 
		{
			trace("FlashPunk has started successfully!");
		}
	}
}
 