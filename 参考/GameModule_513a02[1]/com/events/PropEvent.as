package com.events
{
    import flash.events.*;

    public class PropEvent extends Event
    {
        public var obj:Object;
        public static const UPDATE_FIGHTNUMBER:String = "update_fightnumber";

        public function PropEvent(param1:String, param2 = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.obj = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new PropEvent(type, this.obj, bubbles, cancelable);
        }// end function

    }
}
