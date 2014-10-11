package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResTowerNextLvHandler extends Handler
    {

        public function ResTowerNextLvHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTowerNextLvMessage(this.message);
            ZonesControl.getInstance().resTowerNextLv(_loc_1);
            return;
        }// end function

    }
}
