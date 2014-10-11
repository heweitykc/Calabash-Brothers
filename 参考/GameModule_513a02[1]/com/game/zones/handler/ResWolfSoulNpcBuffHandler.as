package com.game.zones.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResWolfSoulNpcBuffHandler extends Handler
    {

        public function ResWolfSoulNpcBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNpcBuffMessage(this.message);
            ZonesControl.getInstance().wolfSoulNpcBuffAct();
            return;
        }// end function

    }
}
