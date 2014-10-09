package com.game.publogin.handler
{
    import com.game.publogin.message.*;
    import net.*;

    public class ResQuitForPublicHandler extends Handler
    {

        public function ResQuitForPublicHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResQuitForPublicMessage(this.message);
            return;
        }// end function

    }
}
