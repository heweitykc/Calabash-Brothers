package com.game.hiddenweapon.handler
{
    import com.game.hiddenweapon.message.*;
    import net.*;

    public class ResHiddenWeaponInfoHandler extends Handler
    {

        public function ResHiddenWeaponInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHiddenWeaponInfoMessage(this.message);
            return;
        }// end function

    }
}
