package com.game.monster.handler
{
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterMaxSpChangeHandler extends Handler
    {

        public function ResMonsterMaxSpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterMaxSpChangeMessage(this.message);
            return;
        }// end function

    }
}
