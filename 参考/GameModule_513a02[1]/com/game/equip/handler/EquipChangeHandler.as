package com.game.equip.handler
{
    import com.game.equip.message.*;
    import com.game.player.model.*;
    import com.model.vo.*;
    import net.*;

    public class EquipChangeHandler extends Handler
    {

        public function EquipChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEquipChangeMessage(this.message);
            var _loc_2:* = EquipsObj.getInstance().getEquipById(_loc_1.item.itemId);
            if (_loc_2)
            {
                EquipsObj.getInstance().updateEquip(_loc_2, _loc_1.item);
            }
            return;
        }// end function

    }
}
