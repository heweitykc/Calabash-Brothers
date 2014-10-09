package com.game.equipstreng.handler
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResComposeItemToClientHandler extends Handler
    {

        public function ResComposeItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResComposeItemToClientMessage(this.message);
            EquipForgeControl.getInstance().resEquipComposeHandler(_loc_1);
            return;
        }// end function

    }
}
