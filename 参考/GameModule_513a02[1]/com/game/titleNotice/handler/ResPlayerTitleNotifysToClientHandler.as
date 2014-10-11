package com.game.titleNotice.handler
{
    import com.game.player.message.*;
    import com.game.titleNotice.control.*;
    import net.*;

    public class ResPlayerTitleNotifysToClientHandler extends Handler
    {

        public function ResPlayerTitleNotifysToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerTitleNotifysToClientMessage(message);
            TitleNoticeControl.instance.addMsg(_loc_1.titleId, _loc_1.type, _loc_1.time);
            return;
        }// end function

    }
}
