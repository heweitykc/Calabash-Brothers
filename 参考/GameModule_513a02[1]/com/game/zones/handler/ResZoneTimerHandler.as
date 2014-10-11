package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneTimerHandler extends Handler
    {

        public function ResZoneTimerHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneTimerMessage(this.message);
            ZonesControl.getInstance().resZoneTimer(_loc_1);
            return;
        }// end function

    }
}
