package com.game.mail.handler
{
    import com.game.mail.message.*;
    import net.*;

    public class ResMailSendNewMailToClientHandler extends Handler
    {

        public function ResMailSendNewMailToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailSendNewMailToClientMessage(this.message);
            return;
        }// end function

    }
}
