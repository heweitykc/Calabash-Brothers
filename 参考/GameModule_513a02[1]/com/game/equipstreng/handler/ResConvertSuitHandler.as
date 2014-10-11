package com.game.equipstreng.handler
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResConvertSuitHandler extends Handler
    {

        public function ResConvertSuitHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResConvertSuitMessage(message);
            EquipForgeControl.getInstance().resConvertSuit(_loc_1);
            return;
        }// end function

    }
}
