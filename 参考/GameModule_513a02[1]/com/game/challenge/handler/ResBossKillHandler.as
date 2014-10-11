package com.game.challenge.handler
{
    import com.game.challenge.control.*;
    import com.game.challenge.message.*;
    import net.*;

    public class ResBossKillHandler extends Handler
    {

        public function ResBossKillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBossKillMessage(this.message);
            BossGuideControl.getInstance().bossInfo.setBossHitInfo(_loc_1);
            super.action();
            return;
        }// end function

    }
}
