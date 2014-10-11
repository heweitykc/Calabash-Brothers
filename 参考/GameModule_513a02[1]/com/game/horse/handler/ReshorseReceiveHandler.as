package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseReceiveHandler extends Handler
    {

        public function ReshorseReceiveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseReceiveMessage(this.message);
            return;
        }// end function

    }
}
