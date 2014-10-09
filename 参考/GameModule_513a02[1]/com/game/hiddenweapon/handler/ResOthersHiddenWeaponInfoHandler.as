package com.game.hiddenweapon.handler
{
    import com.game.hiddenweapon.message.*;
    import net.*;

    public class ResOthersHiddenWeaponInfoHandler extends Handler
    {

        public function ResOthersHiddenWeaponInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOthersHiddenWeaponInfoMessage(this.message);
            return;
        }// end function

    }
}
