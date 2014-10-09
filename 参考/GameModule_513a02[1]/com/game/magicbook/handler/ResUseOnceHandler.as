package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResUseOnceHandler extends Handler
    {

        public function ResUseOnceHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResUseOnceMessage(this.message);
            MagicBookControl.getIntance().resuseOnce(_loc_1.useOnces);
            return;
        }// end function

    }
}
