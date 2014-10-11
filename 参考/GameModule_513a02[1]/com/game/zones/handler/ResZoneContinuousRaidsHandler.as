package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneContinuousRaidsHandler extends Handler
    {

        public function ResZoneContinuousRaidsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneContinuousRaidsMessage(this.message);
            ZonesControl.getInstance().resZoneContinuousRaids(_loc_1);
            return;
        }// end function

    }
}
