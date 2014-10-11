package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetAttributeChangeHandler extends Handler
    {

        public function ResPetAttributeChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetAttributeChangeMessage(this.message);
            return;
        }// end function

    }
}
