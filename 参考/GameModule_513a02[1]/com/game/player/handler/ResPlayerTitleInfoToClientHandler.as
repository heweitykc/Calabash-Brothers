package com.game.player.handler
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.game.player.control.*;
    import com.game.player.message.*;
    import com.game.primaryrole.control.*;
    import com.model.*;
    import net.*;

    public class ResPlayerTitleInfoToClientHandler extends Handler
    {

        public function ResPlayerTitleInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = ResPlayerTitleInfoToClientMessage(message);
            if (_loc_1.isGetRes)
            {
                _loc_2 = TitleCfgObj.getInstance().getTitleById(_loc_1.titleid);
                MyTitleData.instance.updateTitle(_loc_1.titleid, _loc_2.q_effective_time);
                PrimaryRoleControl.getInstance().openTitlePanel(_loc_1.titleid);
            }
            else if (_loc_1.isWearRes)
            {
                MyTitleData.instance.topTitleId = _loc_1.titleid;
                PlayerControl.getInstance().updateTitle(null, _loc_1.titleid);
            }
            return;
        }// end function

    }
}
