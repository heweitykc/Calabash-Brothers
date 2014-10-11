package com.game.monster.handler
{
    import com.game.monster.message.*;
    import net.*;

    public class ResQueryBossListResultHandler extends Handler
    {

        public function ResQueryBossListResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResQueryBossListResultMessage(this.message);
            return;
        }// end function

    }
}
