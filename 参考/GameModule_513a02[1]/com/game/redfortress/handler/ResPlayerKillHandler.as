package com.game.redfortress.handler
{
    import com.game.redfortress.control.*;
    import com.game.redfortress.message.*;
    import net.*;

    public class ResPlayerKillHandler extends Handler
    {

        public function ResPlayerKillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerKillMessage(this.message);
            ZonesRedFortressControl.getInstance().resPlayerKill(_loc_1);
            return;
        }// end function

    }
}
