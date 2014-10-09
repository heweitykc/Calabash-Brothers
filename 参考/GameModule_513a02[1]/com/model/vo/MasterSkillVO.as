package com.model.vo
{
    import com.cfg.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.staticdata.*;

    public class MasterSkillVO extends Object
    {
        public var skillId:int;
        public var level:int;
        private var _cfg:MasterSkillCfg;

        public function MasterSkillVO()
        {
            return;
        }// end function

        public function get cfg() : MasterSkillCfg
        {
            return this._cfg;
        }// end function

        public function setSkill(param1:int, param2:int) : void
        {
            this.skillId = param1;
            this.level = param2;
            this._cfg = MasterSkillObj.instance.getInfoByIdAndLevel(this.skillId, this.level < 1 ? (1) : (this.level));
            return;
        }// end function

        public function get isCanLevelUp() : Boolean
        {
            return this._cfg.q_max_level > this.level;
        }// end function

        public function get allowAddPoint() : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_1:* = MasterSkillObj.instance.getInfoByIdAndLevel(this.skillId, (this.level + 1));
            if (!_loc_1)
            {
                return false;
            }
            if (_loc_1.q_need_point > MasterSkillData.instance.getSystemTotalCount(_loc_1.q_type))
            {
                return false;
            }
            var _loc_2:* = _loc_1.q_depense.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1.q_depense[_loc_3];
                _loc_5 = _loc_4[0];
                _loc_6 = _loc_4[1];
                _loc_7 = MasterSkillData.instance.getSkillById(_loc_5);
                if (_loc_7.level < _loc_6)
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        public function get isOpened() : Boolean
        {
            return this.level > 0;
        }// end function

        public function get typeName() : String
        {
            var _loc_1:* = "";
            switch(this._cfg.q_type)
            {
                case MasterSkillConst.ATK_SYSTEM:
                {
                    _loc_1 = LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992268", "lang_masterSkill");
                    break;
                }
                case MasterSkillConst.DEF_SYSTEM:
                {
                    _loc_1 = LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992297", "lang_masterSkill");
                    break;
                }
                case MasterSkillConst.MED_SYSTEM:
                {
                    _loc_1 = LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992452", "lang_masterSkill");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function get conditionTips() : String
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_1:* = LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992465", "lang_masterSkill");
            var _loc_2:* = MasterSkillObj.instance.getInfoByIdAndLevel(this.skillId, (this.level + 1));
            if (_loc_2.q_need_point)
            {
                _loc_5 = 65280;
                if (_loc_2.q_need_point > MasterSkillData.instance.getSystemTotalCount(_loc_2.q_type))
                {
                    _loc_5 = 16711680;
                }
                _loc_1 = _loc_1 + StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992473", "lang_masterSkill"), _loc_5.toString(16), this.typeName, _loc_2.q_need_point);
            }
            var _loc_3:* = _loc_2.q_depense.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = _loc_2.q_depense[_loc_4];
                _loc_7 = _loc_6[0];
                _loc_8 = _loc_6[1];
                _loc_9 = MasterSkillData.instance.getSkillById(_loc_7);
                _loc_5 = 65280;
                if (_loc_9 && _loc_9.level < _loc_8)
                {
                    _loc_5 = 16711680;
                }
                if (_loc_9)
                {
                    _loc_1 = _loc_1 + StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992478", "lang_masterSkill"), _loc_5.toString(16), _loc_9.cfg.q_name, _loc_8);
                }
                _loc_4++;
            }
            _loc_5 = 65280;
            if (_loc_2.q_cost_point > MasterSkillData.instance.masterSkillPoint)
            {
                _loc_5 = 16711680;
            }
            _loc_1 = _loc_1 + StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("MasterSkillVO_1405992485", "lang_masterSkill"), _loc_5.toString(16), _loc_2.q_cost_point);
            return _loc_1;
        }// end function

        public function get url() : String
        {
            return Params.SKILL_ICON_PATH + this._cfg.q_icon + ".png";
        }// end function

    }
}
