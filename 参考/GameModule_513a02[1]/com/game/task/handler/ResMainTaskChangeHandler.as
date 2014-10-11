package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResMainTaskChangeHandler extends Handler
    {

        public function ResMainTaskChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMainTaskChangeMessage(this.message);
            TaskControl.getInstance().resMainTaskChangeHandler(_loc_1);
            return;
        }// end function

    }
}
