package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetAddHandler extends Handler
    {

        public function ResPetAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetAddMessage(this.message);
            return;
        }// end function

    }
}
