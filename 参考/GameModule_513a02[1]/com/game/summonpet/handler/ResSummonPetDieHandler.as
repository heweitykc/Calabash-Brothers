package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetDieHandler extends Handler
    {

        public function ResSummonPetDieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetDieMessage(this.message);
            SummonPetControl.getInstance().summonPetDieHandler(_loc_1);
            return;
        }// end function

    }
}
