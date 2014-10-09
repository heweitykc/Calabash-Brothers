package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneKillProgressRateHandler extends Handler
    {

        public function ResZoneKillProgressRateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneKillProgressRateMessage(this.message);
            ZonesControl.getInstance().resZoneKillProgressRate(_loc_1);
            return;
        }// end function

    }
}
