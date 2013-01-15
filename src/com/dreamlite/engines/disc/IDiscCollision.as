package com.dreamlite.engines.disc {
	import com.dreamlite.datastructures.linked.DoublyLinkedList;

	/**
	 * @author henry
	 */
	public interface IDiscCollision {
		function check($body:DiscBody):DoublyLinkedList;
		
		function destroy():void;
	}
}
