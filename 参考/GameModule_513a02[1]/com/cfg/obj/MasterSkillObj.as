package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class MasterSkillObj extends Object
    {
        private var _map:Dictionary;
        private static var _instance:MasterSkillObj;

        public function MasterSkillObj()
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._map = new Dictionary();
            var _loc_1:* = CfgManager.getInstance().getMap("q_master_skill");
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new MasterSkillCfg();
                _loc_3.parse(_loc_2);
                this._map[_loc_3.q_id_level] = _loc_3;
            }
            return;
        }// end function

        public function getCfgMap() : Dictionary
        {
            return this._map;
        }// end function

        public function getInfoByIdAndLevel(param1:int, param2:int) : MasterSkillCfg
        {
            return this._map[param1 + "_" + param2];
        }// end function

        public static function get instance() : MasterSkillObj
        {
            if (_instance == null)
            {
                _instance = new MasterSkillObj;
            }
            return _instance;
        }// end function

    }
}
