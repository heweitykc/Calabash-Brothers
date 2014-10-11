package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTeamShowToClientHandler extends Handler
    {

        public function ResZoneTeamShowToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTeamShowToClientMessage(this.message);
            ZonesControl.getInstance().resZoneTeamShowToClient(_loc_1);
            return;
        }// end function

    }
}
