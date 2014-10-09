package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerMaxSpChangeHandler extends Handler
    {

        public function ResPlayerMaxSpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerMaxSpChangeMessage(this.message);
            return;
        }// end function

    }
}
