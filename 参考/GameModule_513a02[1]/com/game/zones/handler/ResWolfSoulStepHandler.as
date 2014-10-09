package com.game.zones.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResWolfSoulStepHandler extends Handler
    {

        public function ResWolfSoulStepHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStepMessage(this.message);
            ZonesControl.getInstance().updateWolfSoulStep(_loc_1.step);
            return;
        }// end function

    }
}
