package com.events
{
    import flash.events.*;

    public class TalkBoxEvent extends Event
    {
        public var obj:Object;
        public static const SPEAK_OVER:String = "speak_over";
        public static const NEXT:String = "talk_next";

        public function TalkBoxEvent(param1:String, param2 = null)
        {
            this.obj = param2;
            super(param1);
            return;
        }// end function

        override public function clone() : Event
        {
            return new GameEvent(type, this.obj);
        }// end function

    }
}
