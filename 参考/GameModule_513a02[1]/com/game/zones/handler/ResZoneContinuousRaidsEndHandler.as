package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneContinuousRaidsEndHandler extends Handler
    {

        public function ResZoneContinuousRaidsEndHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneContinuousRaidsEndMessage(this.message);
            ZonesControl.getInstance().resZoneContinuousRaidsEnd(_loc_1);
            return;
        }// end function

    }
}
