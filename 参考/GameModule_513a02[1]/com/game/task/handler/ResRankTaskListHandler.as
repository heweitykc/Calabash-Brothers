package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResRankTaskListHandler extends Handler
    {

        public function ResRankTaskListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankTaskListMessage(this.message);
            TaskControl.getInstance().rankTaskListHandler(_loc_1);
            return;
        }// end function

    }
}
