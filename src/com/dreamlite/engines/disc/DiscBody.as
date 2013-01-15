package com.dreamlite.engines.disc {
	import com.dreamlite.math.AABB;

	import flash.events.EventDispatcher;

	/**
	 * @author henry
	 */
	public class DiscBody extends EventDispatcher {
		// coordinates
		public var x : Number;
		public var y : Number;
		
		// buckets
		public var i : int;
		public var j : int;
		
		// use as pin
		public var radius : Number;
		
		public function DiscBody($x:Number, $y:Number, $radius:Number) {
			x = $x;
			y = $y;
			radius=$radius;
			i=-1;
			j=-1;
		}
		
		public function get aabb():AABB { return new AABB(x-radius, y-radius, x+radius, y+radius); }
		
		override public function toString():String { return '[DiscBody]'; }
	}
}
