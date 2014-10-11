package com.game.equip.handler
{
    import com.game.backpack.control.*;
    import com.game.equip.message.*;
    import net.*;

    public class UnwearEquipItemHandler extends Handler
    {

        public function UnwearEquipItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = UnwearEquipItemMessage(this.message);
            BackPackControl.getInstance().removEquipHandler(_loc_1);
            return;
        }// end function

    }
}
