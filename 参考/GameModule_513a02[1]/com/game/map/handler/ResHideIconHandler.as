package com.game.map.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResHideIconHandler extends Handler
    {

        public function ResHideIconHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHideIconMessage(this.message);
            ZonesControl.getInstance().closeZonesIcon(_loc_1);
            return;
        }// end function

    }
}
