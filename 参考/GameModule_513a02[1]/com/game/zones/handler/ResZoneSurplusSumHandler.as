package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneSurplusSumHandler extends Handler
    {

        public function ResZoneSurplusSumHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneSurplusSumMessage(this.message);
            ZonesControl.getInstance().resZoneSurplusSum(_loc_1);
            return;
        }// end function

    }
}
