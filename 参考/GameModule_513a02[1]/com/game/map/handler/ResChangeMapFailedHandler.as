package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResChangeMapFailedHandler extends Handler
    {

        public function ResChangeMapFailedHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeMapFailedMessage(this.message);
            return;
        }// end function

    }
}
