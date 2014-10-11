package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerTitleChangeHandler extends Handler
    {

        public function ResPlayerTitleChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerTitleChangeMessage(message);
            PlayerControl.getInstance().updateTitle(_loc_1.personId, _loc_1.titleid);
            return;
        }// end function

    }
}
