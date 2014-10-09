package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResAttackResultHandler extends Handler
    {

        public function ResAttackResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAttackResultMessage(this.message);
            FightControl.getInstance().attackResultHandler(_loc_1);
            return;
        }// end function

    }
}
