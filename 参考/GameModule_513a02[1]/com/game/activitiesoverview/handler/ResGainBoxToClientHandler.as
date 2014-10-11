package com.game.activitiesoverview.handler
{
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.message.*;
    import net.*;

    public class ResGainBoxToClientHandler extends Handler
    {

        public function ResGainBoxToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGainBoxToClientMessage(this.message);
            ActivitiesOverviewControl.getInstance().gainBoxRes(_loc_1.boxesId, _loc_1.success);
            return;
        }// end function

    }
}
