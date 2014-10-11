package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterMaxMpChangeHandler extends Handler
    {

        public function ResMonsterMaxMpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterMaxMpChangeMessage(this.message);
            MonsterControl.getInstance().monsterMaxMpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
