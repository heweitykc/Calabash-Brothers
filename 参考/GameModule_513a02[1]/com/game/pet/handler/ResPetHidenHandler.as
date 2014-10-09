package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetHidenHandler extends Handler
    {

        public function ResPetHidenHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetHidenMessage(this.message);
            return;
        }// end function

    }
}
