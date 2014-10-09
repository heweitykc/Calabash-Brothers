package com.game.zones.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResWolfSpecialHandler extends Handler
    {

        public function ResWolfSpecialHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSpecialMessage(this.message);
            ZonesControl.getInstance().updateSpecialView(_loc_1);
            return;
        }// end function

    }
}
