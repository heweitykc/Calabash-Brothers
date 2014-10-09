package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterSpeedChangeHandler extends Handler
    {

        public function ResMonsterSpeedChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterSpeedChangeMessage(this.message);
            MonsterControl.getInstance().monsterSpeedChangeHandler(_loc_1);
            return;
        }// end function

    }
}
