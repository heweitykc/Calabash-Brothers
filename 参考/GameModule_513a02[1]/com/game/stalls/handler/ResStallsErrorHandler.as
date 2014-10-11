package com.game.stalls.handler
{
    import com.game.stalls.message.*;
    import net.*;

    public class ResStallsErrorHandler extends Handler
    {

        public function ResStallsErrorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStallsErrorMessage(this.message);
            return;
        }// end function

    }
}
