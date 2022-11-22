package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import mx.core.ByteArrayAsset;
	
	public class Level extends World 
	{ 
		[Embed(source = "assets/levels/stage1.txt", mimeType = "application/octet-stream")] private const STAGE1FILECLASS:Class;
		[Embed(source = "assets/levels/stage2.txt", mimeType = "application/octet-stream")] private const STAGE2FILECLASS:Class;
		[Embed(source = "assets/levels/stage3.txt", mimeType = "application/octet-stream")] private const STAGE3FILECLASS:Class;
		[Embed(source = "assets/levels/stage4.txt", mimeType = "application/octet-stream")] private const STAGE4FILECLASS:Class;
		[Embed(source = "assets/levels/stage5.txt", mimeType = "application/octet-stream")] private const STAGE5FILECLASS:Class;
		[Embed(source = "assets/levels/stage6.txt", mimeType = "application/octet-stream")] private const STAGE6FILECLASS:Class;
		[Embed(source = 'assets/background.png')] private var BackgroundIMG:Class;
		[Embed(source = 'assets/spritefuego.png')] private var SpawnANIM:Class;
		[Embed(source = 'assets/TITLE3END.png')] private var GameOverIMG:Class;
		[Embed(source = 'assets/TITLE4END.png')] private var FinNivelIMG:Class;
		[Embed(source = 'assets/TITLE4END.png')] private var FinJuegoIMG:Class;
		
		[Embed(source = 'assets/sounds/music2.mp3')] private var MUSICJUEGO:Class;
		private var _sfxMusicJuego:Sfx = new Sfx(MUSICJUEGO);
		
		[Embed(source = 'assets/sounds/win.mp3')] private var WINGAME:Class;
		private var _sfxWinSound:Sfx = new Sfx(WINGAME);
		
		[Embed(source = 'assets/sounds/lose.mp3')] private var LOSEGAME:Class;
		private var _sfxLoseSound:Sfx = new Sfx(LOSEGAME);
		
		[Embed(source = 'assets/sounds/tecla.mp3')] private var TECLA:Class;
		private var _sfxTeclaSound:Sfx = new Sfx(TECLA);
		
		private var stageArray:Array = [STAGE1FILECLASS, STAGE2FILECLASS, STAGE3FILECLASS, STAGE4FILECLASS, STAGE5FILECLASS, STAGE6FILECLASS];
		private var stageNumber:int;
		//izqda = 0; dcha = 1
		private var state:int = 0;
		private var mostradoTextoEspacio:Boolean = false;
		public var pTotal:int = 0;
		public var pKilled:int = 0;
		public var pSalvados:int;
		public var pRestantes:int;
		public var SeHaSalvadoUno:Boolean;
		private var ultDir:Boolean;
		private var selectedTrap:int;
		private var pExitPoint:Boolean;
		private var pArray:Array;
		private var tArray:Array;
		//private var gArray:Array;
		private var gen1X:int;
		private var gen1Y:int;
		private var gen1Intervalo:int;
		private var gen2X:int;
		private var gen2Y:int;
		private var gen2Intervalo:int;
		private var primeraVez:Boolean = false;	//CREMACIA!!
		private var spawnInterval:Number;
		private var elapsedTime:Number = 0;
		public const GROUNDLEVEL:int = 280;
		private var selectedWeapon:Number = -1;
		private var killedPercentageText:TextHelperEntity
		private var stairsWeaponCountText:TextHelperEntity
		private var holeWeaponCountText:TextHelperEntity
		private var wallWeaponCountText:TextHelperEntity
		private var i:int;
		private const CONST_NUMBER_LEVELS:int = 6;
		
		
        private var _HUDGraphicList:Graphiclist;
        private var _HUDTrapArray:Array = new Array;
        [Embed(source = "assets/hud/boton_A.png")] private const TRAMPA1:Class;
        [Embed(source = "assets/hud/boton_S.png")] private const TRAMPA2:Class;
        [Embed(source = "assets/hud/boton_D.png")] private const TRAMPA3:Class;
		[Embed(source = "assets/hud/LEGEND.png")] private const LEGEND:Class;
		
		public function Level(pStartInt:int, fichero:int) 
		{
			i = 0;
			stageNumber = fichero;
			pArray = new Array();
			tArray = new Array();
			//gArray = new Array();
			initStage();
			pArray.reverse();	//CREMACIA!!
			ultDir = true;
			spawnInterval = pStartInt;
			add(new Trap(Constants.CONST_TYPE_GATE, 440, GROUNDLEVEL - 80));
			pSalvados = 0;
			SeHaSalvadoUno = false;
			killedPercentageText = new TextHelperEntity(getKilledPercentage(), 675, 455, 300, 60, 60);
			stairsWeaponCountText = new TextHelperEntity("x" + tArray[Constants.CONST_TYPE_STAIRS].toString(), 105, 501, 50, 20, 20);
			stairsWeaponCountText.layer = 1;
			holeWeaponCountText = new TextHelperEntity("x" + tArray[Constants.CONST_TYPE_HOLE].toString(), 213, 503, 50, 20, 20);
			holeWeaponCountText.layer = 1;
			wallWeaponCountText = new TextHelperEntity("x" + tArray[Constants.CONST_TYPE_WALL].toString(), 323, 503, 50, 20, 20);
			wallWeaponCountText.layer = 1;
			add(killedPercentageText);
			add(stairsWeaponCountText);
			add(holeWeaponCountText);
			add(wallWeaponCountText);
			addGraphic(new Image(BackgroundIMG), 100, 0, 0);
			drawHUD();
			_sfxMusicJuego.loop(0.2);
		}
		
		override public function update():void 
		{
			if (SeHaSalvadoUno) {
				addGraphic(new Image(GameOverIMG), 1, 0, 0);
				state = 2; // Game Over, reiniciar nivel
				add(new TextHelperEntity("Press <SPACE> to retry", 300, 500 , 600, 32, 32, 0x000000));
				_sfxMusicJuego.stop();
				if (!mostradoTextoEspacio)
					_sfxLoseSound.play();
				mostradoTextoEspacio = true;
			}
			if (pTotal == pKilled) {
				if ((stageNumber + 1) == CONST_NUMBER_LEVELS)
				{
					addGraphic(new Image(FinJuegoIMG), 1, 0, 0);
					state = 3; // Fin del juego, ganador
					add(new TextHelperEntity("Press <SPACE> to end the game", 300, 500, 600, 32, 32, 0x000000));
					_sfxMusicJuego.stop();
					if (!mostradoTextoEspacio)
						_sfxWinSound.play();
					mostradoTextoEspacio = true;
				}else {
					addGraphic(new Image(FinNivelIMG), 1, 0, 0);
					state = 1; // nivel pasado
					add(new TextHelperEntity("Press <SPACE> to go to next level", 300, 500, 600, 32, 32, 0x000000));
					_sfxMusicJuego.stop();
					if (!mostradoTextoEspacio)
						_sfxWinSound.play();
					mostradoTextoEspacio = true;
				}
			}
			if (pArray.length > 0) {
				elapsedTime += FP.elapsed;
				if (elapsedTime > spawnInterval) {
					add(new EntityPaulice(ultDir ? gen1X : gen2X, ultDir ? gen1Y : gen2Y, ultDir, pArray[pArray.length - 1].split(/,/)));
					
					var spawnanimation:Spritemap;
					spawnanimation = new Spritemap(SpawnANIM, 20, 60);
					spawnanimation.add("play", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 15, false);
					spawnanimation.x = ultDir ? gen1X : gen2X;
					spawnanimation.y = ultDir ? gen1Y : gen2Y;
					spawnanimation.play("play");
					addGraphic(spawnanimation);

					ultDir = !ultDir;
					pArray.pop();
					elapsedTime = 0;
				}
			}
			ProcessKeyboard();
			ProcessMouse();
			killedPercentageText._text.text = getKilledPercentage();
			if (state != 1 && state != 2 && state != 3) {
				super.update();
			}
		}
		
		private function getKilledPercentage():String
		{
			return ((pKilled / pTotal) * 100).toFixed(2);
		}
		private function GetWeaponName(weaponID:int):String 
		{
			switch (weaponID) 
			{
				case Constants.CONST_TYPE_STAIRS:
					return "Escalera";
				break;
				case Constants.CONST_TYPE_HOLE:
					return "Hoyo";
				break;
				case Constants.CONST_TYPE_WALL:
					return "Muro";
				break;
				default:
					return "No seleccionada";
				break;
			}
		}
		private function ProcessKeyboard():void {
			if (Input.pressed(Key.A) && tArray[Constants.CONST_TYPE_STAIRS] > 0) {
				selectedWeapon = Constants.CONST_TYPE_STAIRS;
				selectTrapHUD(Constants.CONST_TYPE_STAIRS);
				_sfxTeclaSound.play();

			}
			if (Input.pressed(Key.S) && tArray[Constants.CONST_TYPE_HOLE] > 0) {
				
				selectedWeapon = Constants.CONST_TYPE_HOLE;
				selectTrapHUD(Constants.CONST_TYPE_HOLE);
				_sfxTeclaSound.play();
			}
			if (Input.pressed(Key.D) && tArray[Constants.CONST_TYPE_WALL] > 0) {
				selectedWeapon = Constants.CONST_TYPE_WALL;
				selectTrapHUD(Constants.CONST_TYPE_WALL);
				_sfxTeclaSound.play();
			}
			if (Input.pressed(Key.SPACE)) {
				if (state == 1)
				{					
					_sfxMusicJuego.stop();
					FP.world = new Level(2, stageNumber + 1);
				}
				else if (state == 2)
				{
					_sfxMusicJuego.stop();
					FP.world = new Level(2, stageNumber);
				}
				else if (state == 3)
				{
					_sfxMusicJuego.stop();
					FP.world = new Credits();
				}
			}
		}
		private function ProcessMouse():void {
			if ((selectedWeapon != -1) && Input.mousePressed && (mouseY < GROUNDLEVEL)) {			
				var t:Trap = new Trap(selectedWeapon, mouseX, mouseY);
				if (collideRect("GATE", mouseX, 0, t._trapWidth, FP.screen.height) != null || collideRect("TRAP_STAIRS", mouseX, 0, t._trapWidth, FP.screen.height) != null || collideRect("TRAP_HOLE", mouseX, 0, t._trapWidth, FP.screen.height) != null || collideRect("TRAP_WALL", mouseX, 0, t._trapWidth, FP.screen.height) != null) {
					// HAY COLISION CON UNA TRAMPA, PLAY SOUND DE NO PODER PONER TRAMPA
				} else {
					add(t);
					tArray[selectedWeapon] -= 1;
					if (tArray[selectedWeapon] == 0) {
						selectedWeapon = -1;
					}
				}
			}
			stairsWeaponCountText._text.text = "x" + tArray[Constants.CONST_TYPE_STAIRS].toString();
			holeWeaponCountText._text.text = "x" + tArray[Constants.CONST_TYPE_HOLE].toString();
			wallWeaponCountText._text.text = "x" + tArray[Constants.CONST_TYPE_WALL].toString();
		}
		
		private function arrayToIce(ice:String):void
		{

			pArray[pArray.length] = ice;

		}
		
		private function arrayToTrap(trap:String):void
		{
			tArray[tArray.length] = trap;

		}
		
		private function arrayToGen(gen:String):void
		{
			//gArray[gArray.length] = gen;

			var arrayOfNumbers:Array = gen.split(/,/);
			if (!primeraVez)
			{
				primeraVez = true;
				gen1X = arrayOfNumbers[0];
				gen1Y = arrayOfNumbers[1];
				gen1Intervalo = arrayOfNumbers[2];
			}
			else
			{
				gen2X = arrayOfNumbers[0];
				gen2Y = arrayOfNumbers[1];
				gen2Intervalo = arrayOfNumbers[2];				
			}
		}
		
		private function initStage():void
		{			
			var fileByteArray:ByteArrayAsset = ByteArrayAsset(new stageArray[stageNumber]());
			var fileText:String = fileByteArray.readUTFBytes(fileByteArray.length);
			
			var i:int = 0;
			var j:int = 0;
			var tipo:String;
			var arrayOfLines:Array = fileText.split(/\n/);
			
			//trace(arrayOfLines + "EOf");
			
			var line:String = arrayOfLines[i];
			
			while (line != "")
			{

				if (line.toString().indexOf("Generadores") != -1)
				{					
					tipo = "Generadores";					
				}
				else if (line.toString().indexOf("Trampas") != -1)
				{
					tipo = "Trampas";
				}
				else if (line.toString().indexOf("Enemigos") != -1)
				{
					tipo = "Enemigos";
				}
				else 
				{
					
					if (tipo == "Generadores")
					{
						arrayToGen(line.toString());
					}else if (tipo == "Trampas")
					{
						arrayToTrap(line.toString());
					}else if (tipo == "Enemigos")
					{
						arrayToIce(line.toString());
						pTotal += 1;
					}
				
				}
				i++;

				line = arrayOfLines[i];
			}
			
			//DIBUJAR GENERADORES
			
		}
		
		
		public function drawHUD():void 
        {            
            _HUDGraphicList = new Graphiclist();
            
            var image:Image;
            

            //image = new Image(FONDOHUD);
            //image.x = 0;
            //image.y = 300;
            //_HUDGraphicList.add(image);
            
            var spritemap1:Spritemap;
            spritemap1 = new Spritemap(TRAMPA1, 99, 150);
            spritemap1.add("blink", [0, 1], 10, true);
            spritemap1.add("idle", [0], 10, true);
            spritemap1.x = 60;
            spritemap1.y = 405;
            _HUDGraphicList.add(spritemap1);
            spritemap1.play("idle");
            _HUDTrapArray.push(spritemap1);
            
            var spritemap2:Spritemap = new Spritemap(TRAMPA2, 99, 150);
            spritemap2.add("blink", [0, 1], 10, true);
            spritemap2.add("idle", [0], 10, true);
            spritemap2.x = 169;
            spritemap2.y = 405;
            _HUDGraphicList.add(spritemap2);
            spritemap2.play("idle");
            _HUDTrapArray.push(spritemap2);
            
            var spritemap3:Spritemap = new Spritemap(TRAMPA3, 99, 150);
            spritemap3.add("blink", [0, 1], 10, true);
            spritemap3.add("idle", [0], 10, true);
            spritemap3.x = 278;
            spritemap3.y = 405;
            _HUDGraphicList.add(spritemap3);
            spritemap3.play("idle");
            _HUDTrapArray.push(spritemap3);
            
			var spritemap4:Spritemap = new Spritemap(LEGEND, 266, 136);
            spritemap4.x = 387;
            spritemap4.y = 413;
            _HUDGraphicList.add(spritemap4);
            _HUDTrapArray.push(spritemap4);
			
			
			
		
			
            addGraphic(_HUDGraphicList, 30);
        }
        
        public function selectTrapHUD(i:int):void 
        {
            for (var ind:int = 0; ind < _HUDTrapArray.length; ind++)
            {
                if (ind == i)
                {
                    //trace("IGUAL");
                    ((Spritemap)(_HUDTrapArray[ind])).play("blink");
                }
                else
                {
                    //trace("DESIGUAL");
                    ((Spritemap)(_HUDTrapArray[ind])).play("idle");
                }
            }
            
		}

	}
}