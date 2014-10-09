package com.game.gift.handler
{
    import com.game.gift.message.*;
    import net.*;

    public class ResGetPlatformGiftHandler extends Handler
    {

        public function ResGetPlatformGiftHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetPlatformGiftMessage(this.message);
            return;
        }// end function

    }
}
