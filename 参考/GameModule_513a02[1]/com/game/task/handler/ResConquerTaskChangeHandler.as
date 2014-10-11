package com.game.task.handler
{
    import com.game.task.control.*;
    import com.game.task.message.*;
    import net.*;

    public class ResConquerTaskChangeHandler extends Handler
    {

        public function ResConquerTaskChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResConquerTaskChangeMessage(this.message);
            TaskControl.getInstance().resConquerTaskChangeHandler(_loc_1);
            return;
        }// end function

    }
}
