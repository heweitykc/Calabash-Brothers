package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerSpeedChangeHandler extends Handler
    {

        public function ResPlayerSpeedChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerSpeedChangeMessage(this.message);
            return;
        }// end function

    }
}
