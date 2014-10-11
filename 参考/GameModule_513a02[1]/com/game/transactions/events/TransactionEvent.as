package com.game.transactions.events
{
    import flash.events.*;

    public class TransactionEvent extends Event
    {
        public var data:Object;
        public static const DRAG_IN:String = "drag_in";
        public static const DRAG_OUT:String = "drag_out";
        public static const INSERT:String = "insert";
        public static const REMOVE:String = "remove";

        public function TransactionEvent(param1:String, param2 = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TransactionEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
