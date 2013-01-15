package com.dreamlite.math {

	/**
	 * Axis Aligned Bounding Box (AABB) represented through min and max values.  
	 * @author henry
	 */
	public class AABB {
		public var minX : Number;
		public var minY : Number;
		public var maxX : Number;
		public var maxY : Number;
		
		public function AABB($minX:Number=Number.MIN_VALUE, $minY:Number=Number.MIN_VALUE, $maxX:Number=Number.MAX_VALUE, $maxY:Number=Number.MAX_VALUE) {
			minX = $minX;
			minY = $minY;
			maxX = $maxX;
			maxY = $maxY;
		}
		
		public function clone():AABB { return new AABB(minX, minY, maxX, maxY); }
		
		public function toString():String { return '[AABB minX='+minX+' minY='+minY+' maxX='+maxX+' maxY='+maxY+']'; }
	}
}
