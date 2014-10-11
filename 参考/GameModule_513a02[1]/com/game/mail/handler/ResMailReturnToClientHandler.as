package com.game.mail.handler
{
    import com.game.mail.message.*;
    import net.*;

    public class ResMailReturnToClientHandler extends Handler
    {

        public function ResMailReturnToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMailReturnToClientMessage(this.message);
            return;
        }// end function

    }
}
