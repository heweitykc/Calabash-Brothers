package com.game.prey.protocol
{
    import com.*;
    import com.game.pray.message.*;

    public class PrayProtocol extends BaseProtocol
    {

        public function PrayProtocol()
        {
            return;
        }// end function

        public function reqPrayInfo() : void
        {
            var _loc_1:* = new ReqPrayInfoMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqPray(param1:int) : void
        {
            var _loc_2:* = new ReqPrayMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
