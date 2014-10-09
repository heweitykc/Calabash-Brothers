package com.game.horseweapon.handler
{
    import com.game.horseweapon.message.*;
    import net.*;

    public class ResOthersHorseWeaponInfoHandler extends Handler
    {

        public function ResOthersHorseWeaponInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOthersHorseWeaponInfoMessage(this.message);
            return;
        }// end function

    }
}
