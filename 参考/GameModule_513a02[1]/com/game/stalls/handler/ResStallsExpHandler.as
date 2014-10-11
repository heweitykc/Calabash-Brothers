package com.game.stalls.handler
{
    import com.game.stalls.message.*;
    import net.*;

    public class ResStallsExpHandler extends Handler
    {

        public function ResStallsExpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStallsExpMessage(this.message);
            return;
        }// end function

    }
}
