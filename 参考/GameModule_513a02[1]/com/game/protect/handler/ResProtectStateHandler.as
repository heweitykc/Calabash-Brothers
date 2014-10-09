package com.game.protect.handler
{
    import com.game.protect.control.*;
    import com.game.protect.message.*;
    import net.*;

    public class ResProtectStateHandler extends Handler
    {

        public function ResProtectStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resProtectState(message as ResProtectStateMessage);
            return;
        }// end function

    }
}
