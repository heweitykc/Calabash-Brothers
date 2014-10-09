package com.game.equipstreng.handler
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.*;
    import net.*;

    public class ResStrengthEffectHandler extends Handler
    {

        public function ResStrengthEffectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStrengthEffectMessage(this.message);
            EquipForgeControl.getInstance().resEquipStrengthEffectHandler(_loc_1);
            return;
        }// end function

    }
}
