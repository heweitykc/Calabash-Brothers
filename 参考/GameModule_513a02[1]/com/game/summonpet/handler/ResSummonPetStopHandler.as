package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetStopHandler extends Handler
    {

        public function ResSummonPetStopHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetStopMessage(this.message);
            SummonPetControl.getInstance().summonPetStopHandler(_loc_1);
            return;
        }// end function

    }
}
