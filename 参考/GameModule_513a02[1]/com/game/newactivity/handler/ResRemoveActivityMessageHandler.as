package com.game.newactivity.handler
{
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import net.*;

    public class ResRemoveActivityMessageHandler extends Handler
    {

        public function ResRemoveActivityMessageHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRemoveActivityMessage(this.message);
            NewActivityModel.getInstance().removeActivity(_loc_1.activityId);
            return;
        }// end function

    }
}
