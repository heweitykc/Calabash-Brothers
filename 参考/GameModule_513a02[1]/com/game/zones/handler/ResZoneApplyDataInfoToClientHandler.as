package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneApplyDataInfoToClientHandler extends Handler
    {

        public function ResZoneApplyDataInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneApplyDataInfoToClientMessage(this.message);
            ZonesControl.getInstance().resZoneApplyDataInfo(_loc_1);
            return;
        }// end function

    }
}
