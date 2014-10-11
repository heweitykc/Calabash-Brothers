package com.game.expireguide.handler
{
    import com.game.equip.message.*;
    import com.game.expireguide.control.*;
    import net.*;

    public class ResEquipTimeLostHandler extends Handler
    {

        public function ResEquipTimeLostHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEquipTimeLostMessage(this.message);
            ExpireGuideControl.getInstance().expireHandler(_loc_1);
            return;
        }// end function

    }
}
