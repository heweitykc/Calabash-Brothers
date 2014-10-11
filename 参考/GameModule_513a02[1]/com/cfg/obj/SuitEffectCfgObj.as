package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class SuitEffectCfgObj extends Object
    {
        private var _pool:Dictionary;
        private static var _instance:SuitEffectCfgObj;

        public function SuitEffectCfgObj()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._pool = new Dictionary();
            var _loc_1:* = CfgManager.getInstance().getMap("q_suit_effect");
            for (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = new SuitEffectCfg();
                _loc_4.parse(_loc_3);
                this._pool[_loc_4.q_id] = _loc_4;
            }
            return;
        }// end function

        public function getSuitEffectCfg(param1:int) : SuitEffectCfg
        {
            return this._pool[param1];
        }// end function

        public function getSuitEffectByCount(param1:int, param2:int) : SuitEffectCfg
        {
            var _loc_4:* = null;
            var _loc_3:* = param1 + "_" + param2;
            for each (_loc_4 in this._pool)
            {
                
                if (_loc_4.q_condition == _loc_3)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public static function get instance() : SuitEffectCfgObj
        {
            if (_instance == null)
            {
                _instance = new SuitEffectCfgObj;
            }
            return _instance;
        }// end function

    }
}
