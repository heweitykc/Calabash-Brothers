package com.f1
{
    import com.f1.interfaces.*;
    import flash.display.*;

    public class BaseModule extends Sprite implements IModule
    {
        protected var _version:uint;

        public function BaseModule()
        {
            return;
        }// end function

        public function get version() : uint
        {
            return this._version;
        }// end function

        public function initialize() : Boolean
        {
            return true;
        }// end function

        public function traceOfDisplay(param1:DisplayObject) : String
        {
            return null;
        }// end function

    }
}
