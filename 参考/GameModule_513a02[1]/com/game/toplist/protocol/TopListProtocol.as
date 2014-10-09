package com.game.toplist.protocol
{
    import com.*;
    import com.game.toplist.message.*;

    public class TopListProtocol extends BaseProtocol
    {

        public function TopListProtocol()
        {
            return;
        }// end function

        public function reqListInfo(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqGetTopListToServerMessage();
            _loc_4.toptype = param1;
            _loc_4.start = param2;
            _loc_4.end = param3;
            send(_loc_4);
            return;
        }// end function

    }
}
