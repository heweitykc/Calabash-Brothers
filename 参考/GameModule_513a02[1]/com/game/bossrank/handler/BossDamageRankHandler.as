package com.game.bossrank.handler
{
    import com.game.bossrank.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class BossDamageRankHandler extends Handler
    {

        public function BossDamageRankHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResResponseBossDamageMessage(this.message);
            BossDamageRankControl.getInstance().resResponseBossDamageHandler(_loc_1);
            return;
        }// end function

    }
}
