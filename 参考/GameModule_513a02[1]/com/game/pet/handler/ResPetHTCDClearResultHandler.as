package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetHTCDClearResultHandler extends Handler
    {

        public function ResPetHTCDClearResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetHTCDClearResultMessage(this.message);
            return;
        }// end function

    }
}
