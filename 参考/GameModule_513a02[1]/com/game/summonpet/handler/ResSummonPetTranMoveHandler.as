package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetTranMoveHandler extends Handler
    {

        public function ResSummonPetTranMoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetTranMoveMessage(this.message);
            SummonPetControl.getInstance().summonPetTranMoveHandler(_loc_1);
            return;
        }// end function

    }
}
