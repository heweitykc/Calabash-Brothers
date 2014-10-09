package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTeamErroHandler extends Handler
    {

        public function ResZoneTeamErroHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTeamErroMessage(this.message);
            ZonesControl.getInstance().resZoneTeamError(_loc_1);
            return;
        }// end function

    }
}
