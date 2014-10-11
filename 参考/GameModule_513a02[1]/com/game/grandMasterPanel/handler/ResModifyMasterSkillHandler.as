package com.game.grandMasterPanel.handler
{
    import com.cfg.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.guide.control.*;
    import com.game.masterskill.message.*;
    import com.game.operationpanel.control.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResModifyMasterSkillHandler extends Handler
    {

        public function ResModifyMasterSkillHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = ResModifyMasterSkillMessage(message);
            if (_loc_1.treeType == MasterSkillConst.ATK_SYSTEM)
            {
                MasterSkillData.instance.attackTreePoint = _loc_1.treePoint;
            }
            else if (_loc_1.treeType == MasterSkillConst.DEF_SYSTEM)
            {
                MasterSkillData.instance.defenseTreePoint = _loc_1.treePoint;
            }
            else if (_loc_1.treeType == MasterSkillConst.MED_SYSTEM)
            {
                MasterSkillData.instance.treatTreePoint = _loc_1.treePoint;
            }
            MasterSkillData.instance.masterSkillPoint = _loc_1.masterPoint;
            var _loc_2:* = MasterSkillData.instance.updateSkill(_loc_1.info.skillID, _loc_1.info.level);
            MasterSkillData.instance.fireChangeEvent();
            if (_loc_2 && _loc_2.level == 1)
            {
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(_loc_2.cfg.q_skill_replace, 1);
                if (_loc_3 && _loc_2.cfg.q_icon_replace)
                {
                    SkillGuideControl.getInstance().beginAddSkillGuide(_loc_3, StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("ResModifyMasterSkillHandler_1409106394", "lang_masterSkill"), _loc_3.q_skillName), this.updateSkillInfo, true);
                }
            }
            return;
        }// end function

        private function updateSkillInfo(param1:int) : void
        {
            OperationPanelControl.getInstance().freshShortCutView();
            return;
        }// end function

    }
}
