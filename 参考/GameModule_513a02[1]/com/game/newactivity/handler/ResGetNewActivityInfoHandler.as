package com.game.newactivity.handler
{
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import net.*;

    public class ResGetNewActivityInfoHandler extends Handler
    {

        public function ResGetNewActivityInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetNewActivityInfo(this.message);
            NewActivityModel.getInstance().activityDetailUpdate(_loc_1);
            return;
        }// end function

    }
}
