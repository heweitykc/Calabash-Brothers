package com.game.zones.handler
{
    import com.game.redfortress.control.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneLifeTimeHandler extends Handler
    {

        public function ResZoneLifeTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneLifeTimeMessage(this.message);
            ZonesControl.getInstance().resZoneLifeTime(_loc_1);
            ZonesRedFortressControl.getInstance().resZoneLifeTime(_loc_1);
            return;
        }// end function

    }
}
