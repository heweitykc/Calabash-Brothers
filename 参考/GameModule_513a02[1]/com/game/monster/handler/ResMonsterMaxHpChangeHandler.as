package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterMaxHpChangeHandler extends Handler
    {

        public function ResMonsterMaxHpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterMaxHpChangeMessage(this.message);
            MonsterControl.getInstance().monsterMaxHpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
