package com.game.task.handler
{
    import com.game.task.message.*;
    import net.*;

    public class ResGiveUpTaskHandler extends Handler
    {

        public function ResGiveUpTaskHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGiveUpTaskMessage(this.message);
            return;
        }// end function

    }
}
