package com.game.operationpanel.event
{
    import flash.events.*;

    public class OperationEvent extends Event
    {
        public var data:Object;
        public static const SKILL_BOX_MOVE:String = "skillMove";
        public static const SKILL_BOX_REMOVE:String = "skillRemove";

        public function OperationEvent(param1:String, param2 = null, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this.data = param2;
            return;
        }// end function

    }
}
