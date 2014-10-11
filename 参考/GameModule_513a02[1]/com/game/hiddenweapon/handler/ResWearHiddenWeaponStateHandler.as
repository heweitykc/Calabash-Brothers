package com.game.hiddenweapon.handler
{
    import com.game.hiddenweapon.message.*;
    import net.*;

    public class ResWearHiddenWeaponStateHandler extends Handler
    {

        public function ResWearHiddenWeaponStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWearHiddenWeaponStateMessage(this.message);
            return;
        }// end function

    }
}
