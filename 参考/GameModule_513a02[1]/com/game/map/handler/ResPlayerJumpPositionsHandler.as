package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResPlayerJumpPositionsHandler extends Handler
    {

        public function ResPlayerJumpPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerJumpPositionsMessage(this.message);
            return;
        }// end function

    }
}
