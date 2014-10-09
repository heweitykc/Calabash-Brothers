package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseReceiveTimerHandler extends Handler
    {

        public function ReshorseReceiveTimerHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseReceiveTimerMessage(this.message);
            return;
        }// end function

    }
}
