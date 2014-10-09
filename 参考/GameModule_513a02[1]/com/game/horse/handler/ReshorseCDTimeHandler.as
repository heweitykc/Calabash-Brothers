package com.game.horse.handler
{
    import com.game.horse.message.*;
    import net.*;

    public class ReshorseCDTimeHandler extends Handler
    {

        public function ReshorseCDTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ReshorseCDTimeMessage(this.message);
            return;
        }// end function

    }
}
