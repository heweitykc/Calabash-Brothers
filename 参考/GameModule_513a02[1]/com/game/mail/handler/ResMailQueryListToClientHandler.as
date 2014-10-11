package com.game.mail.handler
{
    import com.game.mail.control.*;
    import com.game.mail.message.*;
    import net.*;

    public class ResMailQueryListToClientHandler extends Handler
    {

        public function ResMailQueryListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailQueryListToClientMessage(this.message);
            MailController.getInstance().reqListRes(_loc_1.mailSummaryList);
            return;
        }// end function

    }
}
