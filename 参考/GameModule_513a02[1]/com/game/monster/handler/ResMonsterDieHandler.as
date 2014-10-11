package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterDieHandler extends Handler
    {

        public function ResMonsterDieHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterDieMessage(this.message);
            MonsterControl.getInstance().monsterDie(_loc_1);
            return;
        }// end function

    }
}
