package com.events.ui
{
    import flash.events.*;

    public class DragEvent extends Event
    {
        public var data:Object;
        public static const DRAG_FALSE:String = "drag_false";

        public function DragEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new DragEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
