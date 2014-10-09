package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResDamageResultHandler extends Handler
    {

        public function ResDamageResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDamageResultMessage(this.message);
            FightControl.getInstance().resDamageResultHandler(_loc_1);
            return;
        }// end function

    }
}
