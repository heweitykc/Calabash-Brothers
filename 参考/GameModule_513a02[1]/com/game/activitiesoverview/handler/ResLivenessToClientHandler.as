package com.game.activitiesoverview.handler
{
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.message.*;
    import net.*;

    public class ResLivenessToClientHandler extends Handler
    {

        public function ResLivenessToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLivenessToClientMessage(this.message);
            ActivitiesOverviewControl.getInstance().setLiveness(_loc_1.liveness);
            return;
        }// end function

    }
}
