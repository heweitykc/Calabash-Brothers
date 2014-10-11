package com.game.monster.handler
{
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterSpChangeHandler extends Handler
    {

        public function ResMonsterSpChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterSpChangeMessage(this.message);
            return;
        }// end function

    }
}
