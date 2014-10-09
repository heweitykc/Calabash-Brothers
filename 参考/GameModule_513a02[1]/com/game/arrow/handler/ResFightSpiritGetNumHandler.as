package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResFightSpiritGetNumHandler extends Handler
    {

        public function ResFightSpiritGetNumHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightSpiritGetNumMessage(this.message);
            return;
        }// end function

    }
}
