package com.game.perfectInfo.handler
{
    import com.game.perfectInfo.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResSubmitImproveDataHandler extends Handler
    {

        public function ResSubmitImproveDataHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSubmitImproveDataMessage(this.message);
            PerfectInfoControl.getInstance().submitInfoResult(_loc_1.isSuccess == 1);
            return;
        }// end function

    }
}
