package com.game.buff.protocol
{
    import com.*;
    import com.game.buff.message.*;
    import com.game.utils.*;

    public class BuffProtocol extends BaseProtocol
    {

        public function BuffProtocol()
        {
            return;
        }// end function

        public function reqRemoveBuff(param1:long) : void
        {
            var _loc_2:* = new ReqRemoveBuffMessage();
            _loc_2.buffId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqBuffInfo(param1:long) : void
        {
            var _loc_2:* = new ReqBuffInfoMessage();
            _loc_2.buffId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
