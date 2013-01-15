package com.dreamlite.datastructures.tree {
	import com.dreamlite.datastructures.IIterator;

	/**
	 * Traverse tree using an in-order searching algorithm
	 * @author henry
	 */
	public class BSTIterator implements IIterator {
		protected var _tree : BinarySearchTree;
		protected var _stack : Vector.<BSTNode>;
		
		public function BSTIterator($tree:BinarySearchTree) {
			_tree = $tree;
			_stack = new Vector.<BSTNode>();
			_pushLeft(_tree._root);
		}
		
		/**
		 * Returns <code>true</code> if the iteration has more elements.
		 * @return <code>true</code> if next node is available
		 */
		public function hasNext():Boolean {
			return _stack.length!=0;
		}
		
		/**
		 * Move iterator to next item and retrieve data item.  Next item begins at list head at start.  
		 * @return Returns the next data in the collection.  
		 */
		public function next():* {
			if(!hasNext()) return null; 
			var n:BSTNode = _stack.pop();
			_pushLeft(n.right);
			return n._data;
		}
		
		protected function _pushLeft($node:BSTNode):void {
			while($node) {
				_stack.push($node);
				$node=$node.left;
			}
		}
		
		/**
		 * Removes the current node and moves the cursor to the next node
		 */
		public function remove():void {
			if(hasNext()) {
				var n:BSTNode = _stack.pop();
				_pushLeft(n.right);
				_tree.remove(n._key);
			}
		}
		
		public function get key():BSTKey { return _stack[_stack.length-1]._key; }
		
		/**
		 * Set data at current node.  
		 * @param $data data to set
		 */
		public function set data($data:*):void {
			_stack[_stack.length-1]._data=$data;
		}
		
		/**
		 * Get data at current node.  
		 * @return data on current node
		 */
		public function get data():* {
			return _stack[_stack.length-1]._data;
		}
		
		public function toString():String { return '[BSTIterator]'; }
		
		public function destroy():void {
			_tree = null;
			_stack = null;
		}
	}
}
