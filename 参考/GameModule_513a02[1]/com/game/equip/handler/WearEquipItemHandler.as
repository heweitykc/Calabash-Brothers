package com.game.equip.handler
{
    import com.game.equip.message.*;
    import com.game.player.model.*;
    import com.game.sound.control.*;
    import com.model.vo.*;
    import net.*;

    public class WearEquipItemHandler extends Handler
    {

        public function WearEquipItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = WearEquipItemMessage(this.message);
            var _loc_2:* = new EquipmentInfo();
            _loc_2.con(_loc_1.equip, _loc_1.pos);
            EquipsObj.getInstance().addEquip(_loc_2);
            SoundControl.getInstance().playItemSound(SoundFlag.USE_ITEM, _loc_1.equip.itemModelId);
            return;
        }// end function

    }
}
