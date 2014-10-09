package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResRoundSummonPetHandler extends Handler
    {

        public function ResRoundSummonPetHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundSummonPetMessage(this.message);
            SummonPetControl.getInstance().roundSummonPetHandler(_loc_1);
            return;
        }// end function

    }
}
