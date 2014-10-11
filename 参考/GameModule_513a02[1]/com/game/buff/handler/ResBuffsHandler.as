package com.game.buff.handler
{
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import net.*;

    public class ResBuffsHandler extends Handler
    {

        public function ResBuffsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBuffsMessage(this.message);
            BuffControl.getInstance().buffsHandler(_loc_1);
            return;
        }// end function

    }
}
