package com.game.newactivity.handler
{
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import net.*;

    public class ResNewActivityListHandler extends Handler
    {

        public function ResNewActivityListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNewActivityList(this.message);
            NewActivityModel.getInstance().initActivityList(_loc_1);
            return;
        }// end function

    }
}
