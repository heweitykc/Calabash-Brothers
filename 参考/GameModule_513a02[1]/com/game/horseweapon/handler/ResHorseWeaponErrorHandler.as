package com.game.horseweapon.handler
{
    import com.game.horseweapon.message.*;
    import net.*;

    public class ResHorseWeaponErrorHandler extends Handler
    {

        public function ResHorseWeaponErrorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHorseWeaponErrorMessage(this.message);
            return;
        }// end function

    }
}
