package com.game.activitiesoverview.handler
{
    import com.game.activitiesoverview.control.*;
    import com.game.activitiesoverview.message.*;
    import net.*;

    public class ResEventChanageToClientHandler extends Handler
    {

        public function ResEventChanageToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEventChanageToClientMessage(this.message);
            ActivitiesOverviewControl.getInstance().changeEvent(_loc_1.type, _loc_1.count);
            return;
        }// end function

    }
}
