package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResGainBookHandler extends Handler
    {

        public function ResGainBookHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGainBookMessage(this.message);
            MagicBookControl.getIntance().resGainBookHandler(_loc_1.result == 0);
            return;
        }// end function

    }
}
