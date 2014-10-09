package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResPetStopHandler extends Handler
    {

        public function ResPetStopHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetStopMessage(this.message);
            return;
        }// end function

    }
}
