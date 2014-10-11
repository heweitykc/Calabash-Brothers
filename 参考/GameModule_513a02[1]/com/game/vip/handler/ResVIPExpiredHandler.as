package com.game.vip.handler
{
    import com.game.vip.message.*;
    import net.*;

    public class ResVIPExpiredHandler extends Handler
    {

        public function ResVIPExpiredHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResVIPExpiredMessage(this.message);
            return;
        }// end function

    }
}
