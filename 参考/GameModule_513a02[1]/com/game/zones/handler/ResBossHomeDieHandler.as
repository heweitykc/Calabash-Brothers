package com.game.zones.handler
{
    import com.game.bosshome.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResBossHomeDieHandler extends Handler
    {

        public function ResBossHomeDieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBossHomeDieMessage(this.message);
            ZonesControl.getInstance().dealBossHomeDie(_loc_1);
            return;
        }// end function

    }
}
