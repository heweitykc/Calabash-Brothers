package com.game.redfortress.handler
{
    import com.game.redfortress.control.*;
    import com.game.redfortress.message.*;
    import net.*;

    public class ResCsysEndHandler extends Handler
    {

        public function ResCsysEndHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCsysEndMessage(this.message);
            ZonesRedFortressControl.getInstance().resZonesPassShow(_loc_1);
            return;
        }// end function

    }
}
