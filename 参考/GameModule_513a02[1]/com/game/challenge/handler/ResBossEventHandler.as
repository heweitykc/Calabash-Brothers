package com.game.challenge.handler
{
    import com.game.challenge.control.*;
    import com.game.challenge.message.*;
    import net.*;

    public class ResBossEventHandler extends Handler
    {

        public function ResBossEventHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBossEventMessage(this.message);
            BossGuideControl.getInstance().bossInfo.setInfo(_loc_1);
            super.action();
            return;
        }// end function

    }
}
