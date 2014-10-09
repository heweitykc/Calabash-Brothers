package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZonePassShowHandler extends Handler
    {

        public function ResZonePassShowHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZonePassShowMessage(this.message);
            ZonesControl.getInstance().resZonePassShow(_loc_1);
            return;
        }// end function

    }
}
