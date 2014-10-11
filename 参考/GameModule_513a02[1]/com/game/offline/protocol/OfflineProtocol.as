package com.game.offline.protocol
{
    import com.*;
    import com.game.offline.message.*;

    public class OfflineProtocol extends BaseProtocol
    {

        public function OfflineProtocol()
        {
            return;
        }// end function

        public function reqRetreatInfo() : void
        {
            var _loc_1:* = new ReqRetreatInfoMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqGetRetreatAward(param1:int) : void
        {
            var _loc_2:* = new ReqGetRetreatAwardMessage();
            _loc_2.getType = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
