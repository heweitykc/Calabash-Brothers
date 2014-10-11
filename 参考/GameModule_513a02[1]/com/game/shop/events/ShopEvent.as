package com.game.shop.events
{
    import flash.events.*;

    public class ShopEvent extends Event
    {
        public var data:Object;
        public static const CANCEL_SOLD:String = "cancel_sold";

        public function ShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this.data = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ShopEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
