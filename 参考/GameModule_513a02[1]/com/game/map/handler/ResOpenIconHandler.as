package com.game.map.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResOpenIconHandler extends Handler
    {

        public function ResOpenIconHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenIconMessage(this.message);
            ZonesControl.getInstance().openZonesIcon(_loc_1);
            return;
        }// end function

    }
}
