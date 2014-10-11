package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResFightPostionBroadcastHandler extends Handler
    {

        public function ResFightPostionBroadcastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightPostionBroadcastMessage(this.message);
            FightControl.getInstance().fightPostionBroadcastHandler(_loc_1);
            return;
        }// end function

    }
}
