package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerSpChangeHandler extends Handler
    {

        public function ResPlayerSpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerSpChangeMessage(this.message);
            return;
        }// end function

    }
}
