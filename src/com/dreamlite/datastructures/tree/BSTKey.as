package com.dreamlite.datastructures.tree {

	/**
	 * @author henry
	 */
	public class BSTKey {
		public var value : Number;
		
		public function BSTKey($value:*) {
			value = Number($value);
		}
		
		/**
		 * Compare keys and returns integer value.  -1 for other key value smaller, 1 for 
		 * @param $insert
		 * @return 
		 */
		public function compare($other:BSTKey):int {
			if($other.value < value) return -1;
			else if($other.value > value) return 1;
			else return 0;
		}
		
		public function toString():String { return '[BSTKey '+value+']'; }
		
		public function destroy():void { }
	}
}
