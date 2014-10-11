package com.game.protect.handler
{
    import com.game.protect.control.*;
    import com.game.protectAdvanced.message.*;
    import net.*;

    public class ResProtectItemHandler extends Handler
    {

        public function ResProtectItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resProtectItemMessage(message as ResProtectItemMessage);
            return;
        }// end function

    }
}
