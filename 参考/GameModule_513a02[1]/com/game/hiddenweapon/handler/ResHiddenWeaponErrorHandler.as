package com.game.hiddenweapon.handler
{
    import com.game.hiddenweapon.message.*;
    import net.*;

    public class ResHiddenWeaponErrorHandler extends Handler
    {

        public function ResHiddenWeaponErrorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHiddenWeaponErrorMessage(this.message);
            return;
        }// end function

    }
}
