package com.game.buff.handler
{
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import net.*;

    public class ResRemoveBuffHandler extends Handler
    {

        public function ResRemoveBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRemoveBuffMessage(this.message);
            BuffControl.getInstance().removeBuffHandler(_loc_1);
            return;
        }// end function

    }
}
