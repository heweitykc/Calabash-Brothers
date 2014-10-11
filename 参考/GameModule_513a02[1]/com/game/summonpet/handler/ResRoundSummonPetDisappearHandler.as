package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResRoundSummonPetDisappearHandler extends Handler
    {

        public function ResRoundSummonPetDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundSummonPetDisappearMessage(this.message);
            SummonPetControl.getInstance().roundSummonPetDisappearHandler(_loc_1);
            return;
        }// end function

    }
}
