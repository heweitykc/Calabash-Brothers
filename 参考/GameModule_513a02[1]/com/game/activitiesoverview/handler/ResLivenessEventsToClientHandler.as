package com.game.activitiesoverview.handler
{
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.message.*;
    import net.*;

    public class ResLivenessEventsToClientHandler extends Handler
    {

        public function ResLivenessEventsToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLivenessEventsToClientMessage(this.message);
            ActivitiesOverviewControl.getInstance().getEventRes(_loc_1.event);
            return;
        }// end function

    }
}
