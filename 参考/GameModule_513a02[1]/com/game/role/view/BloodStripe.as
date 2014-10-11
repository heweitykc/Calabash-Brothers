package com.game.role.view
{
    import com.events.*;
    import com.f1.ui.stripe.*;
    import com.model.vo.*;

    public class BloodStripe extends Stripe
    {

        public function BloodStripe()
        {
            super("blood_stripe1");
            return;
        }// end function

        public function set info(param1:RoleInfo) : void
        {
            setValue(param1.HP, param1.HPMax);
            param1.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHP);
            param1.addEvtListener(RoleEvent.UPDATE_HPMAX, this.__updateHP);
            return;
        }// end function

        private function __updateHP(event:RoleEvent) : void
        {
            var _loc_2:* = RoleInfo(event.currentTarget);
            if (_loc_2)
            {
                setValue(_loc_2.HP, _loc_2.HPMax, true);
            }
            return;
        }// end function

    }
}
