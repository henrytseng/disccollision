package com.dreamlite.datastructures.tree {
	import com.dreamlite.datastructures.ICollection;
	import com.dreamlite.datastructures.IIterator;

	/**
	 * BST implementation should avoid 256-level recursion limitation in Flash.  
	 * @author henry
	 */
	public class BinarySearchTree implements ICollection {
		internal var _root : BSTNode;
		internal var _size : int;
		protected var _allowDuplicate : Boolean;
		
		public function BinarySearchTree($allowDuplicate:Boolean=false) {
			_root = null;
			_size = 0;
			_allowDuplicate = $allowDuplicate;
		}

		/**
		 * Insert a node according to key.  Insertions with keys with the same value as existing 
		 * keys replace existing data.  
		 * @param $key
		 * @param $data
		 */
		public function insert($key:BSTKey, $data:*):void {
			if(_root==null) {
				_root = new BSTNode($key, $data);
				
			} else {
				var node:BSTNode = _root;
				var i:int;
				while(node) {
					i = node._key.compare($key);
					if(i<0) {
						 if(node.left==null) {
						 	node.insertLeft($key, $data);
						 	break;
						 } else {
						 	node = node.left;
						 	continue;
						 }
						 
					} else if(i>0) {
						 if(node.right==null) {
						 	node.insertRight($key, $data);
						 	break;
						 } else {
						 	node = node.right;
						 	continue;
						 }
					
					// replace existing
					} else {
						if(!_allowDuplicate) {
							node._key = $key;
							node._data = $data;
							break;
							
						// insert duplicates on right
						} else {
							if(node.right==null) { 
								node.insertRight($key, $data);
								break;
							} else {
								node = node.right;
								continue;
							}
						}
					}
				}
			}
			_size++;
		}
		
		/**
		 * Remove a node based on a key
		 * @param $key
		 * @param $isRemoveAll
		 */
		public function remove($key:BSTKey):void {
			
			var node:BSTNode = _getNode($key);
			if(node) {
				var hasLeft:Boolean = node.left!=null;
				var hasRight:Boolean = node.right!=null;
				
				// both children
				if(hasLeft && hasRight) {
					// swap minimum
					var next:BSTNode = _getMin(node.right);
					if(next.isLeft()) {
						next.parent.left = next.right;
					} else if(next.isRight()) {
						next.parent.right = next.right;
					}
					if(next.right) next.right.parent = next.parent;
					next.parent = node.parent;
					next.left = node.left;
					next.right = node.right;
					
					// children references
					if(node.left) node.left.parent = next;
					if(node.right) node.right.parent = next;
					
					// parent reference
					if(node.isLeft()) node.parent.left = next;
					else if(node.isRight()) node.parent.right = next;
					else if(_root==node) _root = next; 
					
					// remove node
					node.parent = node.left = node.right = null;
					node.destroy();
					
				// one or less
				} else {
					var parent:BSTNode = node.parent;
					var child:BSTNode = node.left || node.right;
					
					if(node.isLeft()) {
						parent.left = child;
						if(child) child.parent = parent;
					
					} else if(node.isRight()) {
						parent.right = child;
						if(child) child.parent = parent;
						
					} else if(node == _root) {
						_root = child;
						if(child) child.parent = null;
					}
					node.left = node.right = node.parent = null;
					node.destroy();
				}
				_size--;
			}
		}
		
		/**
		 * Clear tree
		 */
		public function clear():void {
			_root.destroy();
			_root = null;
			_size = 0;
		}
		
		/**
		 * Check if tree contains node
		 * @param $data
		 * @return
		 */
		public function contains($data:*):Boolean {
			return _getData(_root, $data)!=null;
		}
		
		/**
		 * Search all sub nodes for data containing
		 * @param $node
		 * @return
		 */
		internal function _getData($node:BSTNode, $data:*):BSTNode {
			if(!$node) return null;
			else if($node._data === $data) return $node;
			else return _getData($node.left, $data) || _getData($node.right, $data);
		}
		
		/**
		 * Search for node with corresponding key
		 * @param $key
		 * @return
		 */
		public function find($key:BSTKey):* {
			var node:BSTNode = _getNode($key);
			return (node) ? node._data : null;
		}
		
		/**
		 * Retrieve the minimum value in the tree starting from a specific node
		 * @param $start
		 * @return
		 */
		internal function _getMin($start:BSTNode):BSTNode {
			var node:BSTNode = $start;
			while(node.left) node = node.left;
			return node;
		}
		
		/**
		 * Retrieve the maximum value in the tree starting from a specific node
		 * @param $start
		 * @return
		 */
		internal function _getMax($start:BSTNode):BSTNode {
			var node:BSTNode = $start;
			while(node.right) node = node.right;
			return node;
		}
		
		/**
		 * Traverse through tree and locate a specific key starting from a specific node
		 * @param $key
		 * @param $start
		 * @return
		 */
		internal function _getNode($key:BSTKey, $start:BSTNode=null):BSTNode {
			var node:BSTNode = ($start) ? $start : _root;
	        while(node) {
	            var i:int = node._key.compare($key);
	            if(i<0) node = node.left;
	            else if(i>0) node = node.right;
	            else if(i==0) return node;
			}
	        return null;
		}
		
		/**
		 * Flag for allowance of duplicate node keys.  Insertion of existing key values would normally
		 * override existing data.  
		 * @return 
		 */
		public function get allowDuplicate():Boolean { return _allowDuplicate; }
		
		/**
		 * @inheritDoc
		 */
		public function get iterator():IIterator { return new BSTIterator(this); }
		
		/**
		 * @inheritDoc
		 */
		public function get size():int { return _size; }
		
		/**
		 * Calculates the number of levels in the tree.  
		 */
		public function get depth():int { return _root.getDepth(); }
		
		/**
		 * Inorder traversal of entire tree.  
		 */
		public function toArray():Array { 
			return [];
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString():String { return '[BinarySearchTree]'; }
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void {
			clear();
		}
	}
	
}