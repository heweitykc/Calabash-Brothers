package com.game.casting.handler
{
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import net.*;

    public class ResCastingRewardToClientHandler extends Handler
    {

        public function ResCastingRewardToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingRewardToClientMessage(this.message);
            ZhuZaoControl.getInstance().gridInfos[_loc_1.itemInfo.grididx] = _loc_1.itemInfo;
            ZhuZaoControl.getInstance().showZhuZhao(_loc_1.itemInfo);
            super.action();
            return;
        }// end function

    }
}
