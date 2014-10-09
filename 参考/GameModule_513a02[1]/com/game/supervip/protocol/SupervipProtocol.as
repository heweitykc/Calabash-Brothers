package com.game.supervip.protocol
{
    import com.*;
    import com.game.supervip.message.*;

    public class SupervipProtocol extends BaseProtocol
    {

        public function SupervipProtocol()
        {
            return;
        }// end function

        public function reqGetSuperVipInfo() : void
        {
            var _loc_1:* = new ReqGetSuperVipInfoMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
