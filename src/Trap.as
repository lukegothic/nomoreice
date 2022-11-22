package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	
	import Constants;
	/**
	 * ...
	 * @author Luke
	 */
	public class Trap extends Entity
	{
		public var _trapType:int;
		private var _isFalling:Boolean;
		private var _time:Number = 0;
		private var _spriteMap:Spritemap;
		private var _spriteMapDestruir:Spritemap;
		private var _counterText:TextHelperEntity;
		private var _isSurfaceTrap:Boolean;
		public var _trapWidth:int;
		
		/* Animaciones */
		//Escalera
		[Embed(source = 'assets/traps/TRAP_ESCALERA.png')]
		private const ASSET_TRAP_ESCALERA:Class;
		//Agua
		[Embed(source = 'assets/traps/TRAP_HOLE.png')]
		private const ASSET_TRAP_HOYO:Class;
		//Hoyo
		[Embed(source = 'assets/traps/TRAP_MURO.png')]
		private const ASSET_TRAP_MURO:Class;
		[Embed(source = 'assets/saveanims/SAVE_WALL_DEAD.png')]
		private const WALL_DEAD:Class;
		//Salida
		[Embed(source = 'assets/traps/porton.png')]
		private const ASSET_GATE:Class;
		
		private const FALLSPEED:int = 5;
		private const TIMEOUT:int = 2;
		
		public function Trap(trapType:int, x:int, y:int) {
			_trapType = trapType;
			this.x = x;
			this.y = y;
			_isFalling = true;
			
			switch (trapType) {
				case Constants.CONST_TYPE_STAIRS:
					_spriteMap = new Spritemap(ASSET_TRAP_ESCALERA, 20, 80, AnimationTimeout);
					_trapWidth = 20;
					_spriteMap.add("contactoSuelo", [0, 1, 2, 3, 4, 5, 6, 7], 15, false);
					_spriteMap.add("fade", [8, 9, 10], 15, false); // 75% alpha, 50% alpha, 25% alpha
					_isSurfaceTrap = true;
					setHitbox(1, _spriteMap.height);
					type = "TRAP_STAIRS";
				break;
				case Constants.CONST_TYPE_HOLE:
					_spriteMap = new Spritemap(ASSET_TRAP_HOYO, 60, 80, AnimationTimeout);
					_trapWidth = 60;
					//_spriteMap.add("contactoSuelo", [0, 1, 2, 3, 4, 5], 10, true); // main anim
					_spriteMap.add("fade", [1, 2, 3], 15, false); // 75% alpha, 50% alpha, 25% alpha
					_isSurfaceTrap = false;
					setHitbox(20, _spriteMap.height, 0, _spriteMap.height);
					//_spriteMap.originY = -_spriteMap.height;
					type = "TRAP_HOLE";
				break;
				case Constants.CONST_TYPE_WALL:
					_spriteMap = new Spritemap(ASSET_TRAP_MURO, 20, 60, AnimationTimeout);
					_spriteMapDestruir = new Spritemap(WALL_DEAD, 60, 60, AnimationTimeout);
					_trapWidth = 20;
					_spriteMapDestruir.x -= _spriteMap.width;
					_spriteMapDestruir.add("destruir", [0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 7, true);
					_spriteMap.add("contactoSuelo", [0, 1, 2, 3, 4, 5, 6, 7], 20, true); // main anim
					_spriteMap.add("fade", [8, 9, 10], 15, false); // 75% alpha, 50% alpha, 25% alpha
					_isSurfaceTrap = true;
					setHitbox(_spriteMap.width, _spriteMap.height);
					type = "TRAP_WALL";
				break;
				case Constants.CONST_TYPE_GATE:
					_spriteMap = new Spritemap(ASSET_GATE, 80, 80);
					_trapWidth = 80;
					_spriteMap.add("funcionando", [0, 1, 2, 3, 4, 3, 2, 1], 15, true); // main anim
					//_spriteMap.add("fade", [6, 7, 8], 10, false); // 75% alpha, 50% alpha, 25% alpha
					setHitbox(_spriteMap.width, _spriteMap.height);
					type = "GATE";
					_spriteMap.play("funcionando");
				break;
			}
			graphic = _spriteMap;
			layer = 80;
		}
		override public function update():void {
			if (type != "GATE") {
				if (_isFalling) {
					var groundLevel:int = ((Level) (FP.world)).GROUNDLEVEL;
					if ((y + (_isSurfaceTrap ? _spriteMap.height : 0) + FALLSPEED) > groundLevel) {
						_isFalling = false;
						y = groundLevel + (_isSurfaceTrap ? - _spriteMap.height : 0);
						_spriteMap.play("contactoSuelo");
						_counterText = new TextHelperEntity(TIMEOUT.toString(), x + _spriteMap.width, y, 40, 16);
						FP.world.add(_counterText);
					} else {
						y += FALLSPEED;
					}
				} else {
					_time += FP.elapsed;
					_counterText._text.text = (TIMEOUT - _time).toFixed(2);
					if (_time > TIMEOUT) {
						_spriteMap.play("fade");
						FP.world.remove(_counterText);
					}
				}
			}
		}
		public function AnimationTimeout():void {
			if (_spriteMap.currentAnim == "contactoSuelo") {
				_spriteMap.play("funcionando");
			}
			if (_spriteMapDestruir != null && _spriteMapDestruir.currentAnim == "destruir")
			{
				FP.world.remove(this);
				FP.world.remove(_counterText);
			}
			if (_time > TIMEOUT) {
				FP.world.remove(this);
			}
		}
		public function destruirPared():void
		{
			graphic = _spriteMapDestruir;
			_spriteMapDestruir.play("destruir");
			setHitbox(0, 0);
			
		}
	}
}
