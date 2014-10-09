package com.game.zones.handler
{
    import com.game.bosshome.message.*;
    import com.game.zones.model.*;
    import net.*;

    public class ResOpenBossHomeHandler extends Handler
    {

        public function ResOpenBossHomeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenBossHomeMessage(this.message);
            BossHomeModel.getInstance().isFirst = true;
            return;
        }// end function

    }
}
