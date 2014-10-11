package com.game.redfortress.handler
{
    import com.game.redfortress.control.*;
    import com.game.redfortress.message.*;
    import net.*;

    public class ResChangeIntegralHandler extends Handler
    {

        public function ResChangeIntegralHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeIntegralMessage(this.message);
            ZonesRedFortressControl.getInstance().resChangeIntegralHandler(_loc_1);
            return;
        }// end function

    }
}
