package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTimeRecordNoticeHandler extends Handler
    {

        public function ResZoneTimeRecordNoticeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTimeRecordNoticeMessage(this.message);
            ZonesControl.getInstance().resZoneTimeRecordNotice(_loc_1);
            return;
        }// end function

    }
}
