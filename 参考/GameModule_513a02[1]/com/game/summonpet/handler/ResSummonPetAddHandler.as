package com.game.summonpet.handler
{
    import com.game.summonpet.control.*;
    import com.game.summonpet.message.*;
    import net.*;

    public class ResSummonPetAddHandler extends Handler
    {

        public function ResSummonPetAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSummonPetAddMessage(this.message);
            SummonPetControl.getInstance().summonPetAddHandler(_loc_1);
            return;
        }// end function

    }
}
