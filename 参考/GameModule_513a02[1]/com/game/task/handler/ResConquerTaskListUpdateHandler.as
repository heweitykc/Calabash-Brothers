package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResConquerTaskListUpdateHandler extends Handler
    {

        public function ResConquerTaskListUpdateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResConquerTaskListUpdateMessage(this.message);
            return;
        }// end function

    }
}
