package com.game.vip.protocol
{
    import com.*;
    import com.game.vip.message.*;

    public class VIPProtocol extends BaseProtocol
    {

        public function VIPProtocol()
        {
            return;
        }// end function

        public function openVip(param1:int, param2:int, param3:String = "") : void
        {
            var _loc_4:* = new ReqOpenVIPMessage();
            _loc_4.vipType = param2;
            _loc_4.openType = param1;
            _loc_4.friendName = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqInfo() : void
        {
            var _loc_1:* = new ReqPlayerVIPInfoMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
