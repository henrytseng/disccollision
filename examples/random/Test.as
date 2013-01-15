package random {
	import com.dreamlite.datastructures.IIterator;
	import com.dreamlite.datastructures.linked.DoublyLinkedList;
	import com.dreamlite.engines.disc.DiscWorld;
	import com.dreamlite.math.AABB;

	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author henry
	 */
	public class Test extends Sprite {
		protected var _list : DoublyLinkedList;
		protected var _w : Number;
		protected var _h : Number;
		protected var _club : Sprite;
		protected var _world : DiscWorld;
		protected var _count : int;
		
		private var _mouse : DebugMouse;
		
		public function Test() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_count = 0;
			_w = 550;
			_h = 450;
			_list = new DoublyLinkedList;
			_world = new DiscWorld(new AABB(-50, -50, 550, 550), 100);
			addChild( _club = new Sprite());
			
			addEventListener(Event.ENTER_FRAME, _onFrame);
			
			graphics.lineStyle(0x0, .2);
			graphics.drawRect(0, 0, _w, _h);
			
			_mouse = new DebugMouse(_world);
			_list.add(_mouse.debug);
			addChild(_mouse);
			
			buttonX = 10;
			var a:Sprite = _createButton(0xff0000);
			a.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDownAdd);
			stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUpAdd);
			
			_createLines();
		}
		
		protected var buttonX : Number;
		protected function _createButton($c:int):Sprite {
			var s:Sprite;
			addChild(s = new Sprite());
			s.graphics.beginFill($c, 1);
			s.graphics.drawRect(buttonX,10,30,30);
			s.graphics.endFill();
			s.buttonMode = true;
			buttonX+=40;
			return s;
		}
		
		protected function _mouseDownAdd($e:MouseEvent):void {
			addEventListener(Event.ENTER_FRAME, _clickAdd);
		}

		protected function _mouseUpAdd($e:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, _clickAdd);
		}
		
		protected var _largestRadii : Number =0;
		protected function _clickAdd($e:Event):void {
			if(_count>0xfff) return;
			
			var bd:DebugBody = new DebugBody();
			bd.x = _w * Math.random();
			bd.vx = -1+2 * Math.random();
			bd.y = _h * Math.random();
			bd.vy = -1+2 * Math.random();
			bd.d = 20+30 * Math.random();
			
			_largestRadii = Math.max(bd.d, _largestRadii);
			
			bd.discBody = _world.createBody(bd.x, bd.y, bd.d);
			_list.add(bd);
		}
		
		protected var lines:Sprite;
		protected function _createLines():void {
			if(!lines) {
				addChild(lines = new Sprite());
			}
			lines.graphics.lineStyle(0, 0xcccccc, .5);
			for(var i:int=0; i<(_world.maxX-_world.minX)/_world.span; i++) {
				lines.graphics.moveTo(i*_world.span+_world.minX, _world.minY);
				lines.graphics.lineTo(i*_world.span+_world.minX, _world.maxY);
			}
			for(var j:int=0; j<(_world.maxY-_world.minY)/_world.span; j++) {
				lines.graphics.moveTo(_world.minX, j*_world.span+_world.minY);
				lines.graphics.lineTo(_world.maxX, j*_world.span+_world.minY);
			}
		}
		
		public function _onFrame($e:Event):void {
			_club.graphics.clear();
			_world.update();
			_mouse.update();
			
			var p:Point = _world.convertPoint(new Point(mouseX, mouseY));
			var mouseI : int = p.x;
			var mouseJ : int = p.y;
			
			var collisionList:DoublyLinkedList = _world.check(_mouse.bd);
			
			// draw the bodies in the club
			var i:IIterator = _list.iterator;
			while(i.hasNext()) {
				var bd:DebugBody = i.next();
				
				bd.x += bd.vx;
				if(bd.x < _world.minX) bd.x = _world.maxX;
				else if(bd.x > _world.maxX) bd.x = _world.minX;
				bd.discBody.x = bd.x;
				
				bd.y += bd.vy;
				if(bd.y < _world.minY) bd.y = _world.maxY;
				else if(bd.y > _world.maxY) bd.y = _world.minY;
				bd.discBody.y = bd.y;
				
				// highlight bodies in the same grid as the mouse
				if( collisionList.contains(bd.discBody)) {
					_club.graphics.beginFill(0xff0000, 1);
					_club.graphics.drawRect(bd.x-3, bd.y-3, 6, 6);
					_club.graphics.endFill();
				
					_club.graphics.lineStyle(0, 0x0, .5);
					_club.graphics.drawCircle(bd.x, bd.y, bd.d);
					
				// draw others normally
				} else {
					_club.graphics.beginFill(0x000000, 1);
					_club.graphics.drawRect(bd.x-1, bd.y-1, 2, 2);
					_club.graphics.endFill();
					
					_club.graphics.lineStyle(0, 0x0, .15);
					_club.graphics.drawCircle(bd.x, bd.y, bd.d);
				}
			}
		}
	}
}
