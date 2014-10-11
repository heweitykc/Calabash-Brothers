package com.game.store.events
{
    import flash.events.*;

    public class StoreEvent extends Event
    {
        public var data:Object;
        public static const ITEM_ADDED_TO_STORE:String = "item_added_to_store";
        public static const ITEM_REMOVE_FROM_STORE:String = "item_remove_from_store";
        public static const ITEM_MOVE_INNER_STORE:String = "item_move_inner_store";
        public static const ITEM_MOVE_TO_BACKPACK:String = "item_move_to_backpack";
        public static const ITEM_MOVE_TO_STORE:String = "item_move_to_store";

        public function StoreEvent(param1:String, param2)
        {
            this.data = param2;
            super(param1, bubbles, cancelable);
            return;
        }// end function

    }
}
