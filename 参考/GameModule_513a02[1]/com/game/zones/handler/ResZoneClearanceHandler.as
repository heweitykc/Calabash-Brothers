package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneClearanceHandler extends Handler
    {

        public function ResZoneClearanceHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneClearanceMessage(this.message);
            ZonesControl.getInstance().resZoneClearance(_loc_1);
            return;
        }// end function

    }
}
