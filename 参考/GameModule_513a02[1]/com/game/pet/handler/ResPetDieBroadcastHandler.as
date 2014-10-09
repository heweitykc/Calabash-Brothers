package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetDieBroadcastHandler extends Handler
    {

        public function ResPetDieBroadcastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetDieBroadcastMessage(this.message);
            return;
        }// end function

    }
}
