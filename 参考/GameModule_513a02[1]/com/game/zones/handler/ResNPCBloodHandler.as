package com.game.zones.handler
{
    import com.game.guard.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResNPCBloodHandler extends Handler
    {

        public function ResNPCBloodHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNpcBloodMessage(this.message);
            ZonesControl.getInstance().updateWolfBossHead(_loc_1);
            return;
        }// end function

    }
}
