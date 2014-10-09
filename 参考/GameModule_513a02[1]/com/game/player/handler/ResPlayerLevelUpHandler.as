package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerLevelUpHandler extends Handler
    {

        public function ResPlayerLevelUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerLevelUpMessage(this.message);
            PlayerControl.getInstance().playerLevelUpHandler(_loc_1);
            return;
        }// end function

    }
}
