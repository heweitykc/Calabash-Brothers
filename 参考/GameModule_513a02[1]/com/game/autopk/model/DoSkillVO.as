package com.game.autopk.model
{
    import com.model.vo.*;

    public class DoSkillVO extends Object
    {
        private var _info:SkillInfo;
        public var lastUseTime:int;
        public var isCallSkill:Boolean;
        public var isBuffSkill:Boolean;
        public var isGroupSkill:Boolean;
        public var isHelpBloodSkill:Boolean;
        public var isHelpBuffSkill:Boolean;
        public var isAddBlood:Boolean;
        public var isInactive:Boolean;

        public function DoSkillVO()
        {
            return;
        }// end function

        public function set info(param1:SkillInfo) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._info = param1;
            var _loc_2:* = this._info.q_auto_brief_skill_type.split(";");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = this._info.q_auto_brief_skill_type.substr(0, 3);
                _loc_5 = this._info.q_auto_brief_skill_type.substr(3, 3);
                if (!this.isCallSkill)
                {
                    this.isCallSkill = this._info.q_auto_brief_skill_type == "100003";
                }
                if (!this.isHelpBloodSkill)
                {
                    this.isHelpBloodSkill = this._info.q_auto_brief_skill_type == "300001";
                }
                if (!this.isHelpBuffSkill)
                {
                    this.isHelpBuffSkill = this._info.q_auto_brief_skill_type == "200001";
                }
                if (!this.isBuffSkill)
                {
                    this.isBuffSkill = _loc_4 == "200";
                }
                if (!this.isAddBlood)
                {
                    this.isAddBlood = _loc_4 == "300";
                }
                if (!this.isGroupSkill)
                {
                    this.isGroupSkill = _loc_4 == "400" && (_loc_5 == "004" || _loc_5 == "002");
                }
                if (!this.isInactive)
                {
                    this.isInactive = _loc_4 == "500";
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get info() : SkillInfo
        {
            return this._info;
        }// end function

    }
}
