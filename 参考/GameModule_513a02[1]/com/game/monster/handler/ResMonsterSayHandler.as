package com.game.monster.handler
{
    import com.game.monster.control.*;
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterSayHandler extends Handler
    {

        public function ResMonsterSayHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterSayMessage(this.message);
            MonsterControl.getInstance().resMonsterSayHandler(_loc_1);
            return;
        }// end function

    }
}
