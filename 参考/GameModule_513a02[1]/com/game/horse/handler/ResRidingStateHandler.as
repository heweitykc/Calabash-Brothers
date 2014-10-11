package com.game.horse.handler
{
    import com.game.horse.control.*;
    import com.game.horse.message.*;
    import net.*;

    public class ResRidingStateHandler extends Handler
    {

        public function ResRidingStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRidingStateMessage(this.message);
            HorseControl.getInstance().ResRidingStateHandler(_loc_1);
            return;
        }// end function

    }
}
