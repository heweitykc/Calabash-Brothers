package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResTowerRewardHandler extends Handler
    {

        public function ResTowerRewardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTowerRewardMessage(message);
            ZonesControl.getInstance().resTowerReward(_loc_1);
            return;
        }// end function

    }
}
