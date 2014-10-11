package com.game.mail.handler
{
    import com.game.mail.control.*;
    import com.game.mail.message.*;
    import net.*;

    public class ResMailGetNewMailToClientHandler extends Handler
    {

        public function ResMailGetNewMailToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailGetNewMailToClientMessage(this.message);
            if (MailController.getInstance().newMail < _loc_1.nCount)
            {
                MailController.getInstance().reqList(1);
            }
            else
            {
                MailController.getInstance().checkMailCount();
            }
            MailController.getInstance().newMail = _loc_1.nCount;
            return;
        }// end function

    }
}
