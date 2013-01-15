package com.dreamlite.engines.disc {
	import com.dreamlite.datastructures.tree.BSTKey;

	/**
	 * @author henry
	 */
	public class RadiusKey extends BSTKey {
		public function RadiusKey($value:*) {
			super($value);
		}
		
		/**
		 * Compare keys and returns integer value.  -1 for other key value smaller, 1 for 
		 * @param $insert
		 * @return 
		 */
		override public function compare($other:BSTKey):int {
			if($other.value < value) return 1;
			else if($other.value > value) return -1;
			else return 0;
		}
		
		override public function toString():String { return '[RadiusKey '+value+']'; }
		
		override public function destroy():void { }

	}
}
