package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResJumpSetPositionHandler extends Handler
    {

        public function ResJumpSetPositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResJumpSetPositionMessage(this.message);
            return;
        }// end function

    }
}
