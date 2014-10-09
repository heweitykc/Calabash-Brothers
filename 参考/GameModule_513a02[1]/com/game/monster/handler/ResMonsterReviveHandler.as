package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterReviveHandler extends Handler
    {

        public function ResMonsterReviveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterReviveMessage(this.message);
            MonsterControl.getInstance().monsterReviveHandler(_loc_1);
            return;
        }// end function

    }
}
