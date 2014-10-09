package com.game.protect.handler
{
    import com.game.protect.control.*;
    import com.game.protect.message.*;
    import net.*;

    public class ResVerificationHandler extends Handler
    {

        public function ResVerificationHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resVerification(message as ResVerificationMessage);
            return;
        }// end function

    }
}
