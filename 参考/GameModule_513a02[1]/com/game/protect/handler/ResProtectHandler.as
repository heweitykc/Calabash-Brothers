package com.game.protect.handler
{
    import com.game.protect.control.*;
    import com.game.protectAdvanced.message.*;
    import net.*;

    public class ResProtectHandler extends Handler
    {

        public function ResProtectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resProtectMessage(message as ResProtectMessage);
            return;
        }// end function

    }
}
