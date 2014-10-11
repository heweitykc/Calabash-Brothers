package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterMpChangeHandler extends Handler
    {

        public function ResMonsterMpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterMpChangeMessage(this.message);
            MonsterControl.getInstance().monsterMpChangeHandler(_loc_1);
            return;
        }// end function

    }
}
