package com.game.zones.handler
{
    import com.game.bosshome.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResBossHomePlayerNumHandler extends Handler
    {

        public function ResBossHomePlayerNumHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBossHomePlayerNumMessage(this.message);
            ZonesControl.getInstance().dealBossHomeAnger(_loc_1);
            return;
        }// end function

    }
}
