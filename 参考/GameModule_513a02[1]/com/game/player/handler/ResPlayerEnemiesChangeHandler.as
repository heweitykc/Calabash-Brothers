package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerEnemiesChangeHandler extends Handler
    {

        public function ResPlayerEnemiesChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangePlayerEnemiesToClientMessage(this.message);
            PlayerControl.getInstance().playerEnemiesChangeHandler(_loc_1);
            return;
        }// end function

    }
}
