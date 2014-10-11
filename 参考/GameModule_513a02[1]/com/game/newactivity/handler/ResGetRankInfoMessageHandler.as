package com.game.newactivity.handler
{
    import com.events.*;
    import com.f1.*;
    import com.game.newactivity.message.*;
    import net.*;

    public class ResGetRankInfoMessageHandler extends Handler
    {

        public function ResGetRankInfoMessageHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetRankInfoMessage(this.message);
            FrameworkGlobal.sendMsg(new NewActivityEvent(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, _loc_1));
            return;
        }// end function

    }
}
