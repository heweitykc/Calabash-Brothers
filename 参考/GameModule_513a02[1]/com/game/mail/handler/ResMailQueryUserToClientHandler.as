package com.game.mail.handler
{
    import com.game.mail.message.*;
    import net.*;

    public class ResMailQueryUserToClientHandler extends Handler
    {

        public function ResMailQueryUserToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailQueryUserToClientMessage(this.message);
            return;
        }// end function

    }
}
