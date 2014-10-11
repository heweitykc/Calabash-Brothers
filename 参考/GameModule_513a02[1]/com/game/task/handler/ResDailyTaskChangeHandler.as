package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResDailyTaskChangeHandler extends Handler
    {

        public function ResDailyTaskChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDailyTaskChangeMessage(this.message);
            TaskControl.getInstance().resDailyTaskChangeHandle(_loc_1);
            return;
        }// end function

    }
}
