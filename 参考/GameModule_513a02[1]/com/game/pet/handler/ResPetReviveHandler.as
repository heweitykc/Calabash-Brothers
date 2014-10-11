package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetReviveHandler extends Handler
    {

        public function ResPetReviveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetReviveMessage(this.message);
            return;
        }// end function

    }
}
