package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerMaxMpChangeHandler extends Handler
    {

        public function ResPlayerMaxMpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerMaxMpChangeMessage(this.message);
            return;
        }// end function

    }
}
