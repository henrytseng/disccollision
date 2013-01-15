package com.dreamlite.engines.disc {
	import com.dreamlite.datastructures.linked.DoublyLinkedList;
	import com.dreamlite.math.AABB;

	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * Divides world into grid and computes distance based collision.  
	 * @author henry
	 */
	public class DiscWorld extends EventDispatcher {
		internal var _bounds : AABB;
		internal var _span : Number;
		internal var _grid : DiscGrid;
		internal var _collision : DiscCollision;
		
		public function DiscWorld($bounds:AABB, $span:Number=20) {
			_bounds = $bounds.clone();
			_span = $span;
			_grid=new DiscGrid(this);
			_collision = new DiscCollision(this);
		}
		
		public function get span():Number { return _span; }
		
		public function get minX():Number { return _bounds.minX; }
		
		public function get minY():Number { return _bounds.minY; }
		
		public function get maxX():Number { return _bounds.maxX; }
		
		public function get maxY():Number { return _bounds.maxY; }
		
		public function createBody($x:Number, $y:Number, $radius:Number):DiscBody {
			var bd:DiscBody = new DiscBody($x, $y, $radius);
			_grid.initiate(bd);
			return bd;
		}
		
		public function update():void {
			_grid.update();
			_collision.clear();
		}
		
		public function check($body:DiscBody):DoublyLinkedList {
			return _collision.check($body);
		}
		
		public function convertPoint($p:Point):Point {
			return new Point(_grid.getI($p.x), _grid.getJ($p.y));
		}
		
		public function destroy():void {
			_grid.destroy();
			_collision.destroy();
		}
		
	}
}
