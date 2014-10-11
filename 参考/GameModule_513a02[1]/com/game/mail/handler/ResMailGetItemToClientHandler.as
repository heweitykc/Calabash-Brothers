package com.game.mail.handler
{
    import com.game.mail.control.*;
    import com.game.mail.message.*;
    import net.*;

    public class ResMailGetItemToClientHandler extends Handler
    {

        public function ResMailGetItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailGetItemToClientMessage(this.message);
            MailController.getInstance().getItemRes(_loc_1.mailDetail, _loc_1.itemModelIds);
            return;
        }// end function

    }
}
