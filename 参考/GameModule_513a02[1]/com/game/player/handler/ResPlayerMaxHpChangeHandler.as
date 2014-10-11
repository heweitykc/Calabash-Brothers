package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerMaxHpChangeHandler extends Handler
    {

        public function ResPlayerMaxHpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerMaxHpChangeMessage(this.message);
            PlayerControl.getInstance().updateplayerMaxHpChange(_loc_1);
            return;
        }// end function

    }
}
