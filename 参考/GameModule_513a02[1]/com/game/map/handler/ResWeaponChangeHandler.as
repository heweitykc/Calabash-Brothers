package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResWeaponChangeHandler extends Handler
    {

        public function ResWeaponChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWeaponChangeMessage(this.message);
            MapControl.getInstance().weaponChangeHandler(_loc_1);
            return;
        }// end function

    }
}
