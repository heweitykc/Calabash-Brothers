package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResRankTaskChangeHandler extends Handler
    {

        public function ResRankTaskChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRankTaskChangeMessage(this.message);
            TaskControl.getInstance().resRankTaskChangeHandler(_loc_1);
            return;
        }// end function

    }
}
