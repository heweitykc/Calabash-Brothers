package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTeamNoticeToClientHandler extends Handler
    {

        public function ResZoneTeamNoticeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTeamNoticeToClientMessage(this.message);
            ZonesControl.getInstance().ResZoneTeamNoticeToClient(_loc_1);
            return;
        }// end function

    }
}
