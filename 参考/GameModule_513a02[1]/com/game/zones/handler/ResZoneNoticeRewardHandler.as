package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneNoticeRewardHandler extends Handler
    {

        public function ResZoneNoticeRewardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneNoticeRewardMessage(this.message);
            ZonesControl.getInstance().resZoneNoticeRewardHandler(_loc_1);
            return;
        }// end function

    }
}
