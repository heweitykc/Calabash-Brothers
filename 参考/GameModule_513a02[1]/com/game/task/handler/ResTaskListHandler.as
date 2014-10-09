package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResTaskListHandler extends Handler
    {

        public function ResTaskListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTaskListMessage(this.message);
            TaskControl.getInstance().taskListHandler(_loc_1);
            return;
        }// end function

    }
}
