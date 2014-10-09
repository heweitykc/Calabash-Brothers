package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResFightBroadcastHandler extends Handler
    {

        public function ResFightBroadcastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightBroadcastMessage(this.message);
            FightControl.getInstance().fightBroadcastHandler(_loc_1);
            return;
        }// end function

    }
}
