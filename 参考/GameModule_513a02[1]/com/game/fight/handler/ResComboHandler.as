package com.game.fight.handler
{
    import com.game.fight.control.*;
    import com.game.fight.message.*;
    import net.*;

    public class ResComboHandler extends Handler
    {

        public function ResComboHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResComboMessage(this.message);
            FightControl.getInstance().resComboHandler(_loc_1);
            return;
        }// end function

    }
}
