package com.game.grandMasterPanel.handler
{
    import com.game.masterskill.bean.*;
    import com.game.masterskill.message.*;
    import com.model.*;
    import net.*;

    public class ResMasterSkillInfosHandler extends Handler
    {

        public function ResMasterSkillInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = ResMasterSkillInfosMessage(message);
            MasterSkillData.instance.attackTreePoint = _loc_1.attackTreePoint;
            MasterSkillData.instance.defenseTreePoint = _loc_1.defenseTreePoint;
            MasterSkillData.instance.treatTreePoint = _loc_1.treatTreePoint;
            MasterSkillData.instance.masterSkillPoint = _loc_1.masterSkillPoint;
            var _loc_2:* = _loc_1.masterSkills.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = _loc_1.masterSkills[_loc_4];
                MasterSkillData.instance.updateSkill(_loc_3.skillID, _loc_3.level);
                _loc_4++;
            }
            MasterSkillData.instance.fireChangeEvent();
            return;
        }// end function

    }
}
