package com.game.buff.handler
{
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import net.*;

    public class ResBuffInfoHandler extends Handler
    {

        public function ResBuffInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBuffInfoMessage(this.message);
            BuffControl.getInstance().buffInfoHandler(_loc_1);
            return;
        }// end function

    }
}
