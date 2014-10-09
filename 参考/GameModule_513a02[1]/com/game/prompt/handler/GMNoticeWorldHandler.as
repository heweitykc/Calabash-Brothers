package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class GMNoticeWorldHandler extends Handler
    {

        public function GMNoticeWorldHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = GMNoticeWorldMessage(this.message);
            return;
        }// end function

    }
}
