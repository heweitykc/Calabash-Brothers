package com.game.grandMasterPanel.handler
{
    import com.cfg.obj.*;
    import com.game.fight.control.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.masterskill.message.*;
    import com.model.vo.*;
    import net.*;

    public class ResModifySkillCDTimeHandler extends Handler
    {

        public function ResModifySkillCDTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResModifySkillCDTimeMessage(message);
            var _loc_2:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_1.skillId);
            if (_loc_1.type == 1)
            {
                _loc_2.q_cd = _loc_1.cdTime;
            }
            else if (_loc_1.type == 2)
            {
                FightControl.getInstance().setSkillCD(_loc_2, _loc_1.cdTime);
                MasterSkillControl.instance.showSkillUpdateEffect(_loc_1.skillId);
            }
            return;
        }// end function

    }
}
