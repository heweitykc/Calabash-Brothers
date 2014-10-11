package com.game.signwage.event
{
    import flash.events.*;

    public class SignEvent extends Event
    {
        private var _obj:Object;
        public static const NUM_CHANGE:String = "numChange";

        public function SignEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            this._obj = this.obj;
            super(param1, param2, param3);
            return;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

    }
}
