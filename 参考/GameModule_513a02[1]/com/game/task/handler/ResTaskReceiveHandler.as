package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResTaskReceiveHandler extends Handler
    {

        public function ResTaskReceiveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTaskReceiveMessage(this.message);
            return;
        }// end function

    }
}
