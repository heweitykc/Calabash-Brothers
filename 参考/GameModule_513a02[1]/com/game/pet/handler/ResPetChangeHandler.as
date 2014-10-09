package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetChangeHandler extends Handler
    {

        public function ResPetChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetChangeMessage(this.message);
            return;
        }// end function

    }
}
