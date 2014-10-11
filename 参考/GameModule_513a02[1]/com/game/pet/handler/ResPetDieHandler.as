package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetDieHandler extends Handler
    {

        public function ResPetDieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetDieMessage(this.message);
            return;
        }// end function

    }
}
