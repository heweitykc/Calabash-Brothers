package com.game.pet.handler
{
    import com.game.pet.message.*;
    import net.*;

    public class ResPetTargetHandler extends Handler
    {

        public function ResPetTargetHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetTargetMessage(this.message);
            return;
        }// end function

    }
}
