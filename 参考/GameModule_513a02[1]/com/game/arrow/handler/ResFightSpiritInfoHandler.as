package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResFightSpiritInfoHandler extends Handler
    {

        public function ResFightSpiritInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightSpiritInfoMessage(this.message);
            return;
        }// end function

    }
}
