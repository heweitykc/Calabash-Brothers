package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTeamOpenBullToClientHandler extends Handler
    {

        public function ResZoneTeamOpenBullToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTeamOpenBullToClientMessage(this.message);
            ZonesControl.getInstance().resZoneTeamOpenBullToClient(_loc_1);
            return;
        }// end function

    }
}
