package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResAllRaidZoneInfoHandler extends Handler
    {

        public function ResAllRaidZoneInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAllRaidZoneInfoMessage(this.message);
            ZonesControl.getInstance().resAllRaidZoneInfo(_loc_1);
            return;
        }// end function

    }
}
