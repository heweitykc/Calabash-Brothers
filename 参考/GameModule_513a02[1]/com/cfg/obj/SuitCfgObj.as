package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class SuitCfgObj extends Object
    {
        private var _map:Dictionary;
        private static var _instance:SuitCfgObj;

        public function SuitCfgObj()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._map = new Dictionary();
            var _loc_1:* = CfgManager.getInstance().getMap("q_suit");
            for (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = new SuitCfg();
                _loc_4.parse(_loc_3);
                this._map[_loc_4.q_id] = _loc_4;
            }
            return;
        }// end function

        public function getSuitById(param1:int) : SuitCfg
        {
            return this._map[param1];
        }// end function

        public static function get instance() : SuitCfgObj
        {
            if (_instance == null)
            {
                _instance = new SuitCfgObj;
            }
            return _instance;
        }// end function

    }
}
