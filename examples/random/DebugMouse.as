package random {
	import com.dreamlite.engines.disc.DiscBody;
	import com.dreamlite.engines.disc.DiscWorld;

	import flash.display.Sprite;

	/**
	 * @author henry
	 */
	public class DebugMouse extends Sprite {
		private var _manage : DiscWorld;
		public var bd : DiscBody;
		public var debug : DebugBody;
		
		public function DebugMouse($m:DiscWorld) {
			_manage = $m;
			bd = _manage.createBody(this.mouseX, this.mouseY, 20);
			debug = new DebugBody();
			debug.d = 20;
			debug.vx = debug.vy = 0;
			debug.discBody = bd;
		}

		public function update():void {
			debug.x = bd.x = this.mouseX;
			debug.y = bd.y = this.mouseY;
			
		}
	}
}
