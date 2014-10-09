package com.game.gift.handler
{
    import com.game.gift.message.*;
    import net.*;

    public class ResPlatformGiftListHandler extends Handler
    {

        public function ResPlatformGiftListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlatformGiftListMessage(this.message);
            return;
        }// end function

    }
}
