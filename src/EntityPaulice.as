package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	public class EntityPaulice extends Entity
	{
		protected var _resistencias:Array;		
		protected var _direccion:Boolean;	//0 - false - izquierda | 1 - true - derecha
		protected var _estaMoviendose:Boolean;
		protected var _velX:int = 1;
		protected var _velY:int;
		protected var _spriteMap:Spritemap;
		protected var _spriteMapAnim:Spritemap;
		private var _isDead:Boolean;
		
		[Embed(source = 'assets/sounds/save.mp3')] private var PSAVE:Class;
		private var _sfxPSave:Sfx = new Sfx(PSAVE);
		[Embed(source = 'assets/sounds/death.mp3')] private var PDEATH:Class;
		private var _sfxPDeath:Sfx = new Sfx(PDEATH);
		
		//sets paulices
		[Embed(source = 'assets/pauliceAzul.png')]
		private const IMAGE_PAULICE_AZUL:Class;
		[Embed(source = 'assets/pauliceRojo.png')]
		private const IMAGE_PAULICE_ROJO:Class;
		[Embed(source = 'assets/pauliceAmarillo.png')]
		private const IMAGE_PAULICE_AMARILLO:Class;
		[Embed(source = 'assets/pauliceNaranja.png')]
		private const IMAGE_PAULICE_NARANJA:Class;
		[Embed(source = 'assets/pauliceMorado.png')]
		private const IMAGE_PAULICE_MORADO:Class;
		[Embed(source = 'assets/pauliceVerde.png')]
		private const IMAGE_PAULICE_VERDE:Class;
		
		private var _isFalling:Boolean;
		private const FALLSPEED:int = 5;
		
		// Animations
		protected var _spriteMapDeathStairs:Spritemap;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_AZUL.png')]
		private const IMAGE_DEATHSTAIRS_AZUL:Class;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_AMARILLO.png')]
		private const IMAGE_DEATHSTAIRS_AMARILLO:Class;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_ROJO.png')]
		private const IMAGE_DEATHSTAIRS_ROJO:Class;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_VERDE.png')]
		private const IMAGE_DEATHSTAIRS_VERDE:Class;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_NARANJA.png')]
		private const IMAGE_DEATHSTAIRS_NARANJA:Class;
		[Embed(source = 'assets/deathanims/DEATH_STAIRS_MORADO.png')]
		private const IMAGE_DEATHSTAIRS_MORADO:Class;
		protected var _spriteMapSaveStairs:Spritemap;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_AZUL.png')]
		private const IMAGE_SAVESTAIRS_AZUL:Class;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_AMARILLO.png')]
		private const IMAGE_SAVESTAIRS_AMARILLO:Class;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_ROJO.png')]
		private const IMAGE_SAVESTAIRS_ROJO:Class;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_MORADO.png')]
		private const IMAGE_SAVESTAIRS_MORADO:Class;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_VERDE.png')]
		private const IMAGE_SAVESTAIRS_VERDE:Class;
		[Embed(source = 'assets/saveanims/SAVE_STAIRS_NARANJA.png')]
		private const IMAGE_SAVESTAIRS_NARANJA:Class;

		//Deathanims
		protected var _spriteMapDeathHole:Spritemap;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_AZUL.png')]
		private const IMAGE_DEATHHOLE_AZUL:Class;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_ROJO.png')]
		private const IMAGE_DEATHHOLE_ROJO:Class;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_AMARILLO.png')]
		private const IMAGE_DEATHHOLE_AMARILLO:Class;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_VERDE.png')]
		private const IMAGE_DEATHHOLE_VERDE:Class;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_NARANJA.png')]
		private const IMAGE_DEATHHOLE_NARANJA:Class;
		[Embed(source = 'assets/deathanims/DEATH_HOLE_MORADO.png')]
		private const IMAGE_DEATHHOLE_MORADO:Class;
		
		protected var _spriteMapSaveHole:Spritemap;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_AZUL.png')]
		private const IMAGE_SAVEHOLE_AZUL:Class;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_AMARILLO.png')]
		private const IMAGE_SAVEHOLE_AMARILLO:Class;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_ROJO.png')]
		private const IMAGE_SAVEHOLE_ROJO:Class;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_MORADO.png')]
		private const IMAGE_SAVEHOLE_MORADO:Class;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_VERDE.png')]
		private const IMAGE_SAVEHOLE_VERDE:Class;
		[Embed(source = 'assets/saveanims/SAVE_HOLE_NARANJA.png')]
		private const IMAGE_SAVEHOLE_NARANJA:Class;
		
		protected var _spriteMapDeathWall:Spritemap;
		[Embed(source = 'assets/deathanims/DEATH_WALL_AZUL.png')]
		private const IMAGE_DEATHWALL_AZUL:Class;
		[Embed(source = 'assets/deathanims/DEATH_WALL_AMARILLO.png')]
		private const IMAGE_DEATHWALL_AMARILLO:Class;
		[Embed(source = 'assets/deathanims/DEATH_WALL_ROJO.png')]
		private const IMAGE_DEATHWALL_ROJO:Class;
		[Embed(source = 'assets/deathanims/DEATH_WALL_VERDE.png')]
		private const IMAGE_DEATHWALL_VERDE:Class;
		[Embed(source = 'assets/deathanims/DEATH_WALL_NARANJA.png')]
		private const IMAGE_DEATHWALL_NARANJA:Class;
		[Embed(source = 'assets/deathanims/DEATH_WALL_MORADO.png')]
		private const IMAGE_DEATHWALL_MORADO:Class;
		protected var _spriteMapSaveWall:Spritemap;
		[Embed(source = 'assets/saveanims/SAVE_WALL_AZUL.png')]
		private const IMAGE_SAVEWALL_AZUL:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_AMARILLO.png')]
		private const IMAGE_SAVEWALL_AMARILLO:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_ROJO.png')]
		private const IMAGE_SAVEWALL_ROJO:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_MORADO.png')]
		private const IMAGE_SAVEWALL_MORADO:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_VERDE.png')]
		private const IMAGE_SAVEWALL_VERDE:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_NARANJA.png')]
		private const IMAGE_SAVEWALL_NARANJA:Class;
		
		public function EntityPaulice(x:int, y:int, direccion:Boolean, resistencias:Array):void 
		{
			_resistencias = new Array(resistencias[Constants.CONST_TYPE_STAIRS], resistencias[Constants.CONST_TYPE_HOLE], resistencias[Constants.CONST_TYPE_WALL]);
			_direccion = direccion;
			this.x = x;
			this.y = y;
			_isFalling = true;
			type = "PAULICE";
			_isDead = false;
			cargarAnimaciones();
			layer = 60;
		}
		
		private function cargarAnimaciones():void 
		{

			if (_resistencias[Constants.CONST_TYPE_STAIRS] == 0 && _resistencias[Constants.CONST_TYPE_HOLE] == 1 && _resistencias[Constants.CONST_TYPE_WALL] == 1)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_NARANJA, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_NARANJA, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_NARANJA, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_NARANJA, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_NARANJA, 40, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_NARANJA, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_NARANJA, 38, 40, AnimationCallBack);
				
			}else if (_resistencias[Constants.CONST_TYPE_STAIRS] == 1 && _resistencias[Constants.CONST_TYPE_HOLE] == 0 && _resistencias[Constants.CONST_TYPE_WALL] == 1)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_VERDE, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_VERDE, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_VERDE, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_VERDE, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_VERDE, 40, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_VERDE, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_VERDE, 38, 40, AnimationCallBack);
			}else if (_resistencias[Constants.CONST_TYPE_STAIRS] == 1 && _resistencias[Constants.CONST_TYPE_HOLE] == 1 && _resistencias[Constants.CONST_TYPE_WALL] == 0)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_MORADO, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_MORADO, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_MORADO, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_MORADO, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_MORADO, 35, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_MORADO, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_MORADO, 38, 40, AnimationCallBack);
			}else if (_resistencias[Constants.CONST_TYPE_STAIRS] == 0 && _resistencias[Constants.CONST_TYPE_HOLE] == 0 && _resistencias[Constants.CONST_TYPE_WALL] == 1)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_AMARILLO, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_AMARILLO, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_AMARILLO, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_AMARILLO, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_AMARILLO, 40, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_AMARILLO, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_AMARILLO, 38, 40, AnimationCallBack);
			}else if (_resistencias[Constants.CONST_TYPE_STAIRS] == 0 && _resistencias[Constants.CONST_TYPE_HOLE] == 1 && _resistencias[Constants.CONST_TYPE_WALL] == 0)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_ROJO, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_ROJO, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_ROJO, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_ROJO, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_ROJO, 40, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_ROJO, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_ROJO, 38, 40, AnimationCallBack);
			}else if (_resistencias[Constants.CONST_TYPE_STAIRS] == 1 && _resistencias[Constants.CONST_TYPE_HOLE] == 0 && _resistencias[Constants.CONST_TYPE_WALL] == 0)
			{
				_spriteMap = new Spritemap(IMAGE_PAULICE_AZUL, 20, 20 /*, callbackFinAnimacion*/);
				_spriteMapDeathStairs = new Spritemap(IMAGE_DEATHSTAIRS_AZUL, 40, 80, AnimationCallBack);
				_spriteMapSaveStairs = new Spritemap(IMAGE_SAVESTAIRS_AZUL, 40, 80, AnimationCallBack);
				_spriteMapDeathWall = new Spritemap(IMAGE_DEATHWALL_AZUL, 40, 40, AnimationCallBack);
				_spriteMapSaveWall = new Spritemap(IMAGE_SAVEWALL_AZUL, 40, 20, AnimationCallBack);
				_spriteMapDeathHole = new Spritemap(IMAGE_DEATHHOLE_AZUL, 40, 80, AnimationCallBack);
				_spriteMapSaveHole = new Spritemap(IMAGE_SAVEHOLE_AZUL, 38, 40, AnimationCallBack);
			}
			_spriteMap.add("andar", [0, 1, 2, 3, 4, 5], 10, true);
			width = _spriteMap.width;
			height = _spriteMap.height;
			graphic = _spriteMap;
			
			_spriteMapDeathStairs.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9 , 10, 11, 12, 13, 14, 15], 10, false);
			_spriteMapDeathStairs.y -= _spriteMapDeathStairs.height - _spriteMap.height;
			
			_spriteMapSaveStairs.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9 , 10, 11, 12, 13, 14], 10, false);
			_spriteMapSaveStairs.y -= _spriteMapSaveStairs.height - _spriteMap.height;
			
			
			_spriteMapDeathWall.add("anim", [0, 1, 2, 3, 4, 5], 10, false);
			_spriteMapDeathWall.y -= _spriteMapDeathWall.height - _spriteMap.height;
			
			_spriteMapSaveWall.add("anim", [0, 1, 2, 3, 4, 5, 6], 12, false);
			_spriteMapSaveWall.y -= _spriteMapSaveWall.height - _spriteMap.height;
			
			_spriteMapSaveHole.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10, false);
			_spriteMapSaveHole.y -= _spriteMapSaveHole.height - _spriteMap.height;
			
			_spriteMapDeathHole.add("anim", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ,12], 10, false);
			
			
			if (!_direccion) {
				_spriteMapDeathStairs.flipped = true;
				_spriteMapSaveStairs.flipped = true;
				_spriteMapSaveStairs.x -= _spriteMap.width;
				_spriteMapDeathStairs.x -= _spriteMap.width;
				_spriteMapDeathWall.flipped = true;
				_spriteMapSaveWall.flipped = true;
				_spriteMapSaveWall.x -= _spriteMap.width;
				_spriteMapSaveHole.flipped = true;
				_spriteMapSaveHole.x -= _spriteMap.width;
				_spriteMapDeathHole.flipped = true;
				_spriteMapDeathHole.x -= _spriteMapDeathHole.width;
			}
		}
		
		override public function update():void {
			if (_isFalling) {
				var groundLevel:int = ((Level) (FP.world)).GROUNDLEVEL;
				if ((y + _spriteMap.height + FALLSPEED) > groundLevel) {
					_isFalling = false;
					y = groundLevel - _spriteMap.height;
					_spriteMap.play("andar");
					_estaMoviendose = true;
				} else {
					y += FALLSPEED;
				}
			} else if(_estaMoviendose) {
				this.x += _direccion ? _velX : -_velX;
			}
			comprobarColisiones();
		}
		
		private function comprobarColisiones():void 
		{
			var e:Entity;
			var trapType:int;
			var hasCollided:Boolean = false;
			var theWorld:Level = ((Level) (FP.world));
			e = collide("GATE", x, y);
			if (e != null) {
				theWorld.SeHaSalvadoUno = true;
				FP.world.remove(this);
				// TODO: Anim de final, en el callback borrarlo
			} else {
				e = collide("TRAP_STAIRS", x - (_direccion ? _spriteMap.width : 0), y);
				if (e != null) {
					trapType = ((Trap) (e))._trapType;
					if (_resistencias[trapType] == 1) {
						_spriteMapAnim = _spriteMapSaveStairs;
						_sfxPSave.play();
					} else {
						_spriteMapAnim = _spriteMapDeathStairs;
						_isDead = true;			
						_sfxPDeath.play();			
					}
					_estaMoviendose = false;
				} else {
					e = collide("TRAP_HOLE", x - (_direccion ? _spriteMap.width / 2 : _spriteMap.width * 2), y);
					if (e != null) {
						trapType = ((Trap) (e))._trapType;
						if (_resistencias[trapType] == 1) {
							//TODO: sprite salto hole
							_spriteMapAnim = _spriteMapSaveHole;
							_sfxPSave.play();
						} else {
							//TODO: sprite muerte hole
							_spriteMapAnim = _spriteMapDeathHole;
							_isDead = true;	
							_estaMoviendose = false;
							_sfxPDeath.play();		
						}
						
					} else {
						e = collide("TRAP_WALL", x - (_direccion ? -_spriteMap.width : _spriteMap.width ), y);
						if (e != null) {
							trapType = ((Trap) (e))._trapType;
							if (_resistencias[trapType] == 1) {
								_spriteMapAnim = _spriteMapSaveWall;
								((Trap) (e)).destruirPared();
								_sfxPSave.play();
							} else {
								_spriteMapAnim = _spriteMapDeathWall;
								_isDead = true;		
								_sfxPDeath.play();						
							}
							_estaMoviendose = false;
						}
					}
				}
				if (e != null) {
					graphic = _spriteMapAnim;
					//_estaMoviendose = false;
					_spriteMapAnim.play("anim");
				}
			}

		}
		
		private function AnimationCallBack():void 
		{
			_spriteMapAnim.setFrame(0, 0);
			if (_isDead) {
				FP.world.remove(this);
				((Level) (FP.world)).pKilled += 1;
			} else {
				if (!_estaMoviendose)
				{
					x += _direccion ? _spriteMapAnim.width : -_spriteMapAnim.width;
				}else{
					x += _direccion ? _spriteMap.width : -_spriteMap.width;					
					
				}
				_estaMoviendose = true;
				
				graphic = _spriteMap;
				_spriteMap.play("andar");
			}
		}
		
	}
}