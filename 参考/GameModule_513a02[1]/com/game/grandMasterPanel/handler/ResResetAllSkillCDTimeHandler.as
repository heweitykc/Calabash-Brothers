package com.game.grandMasterPanel.handler
{
    import __AS3__.vec.*;
    import com.game.fight.control.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.masterskill.message.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResResetAllSkillCDTimeHandler extends Handler
    {

        public function ResResetAllSkillCDTimeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = ResResetAllSkillCDTime(message);
            FightControl.getInstance().resetAllSkill(0);
            var _loc_2:* = UserObj.getInstance().playerInfo.skillList;
            var _loc_3:* = _loc_2 ? (_loc_2.length) : (0);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                if (_loc_5)
                {
                    MasterSkillControl.instance.showSkillUpdateEffect(_loc_5.q_skillID);
                }
                _loc_4++;
            }
            return;
        }// end function

    }
}
