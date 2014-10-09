package com.game.monster.handler
{
    import com.game.monster.message.*;
    import net.*;

    public class ResMonsterDoubleNoticeHandler extends Handler
    {

        public function ResMonsterDoubleNoticeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterDoubleNoticeMessage(this.message);
            return;
        }// end function

    }
}
