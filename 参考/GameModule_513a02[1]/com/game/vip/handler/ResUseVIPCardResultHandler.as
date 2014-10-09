package com.game.vip.handler
{
    import com.game.vip.message.*;
    import net.*;

    public class ResUseVIPCardResultHandler extends Handler
    {

        public function ResUseVIPCardResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResUseVIPCardResultMessage(this.message);
            return;
        }// end function

    }
}
