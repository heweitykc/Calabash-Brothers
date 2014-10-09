package com.game.skill.handler
{
    import com.game.fight.control.*;
    import com.game.skill.message.*;
    import net.*;

    public class ResFlashMoveHandler extends Handler
    {

        public function ResFlashMoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFlashMoveMessage(this.message);
            FightControl.getInstance().resflashMove(_loc_1);
            return;
        }// end function

    }
}
