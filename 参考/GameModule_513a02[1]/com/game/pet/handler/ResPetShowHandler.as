package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetShowHandler extends Handler
    {

        public function ResPetShowHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetShowMessage(this.message);
            return;
        }// end function

    }
}
