package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetHeTiResultHandler extends Handler
    {

        public function ResPetHeTiResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetHeTiResultMessage(this.message);
            return;
        }// end function

    }
}
