package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterHpChangeHandler extends Handler
    {

        public function ResMonsterHpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterHpChangeMessage(this.message);
            MonsterControl.getInstance().monsterHpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
