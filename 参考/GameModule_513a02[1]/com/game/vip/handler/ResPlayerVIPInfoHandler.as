package com.game.vip.handler
{
    import com.game.guide.control.*;
    import com.game.player.control.*;
    import com.game.vip.bean.*;
    import com.game.vip.control.*;
    import com.game.vip.message.*;
    import net.*;

    public class ResPlayerVIPInfoHandler extends Handler
    {

        public function ResPlayerVIPInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerVIPInfoMessage(this.message);
            var _loc_2:* = VIPControl.getInstance().vipinfo;
            if (_loc_2 && _loc_2.stageLevel == 1 && _loc_1.vipinfo.stageLevel == 0)
            {
                VipGuideControl.getInstance().showGetVipView(1);
            }
            VIPControl.getInstance().vipinfo = _loc_1.vipinfo;
            PlayerControl.getInstance().updateVIPBuff();
            if (_loc_1.vipinfo.stageLevel == 1 && _loc_1.vipinfo.remain != 0)
            {
                VipGuideControl.getInstance().showVipCountDown();
            }
            else
            {
                VipGuideControl.getInstance().closeVipCount();
            }
            return;
        }// end function

    }
}
