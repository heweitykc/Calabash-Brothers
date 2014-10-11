package com.game.equip.handler
{
    import com.game.equip.message.*;
    import com.game.map.control.*;
    import net.*;

    public class WearCutePetItemUpdateHandler extends Handler
    {

        public function WearCutePetItemUpdateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEquipPetMessage(this.message);
            MapControl.getInstance().cutePetChangeHandler(_loc_1);
            return;
        }// end function

    }
}
