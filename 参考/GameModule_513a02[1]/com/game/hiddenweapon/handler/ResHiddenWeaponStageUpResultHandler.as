package com.game.hiddenweapon.handler
{
    import com.game.hiddenweapon.message.*;
    import net.*;

    public class ResHiddenWeaponStageUpResultHandler extends Handler
    {

        public function ResHiddenWeaponStageUpResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResHiddenWeaponStageUpResultMessage(this.message);
            return;
        }// end function

    }
}
