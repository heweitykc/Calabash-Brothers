package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class WorldNoticeHandler extends Handler
    {

        public function WorldNoticeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = WorldNoticeMessage(this.message);
            return;
        }// end function

    }
}
