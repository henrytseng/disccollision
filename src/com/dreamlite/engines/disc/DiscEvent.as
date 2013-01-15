package com.dreamlite.engines.disc {
	import flash.events.Event;

	/**
	 * @author henry
	 */
	public class DiscEvent extends Event {
		public static const LEFT_WORLD : String = 'left_world';
		
		public function DiscEvent($type:String, $bubbles:Boolean=false, $cancelable:Boolean=false) {
			super($type, $bubbles, $cancelable);
		}
		
		override public function toString():String { return '[DiscEvent '+type+']'; }
	}
}
