package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResBuffAddHandler extends Handler
    {

        public function ResBuffAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBuffAddMessage(this.message);
            ZonesControl.getInstance().resBuffInspireAdd(_loc_1);
            return;
        }// end function

    }
}
