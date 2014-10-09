package com.game.onlineactivity.protocol
{
    import com.*;
    import com.game.newactivity.message.*;

    public class OnlineActivityProtocol extends BaseProtocol
    {

        public function OnlineActivityProtocol()
        {
            return;
        }// end function

        public function reqGetNewActivityInfo(param1:int) : void
        {
            var _loc_2:* = new ReqGetNewActivityInfo();
            _loc_2.activityId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
