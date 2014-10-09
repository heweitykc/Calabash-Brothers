package com.game.activitiesoverview.handler
{
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.message.*;
    import net.*;

    public class ResGainStateToClientHandler extends Handler
    {

        public function ResGainStateToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGainStateToClientMessage(this.message);
            ActivitiesOverviewControl.getInstance().gainBoxesRes(_loc_1.boxes);
            return;
        }// end function

    }
}
