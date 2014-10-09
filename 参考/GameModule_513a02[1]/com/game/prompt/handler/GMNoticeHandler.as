package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class GMNoticeHandler extends Handler
    {

        public function GMNoticeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = GMNoticeMessage(this.message);
            return;
        }// end function

    }
}
