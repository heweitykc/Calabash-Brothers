package com.model
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.utils.*;

    public class MasterSkillData extends BaseEventDispatcher
    {
        private var _skillPool:Dictionary;
        private var _skillReplacePool:Dictionary;
        private var _skillEffectPool:Dictionary;
        private var _systemTotalCounts:Array;
        private var _attackTreePoint:int;
        private var _defenseTreePoint:int;
        private var _treatTreePoint:int;
        private var _masterSkillPoint:int;
        private static var _inited:Boolean = false;
        private static var _instance:MasterSkillData;

        public function MasterSkillData()
        {
            this._skillPool = new Dictionary();
            this._skillReplacePool = new Dictionary();
            this._skillEffectPool = new Dictionary();
            this._systemTotalCounts = [];
            return;
        }// end function

        private function initMasterSkillVO() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            if (_loc_1 <= Params.ROLE_MAX_LEVEL)
            {
                return;
            }
            _inited = true;
            var _loc_2:* = UserObj.getInstance().playerInfo.job;
            var _loc_3:* = MasterSkillObj.instance.getCfgMap();
            for each (_loc_4 in _loc_3)
            {
                
                if (PropUtil.canUseByJob(_loc_4.q_job, _loc_2) && _loc_4.q_level == 1)
                {
                    _loc_5 = new MasterSkillVO();
                    _loc_5.setSkill(_loc_4.q_id, 0);
                    this._skillPool[_loc_5.skillId] = _loc_5;
                    if (_loc_5.cfg.q_skill_replace && _loc_5.cfg.q_icon_replace)
                    {
                        _loc_6 = this._skillReplacePool[_loc_5.cfg.q_skill_replace];
                        if (_loc_6)
                        {
                            _loc_6.push(_loc_5);
                        }
                        else
                        {
                            this._skillReplacePool[_loc_5.cfg.q_skill_replace] = [_loc_5];
                        }
                    }
                    if (_loc_5.cfg.q_skill_replace)
                    {
                        _loc_6 = this._skillEffectPool[_loc_5.cfg.q_skill_replace];
                        if (_loc_6)
                        {
                            _loc_6.push(_loc_5);
                            continue;
                        }
                        this._skillEffectPool[_loc_5.cfg.q_skill_replace] = [_loc_5];
                    }
                }
            }
            return;
        }// end function

        public function get skillPool() : Dictionary
        {
            return this._skillPool;
        }// end function

        public function getSkillById(param1:int) : MasterSkillVO
        {
            return this._skillPool[param1];
        }// end function

        public function getMasterSkillBySkillId(param1:int) : Array
        {
            return this._skillReplacePool[param1];
        }// end function

        public function getMasterSkillEffectBySkillId(param1:int) : Array
        {
            return this._skillEffectPool[param1];
        }// end function

        public function updateSkill(param1:int, param2:int) : MasterSkillVO
        {
            var _loc_4:* = null;
            var _loc_3:* = this._skillPool[param1];
            if (_loc_3)
            {
                this.updateSystemTotalCount(_loc_3.cfg.q_type, _loc_3.level, param2);
                _loc_3.setSkill(param1, param2);
                if (_loc_3.cfg && _loc_3.cfg.q_skill_replace)
                {
                    _loc_4 = SkillCfgObj.getInstance().getSkillInfoById(_loc_3.cfg.q_skill_replace);
                    if (_loc_4)
                    {
                        _loc_4.updateEffect();
                    }
                }
            }
            return _loc_3;
        }// end function

        public function getSystemTotalCount(param1:int) : int
        {
            return this._systemTotalCounts[param1];
        }// end function

        public function updateSystemTotalCount(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = this._systemTotalCounts[param1];
            _loc_4 = this._systemTotalCounts[param1] - param2;
            _loc_4 = _loc_4 + param3;
            this._systemTotalCounts[param1] = _loc_4;
            return _loc_4;
        }// end function

        public function fireChangeEvent() : void
        {
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get attackTreePoint() : int
        {
            return this._attackTreePoint;
        }// end function

        public function set attackTreePoint(param1:int) : void
        {
            this._attackTreePoint = param1;
            return;
        }// end function

        public function get defenseTreePoint() : int
        {
            return this._defenseTreePoint;
        }// end function

        public function set defenseTreePoint(param1:int) : void
        {
            this._defenseTreePoint = param1;
            return;
        }// end function

        public function get treatTreePoint() : int
        {
            return this._treatTreePoint;
        }// end function

        public function set treatTreePoint(param1:int) : void
        {
            this._treatTreePoint = param1;
            return;
        }// end function

        public function get masterSkillPoint() : int
        {
            return this._masterSkillPoint;
        }// end function

        public function set masterSkillPoint(param1:int) : void
        {
            this._masterSkillPoint = param1;
            return;
        }// end function

        public function resetAll() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._systemTotalCounts.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._systemTotalCounts[_loc_2] = 0;
                _loc_2++;
            }
            this._attackTreePoint = 0;
            this._defenseTreePoint = 0;
            this._treatTreePoint = 0;
            for each (_loc_3 in this._skillPool)
            {
                
                _loc_3.setSkill(_loc_3.skillId, 0);
            }
            return;
        }// end function

        public static function get instance() : MasterSkillData
        {
            if (_instance == null)
            {
                _instance = new MasterSkillData;
            }
            if (_inited == false)
            {
                _instance.initMasterSkillVO();
            }
            return _instance;
        }// end function

    }
}
