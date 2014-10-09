package com.game.expireguide.protocol
{
    import com.*;
    import com.game.equip.message.*;
    import com.game.utils.*;

    public class ExpireGuideProtocol extends BaseProtocol
    {

        public function ExpireGuideProtocol()
        {
            return;
        }// end function

        public function renewProtect(param1:long) : void
        {
            var _loc_2:* = new ReqRenewProtectMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
