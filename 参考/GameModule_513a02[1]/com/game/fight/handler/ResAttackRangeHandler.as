package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResAttackRangeHandler extends Handler
    {

        public function ResAttackRangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAttackRangeMessage(this.message);
            FightControl.getInstance().attackRangeShow(_loc_1);
            return;
        }// end function

    }
}
