package com.f1.structs
{
    import com.f1.*;
    import com.f1.utils.*;

    public class BaseInfo extends BaseEventDispatcher
    {
        public var id:uint;
        public var name:String = "";
        public var type:uint;

        public function BaseInfo()
        {
            return;
        }// end function

        public function clone()
        {
            return ToolKit.cloneObject(this);
        }// end function

    }
}
