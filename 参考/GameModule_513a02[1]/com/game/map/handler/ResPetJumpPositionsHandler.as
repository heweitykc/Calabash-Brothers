package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResPetJumpPositionsHandler extends Handler
    {

        public function ResPetJumpPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetJumpPositionsMessage(this.message);
            return;
        }// end function

    }
}
