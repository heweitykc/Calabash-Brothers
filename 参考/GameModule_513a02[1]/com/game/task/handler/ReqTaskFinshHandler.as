package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ReqTaskFinshHandler extends Handler
    {

        public function ReqTaskFinshHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankTaskListMessage(this.message);
            return;
        }// end function

    }
}
