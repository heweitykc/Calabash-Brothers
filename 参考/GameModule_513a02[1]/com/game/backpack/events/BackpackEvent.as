package com.game.backpack.events
{
    import flash.events.*;

    public class BackpackEvent extends Event
    {
        public var data:Object;
        public static const BOX_ADDTOSTALLS:String = "box_addtostalls";
        public static const BOX_SELECTED:String = "box_selected";
        public static const BOX_REMOVE:String = "box_remove";
        public static const BOX_MOVE:String = "box_move";
        public static const BOX_CHANGE:String = "box_change";
        public static const BOX_ADD:String = "box_add";
        public static const BOX_UPDATE:String = "box_update";
        public static const GOODS_CHANGE:String = "goods_change";
        public static const BOX_SELL:String = "box_sell";
        public static const BOX_OPEN:String = "box_open";
        public static const BOX_TRANSCATION:String = "box_transcation";
        public static const BOX_OPEN_DIAMOND:String = "box_open_diamond";
        public static const BOX_FULL:String = "box_full";
        public static const MODE_CHANGE:String = "mode_change";

        public function BackpackEvent(param1:String, param2, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new BackpackEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
