package com.game.publogin.handler
{
    import com.game.publogin.message.*;
    import net.*;

    public class ResLoginFailedForPublicHandler extends Handler
    {

        public function ResLoginFailedForPublicHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLoginFailedForPublicMessage(this.message);
            return;
        }// end function

    }
}
