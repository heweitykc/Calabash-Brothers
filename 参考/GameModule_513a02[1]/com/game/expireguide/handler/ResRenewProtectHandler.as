package com.game.expireguide.handler
{
    import com.game.equip.message.*;
    import com.game.expireguide.control.*;
    import net.*;

    public class ResRenewProtectHandler extends Handler
    {

        public function ResRenewProtectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRenewProtectMessage(message);
            ExpireGuideControl.getInstance().resRenewProtectResult(_loc_1);
            return;
        }// end function

    }
}
