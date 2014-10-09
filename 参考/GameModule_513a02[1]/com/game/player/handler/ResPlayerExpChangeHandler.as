package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerExpChangeHandler extends Handler
    {

        public function ResPlayerExpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerExpChangeMessage(this.message);
            PlayerControl.getInstance().playerExpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
