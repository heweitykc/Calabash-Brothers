package com.game.horseweapon.handler
{
    import com.game.horseweapon.message.*;
    import net.*;

    public class ResHorseWeaponStageUpResultHandler extends Handler
    {

        public function ResHorseWeaponStageUpResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHorseWeaponStageUpResultMessage(this.message);
            return;
        }// end function

    }
}
