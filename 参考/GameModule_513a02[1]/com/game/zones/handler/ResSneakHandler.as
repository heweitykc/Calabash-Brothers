package com.game.zones.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResSneakHandler extends Handler
    {

        public function ResSneakHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSneakMessage(this.message);
            ZonesControl.getInstance().openWolfSoulSneakCount(_loc_1);
            return;
        }// end function

    }
}
