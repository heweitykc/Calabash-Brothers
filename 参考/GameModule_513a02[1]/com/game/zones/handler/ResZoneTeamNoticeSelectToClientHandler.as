package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTeamNoticeSelectToClientHandler extends Handler
    {

        public function ResZoneTeamNoticeSelectToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTeamNoticeSelectToClientMessage(this.message);
            ZonesControl.getInstance().ResZoneTeamNoticeSelectToClient(_loc_1);
            return;
        }// end function

    }
}
