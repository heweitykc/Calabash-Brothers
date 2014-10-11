package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetAttributeChangeHandler extends Handler
    {

        public function ResSummonPetAttributeChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetAttributeChangeMessage(this.message);
            SummonPetControl.getInstance().summonPetAttributeChangeHandler(_loc_1);
            return;
        }// end function

    }
}
