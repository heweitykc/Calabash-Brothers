package com.game.horseweapon.handler
{
    import com.game.horseweapon.message.*;
    import net.*;

    public class ResHorseWeaponInfoHandler extends Handler
    {

        public function ResHorseWeaponInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHorseWeaponInfoMessage(this.message);
            return;
        }// end function

    }
}
