package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResPlayerBattleExpChangeHandler extends Handler
    {

        public function ResPlayerBattleExpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerBattleExpChangeMessage(this.message);
            return;
        }// end function

    }
}
