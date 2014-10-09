package com.game.buff.handler
{
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import net.*;

    public class ResChangeBuffHandler extends Handler
    {

        public function ResChangeBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeBuffMessage(this.message);
            BuffControl.getInstance().changeBuffHandler(_loc_1);
            return;
        }// end function

    }
}
