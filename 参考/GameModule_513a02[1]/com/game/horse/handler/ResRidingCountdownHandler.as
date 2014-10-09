package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ResRidingCountdownHandler extends Handler
    {

        public function ResRidingCountdownHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRidingCountdownMessage(this.message);
            return;
        }// end function

    }
}
