package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResFightFailedBroadcastHandler extends Handler
    {

        public function ResFightFailedBroadcastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightFailedBroadcastMessage(this.message);
            FightControl.getInstance().fightFailedBroadcastHandler(_loc_1);
            return;
        }// end function

    }
}
