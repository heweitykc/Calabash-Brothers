package com.game.vipcopy.protocol
{
    import com.*;
    import com.game.zones.message.*;

    public class VipCopyProtocol extends BaseProtocol
    {

        public function VipCopyProtocol()
        {
            return;
        }// end function

        public function reqVipCopy(param1:int, param2:int) : void
        {
            var _loc_3:* = new ReqZoneTeamEnterToGameMessage();
            _loc_3.entertype = param1;
            _loc_3.zoneid = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
