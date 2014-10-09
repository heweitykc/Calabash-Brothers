package com.game.redfortress.protocol
{
    import com.*;
    import com.game.redfortress.message.*;

    public class ZonesRedFortressProtocol extends BaseProtocol
    {

        public function ZonesRedFortressProtocol()
        {
            return;
        }// end function

        public function reqCsysTopList() : void
        {
            var _loc_1:* = new ReqCsysTopListMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
