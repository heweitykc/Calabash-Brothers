package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetRunPositionsHandler extends Handler
    {

        public function ResSummonPetRunPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetRunPositionsMessage(this.message);
            SummonPetControl.getInstance().summonPetRunPositionsHandler(_loc_1);
            return;
        }// end function

    }
}
