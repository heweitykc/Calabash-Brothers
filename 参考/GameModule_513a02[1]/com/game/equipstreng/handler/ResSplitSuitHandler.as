package com.game.equipstreng.handler
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResSplitSuitHandler extends Handler
    {

        public function ResSplitSuitHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSplitSuitMessage(message);
            EquipForgeControl.getInstance().resEquipSplitBack(_loc_1);
            return;
        }// end function

    }
}
