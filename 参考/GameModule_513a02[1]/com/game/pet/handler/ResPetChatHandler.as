package com.game.pet.handler
{
    import com.game.pet.message.*;
    import com.game.summonpet.control.*;
    import net.*;

    public class ResPetChatHandler extends Handler
    {

        public function ResPetChatHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetChatMessage(this.message);
            SummonPetControl.getInstance().petChatHandler(_loc_1);
            return;
        }// end function

    }
}
