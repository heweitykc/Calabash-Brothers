package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResTowerRewardSurplusHandler extends Handler
    {

        public function ResTowerRewardSurplusHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTowerRewardSurplusMessage(message);
            ZonesControl.getInstance().resTowerRewardSurplus(_loc_1);
            return;
        }// end function

    }
}
