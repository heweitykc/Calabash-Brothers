package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneSelectAwardHandler extends Handler
    {

        public function ResZoneSelectAwardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneSelectAwardMessage(this.message);
            ZonesControl.getInstance().resZoneSelectAward(_loc_1);
            return;
        }// end function

    }
}
