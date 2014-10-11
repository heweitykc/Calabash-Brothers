package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class WorldNoticeWorldHandler extends Handler
    {

        public function WorldNoticeWorldHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = WorldNoticeWorldMessage(this.message);
            return;
        }// end function

    }
}
