package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResTowerIndexHandler extends Handler
    {

        public function ResTowerIndexHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTowerIndexMessage(message);
            ZonesControl.getInstance().resTowerIndex(_loc_1);
            return;
        }// end function

    }
}
