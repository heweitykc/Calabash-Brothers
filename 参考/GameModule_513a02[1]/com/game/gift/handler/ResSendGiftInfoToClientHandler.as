package com.game.gift.handler
{
    import com.game.gift.message.*;
    import net.*;

    public class ResSendGiftInfoToClientHandler extends Handler
    {

        public function ResSendGiftInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSendGiftInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
