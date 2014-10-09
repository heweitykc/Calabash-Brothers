package com.game.equipstreng.handler
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResStrengItemToClientHandler extends Handler
    {

        public function ResStrengItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStrengItemToClientMessage(this.message);
            EquipForgeControl.getInstance().resEquipStrengHandler(_loc_1);
            return;
        }// end function

    }
}
