package com.game.skill.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.autopk.*;
    import com.game.guide.control.*;
    import com.game.lostskills.message.*;
    import com.game.skill.bean.*;
    import com.game.skill.message.*;
    import com.game.skill.model.*;
    import com.game.skill.protocol.*;
    import com.game.skill.view.*;
    import com.model.*;
    import com.model.vo.*;

    public class SkillControl extends Object
    {
        private var _protocal:SkillProtocal;
        private var _skillPanel:SkillPanel;
        private static var instance:SkillControl;
        public static const SKILL_NORMAL_SKILL_ID:Array = [10001, 10011, 10020];

        public function SkillControl()
        {
            this._protocal = new SkillProtocal();
            return;
        }// end function

        public function openSkillPanel() : void
        {
            if (!this._skillPanel)
            {
                this._skillPanel = new SkillPanel();
                Global.popManager.addPop(this._skillPanel);
            }
            this._skillPanel.openOrClose();
            return;
        }// end function

        public function openToTabSkill(param1:int) : void
        {
            this.openSkillPanel();
            this._skillPanel.openToTabSkill(param1);
            return;
        }// end function

        public function getNormalSkillIdByJob(param1:int) : int
        {
            return SKILL_NORMAL_SKILL_ID[(param1 - 1) % 3 + 1 - 1];
        }// end function

        public function skillInfosHandler(param1:SkillInfosMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1.defaultSkill == 0 && param1.skills.length > 0)
            {
                UserObj.getInstance().playerInfo.defaultSkillId = param1.skills[0].skillModelId;
            }
            else
            {
                UserObj.getInstance().playerInfo.defaultSkillId = param1.defaultSkill;
            }
            var _loc_2:* = new Vector.<SkillInfo>;
            for each (_loc_4 in param1.skills)
            {
                
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(_loc_4.skillModelId);
                if (_loc_3)
                {
                    _loc_3.skillLevel = _loc_4.skillLevel;
                    _loc_3.skillId = _loc_4.skillId;
                    _loc_3.skillLevel = _loc_4.skillLevel;
                    if (_loc_4.skillCDTime > -1)
                    {
                        _loc_3.q_cd = _loc_4.skillCDTime;
                    }
                    _loc_2.push(_loc_3);
                }
            }
            UserObj.getInstance().playerInfo.skillList = _loc_2;
            return;
        }// end function

        public function addSkillHandler(param1:SkillAddMessage) : void
        {
            Log.log("addSkillHandler", param1.skill.skillId);
            return;
        }// end function

        public function skillAddHandler(param1:SkillAddMessage) : void
        {
            var _loc_2:* = param1.skill;
            var _loc_3:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_2.skillModelId);
            if (_loc_3)
            {
                _loc_3.skillLevel = _loc_2.skillLevel;
                _loc_3.skillId = _loc_2.skillId;
                _loc_3.skillLevel = _loc_2.skillLevel;
                UserObj.getInstance().playerInfo.skillList.push(_loc_3);
                SkillGuideControl.getInstance().beginAddSkillGuide(_loc_3);
                AutoFightManager.getInstance().fightLogic.reset();
            }
            return;
        }// end function

        public function skillRemoveHandle(param1:SkillRemoveMessage) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.skillList;
            var _loc_3:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = _loc_2[_loc_5];
                if (_loc_4.q_skillID == param1.skillModelId)
                {
                    _loc_2.splice(_loc_5, 1);
                    return;
                }
                _loc_5++;
            }
            return;
        }// end function

        public function skillStartLevelUpHandler(param1:SkillStartLevelUpMessage) : void
        {
            return;
        }// end function

        public function reqSyncPlayerSkillHandle(param1:ReqSyncPlayerSkillMessage) : void
        {
            return;
        }// end function

        public function studySkillMessage(param1:StudySkillMessage) : void
        {
            return;
        }// end function

        public function nowLearnSkillHandler(param1:NowLeranSkillMessage) : void
        {
            return;
        }// end function

        private function levelUpSkill() : void
        {
            this._protocal.levelUpSkill();
            return;
        }// end function

        private function nowLearnSkillQuery() : void
        {
            this._protocal.nowLearnSkillQuery();
            return;
        }// end function

        private function reqCompleteMoment() : void
        {
            this._protocal.reqCompleteMoment();
            return;
        }// end function

        public function setDefaultSkill(param1:int) : void
        {
            this._protocal.setDefaultSkill(param1);
            return;
        }// end function

        private function studySkill() : void
        {
            this._protocal.studySkill();
            return;
        }// end function

        public function resLostSkillInfos(param1:ResLostSkillInfosMessage) : void
        {
            SkillModel.getInstance().vecLostSkillInfo = param1.skillInfos;
            if (this._skillPanel)
            {
                this._skillPanel.updateLostInfo();
            }
            return;
        }// end function

        public function resActivateLostSkill(param1:ResActivateLostSkillMessage) : void
        {
            if (this._skillPanel)
            {
                this._skillPanel.freshLostSkillInfo(param1.skillId, param1.skillLv, param1.skillType);
            }
            return;
        }// end function

        public function reqLostSkillInfos() : void
        {
            this._protocal.lostSkillInfos();
            return;
        }// end function

        public function reqActivateLostSkill(param1:uint) : void
        {
            this._protocal.activateLostSkill(param1);
            return;
        }// end function

        public function setRedFortressfurk() : void
        {
            return;
        }// end function

        public function reSetRedFortressfurk() : void
        {
            return;
        }// end function

        public static function getInstance() : SkillControl
        {
            if (instance == null)
            {
                instance = new SkillControl;
            }
            return instance;
        }// end function

    }
}
