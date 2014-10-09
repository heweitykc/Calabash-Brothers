package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResAutoRaidInfoHandler extends Handler
    {

        public function ResAutoRaidInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAutoRaidInfoMessage(this.message);
            ZonesControl.getInstance().resAutoRaidInfo(_loc_1);
            return;
        }// end function

    }
}
