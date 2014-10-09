package com.game.mail.handler
{
    import com.game.mail.control.*;
    import com.game.mail.message.*;
    import net.*;

    public class ResMailQueryDetailToClientHandler extends Handler
    {

        public function ResMailQueryDetailToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailQueryDetailToClientMessage(this.message);
            MailController.getInstance().getInfoRes(_loc_1.mailDetail);
            return;
        }// end function

    }
}
