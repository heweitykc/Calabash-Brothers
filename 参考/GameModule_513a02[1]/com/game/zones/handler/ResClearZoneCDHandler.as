package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResClearZoneCDHandler extends Handler
    {

        public function ResClearZoneCDHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResClearZoneCDMessage(this.message);
            ZonesControl.getInstance().resClearZoneCDBack(_loc_1);
            return;
        }// end function

    }
}
