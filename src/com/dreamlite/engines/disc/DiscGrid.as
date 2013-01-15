package com.dreamlite.engines.disc {
	import com.dreamlite.datastructures.IIterator;
	import com.dreamlite.datastructures.linked.DoublyLinkedList;
	import com.dreamlite.datastructures.tree.BinarySearchTree;
	import com.dreamlite.engines.disc.DiscEvent;
	import com.dreamlite.engines.disc.DiscWorld;

	/**
	 * Manages grid-space coordinates based on x-y coordinates.  
	 * @author henry
	 */
	public class DiscGrid {
		protected var _world : DiscWorld;
		internal var _columns : int;
		internal var _rows : int;
		internal var _radiusList : BinarySearchTree;
		internal var _gridList : Vector.<DoublyLinkedList>;
		internal var _entireList : DoublyLinkedList;
		
		public function DiscGrid($world:DiscWorld) {
			_world=$world;
			_init();
		}
		
		protected function _init():void {
			_columns = Math.ceil((_world.maxX-_world.minX) / _world._span);
			_rows = Math.ceil((_world.maxY-_world.minY) / _world._span);
			_radiusList = new BinarySearchTree(true);
			_gridList = new Vector.<DoublyLinkedList>(_columns * _rows);
			_entireList = new DoublyLinkedList();
			for(var n:int=0; n<(_columns * _rows); n++) _gridList[n] = new DoublyLinkedList();
		}
		
		/**
		 * Called when body is first created to initialize i and j parameters
		 * @param $body
		 */
		internal function initiate($body:DiscBody):void {
			$body.i = getI($body.x);
			$body.j = getJ($body.y);
			_getBox($body.i, $body.j).add($body);
			_radiusList.insert(new RadiusKey($body.radius), $body);
			_entireList.add($body);
		}
		
		/**
		 * Remove from grid
		 * @param $body
		 */
		internal function remove($body:DiscBody):void {
			$body.i = 0;
			$body.j = 0;
			_radiusList.remove(new RadiusKey($body.radius));
			_entireList.remove($body);
		}
		
		/**
		 * Update locations on grid based on new x-y coordinates
		 */
		public function update():void {
			for(var n:IIterator=_entireList.iterator; n.hasNext();) {
				var body:DiscBody = n.next();
				var lastI:int = body.i;
				var lastJ:int = body.j;
				
				// left world
				if((body.x<_world.minX || body.x>_world.maxX) || (body.y<_world.minY || body.y>_world.maxY)) {
					_getBox(lastI, lastJ).remove(body);
					body.dispatchEvent(new DiscEvent(DiscEvent.LEFT_WORLD));
					continue;
				}
				
				// change location
				body.i = getI(body.x);
				body.j = getJ(body.y);
				if(lastI!=body.i || lastJ!=body.j) {
					if(lastI!=-1 && lastJ!=-1) _getBox(lastI, lastJ).remove(body);
					_getBox(body.i, body.j).add(body);
				}
			}
		}
		
		public function getI($x:Number):int {
			if($x<_world.minX) return 0;
			else if($x>=_world.maxX) return _columns-1; 
			return Math.floor(($x-_world.minX)/_world._span);
		}
		
		public function getJ($y:Number):int {
			if($y<_world.minY) return 0;
			else if($y>=_world.maxY) return _rows-1; 
			return Math.floor(($y-_world.minY)/_world._span);
		}
		
		internal function _getBox($i:int, $j:int):DoublyLinkedList {
			return _gridList[$j*_columns + $i];
		}
		
		public function destroy():void {
			for(var n:int=0; n<_columns*_rows; n++) {
				_gridList[n].destroy();
			}
			_gridList=null;
			_entireList.destroy();
			_entireList = null;
			_radiusList.destroy();
			_radiusList = null;
			_world = null;
		}
	}
}
