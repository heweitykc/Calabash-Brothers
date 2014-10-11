package com.game.gift.handler
{
    import com.game.gift.message.*;
    import net.*;

    public class ResSendGiftItemsToClientHandler extends Handler
    {

        public function ResSendGiftItemsToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSendGiftItemsToClientMessage(this.message);
            return;
        }// end function

    }
}
