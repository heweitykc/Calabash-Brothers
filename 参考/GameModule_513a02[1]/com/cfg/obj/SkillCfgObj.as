package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.f1.manager.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.utils.*;

    public class SkillCfgObj extends Object
    {
        private var _skillMap:Dictionary;
        private var _clientSkillDamageObj:Object;
        private var _skillpassivemap:Object;
        private var _sortTable:Object;
        private static var instance:SkillCfgObj;

        public function SkillCfgObj()
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._clientSkillDamageObj = CfgManager.getInstance().getMap("q_skill_ClientBean");
            this._sortTable = CfgManager.getInstance().getMap("q_battleskill");
            this._skillpassivemap = CfgManager.getInstance().getMap("q_lostskill");
            var _loc_1:* = CfgManager.getInstance().getMap("skill");
            this._skillMap = new Dictionary();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new SkillInfo();
                _loc_3.parse(_loc_2);
                this._skillMap[_loc_3.q_skillID_q_grade] = _loc_3;
            }
            return;
        }// end function

        public function getSkillInfoById(param1:uint, param2:uint = 1) : SkillInfo
        {
            return this._skillMap[param1 + "_" + param2];
        }// end function

        public function getSkillDamageObjById(param1:uint) : Object
        {
            return this._clientSkillDamageObj[param1];
        }// end function

        public function getSkillSortTable() : Object
        {
            return this._sortTable;
        }// end function

        public function getSkillListFroJob(param1:int) : Vector.<SkillInfo>
        {
            var _loc_3:* = null;
            var _loc_2:* = new Vector.<SkillInfo>;
            for each (_loc_3 in this._skillMap)
            {
                
                if (this.canUseByJobSkill(_loc_3, param1) && _loc_3.q_job)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function canUseByJobSkill(param1:SkillInfo, param2:Number) : Boolean
        {
            return PropUtil.canUseByJob(param1.q_job_client, param2);
        }// end function

        public function getskillLostInfo(param1:int) : Object
        {
            return this._skillpassivemap[param1];
        }// end function

        public static function getInstance() : SkillCfgObj
        {
            if (instance == null)
            {
                instance = new SkillCfgObj;
            }
            return instance;
        }// end function

    }
}
