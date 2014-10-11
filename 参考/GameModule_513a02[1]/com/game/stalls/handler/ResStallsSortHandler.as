package com.game.stalls.handler
{
    import com.game.stalls.message.*;
    import net.*;

    public class ResStallsSortHandler extends Handler
    {

        public function ResStallsSortHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStallsSortMessage(this.message);
            return;
        }// end function

    }
}
