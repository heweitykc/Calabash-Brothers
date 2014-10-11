package com.cfg.obj
{
    import flash.utils.*;

    public class ProtectCfgObj extends Object
    {
        private var _map:Dictionary;
        private static var _instance:ProtectCfgObj;

        public function ProtectCfgObj()
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this._map = new Dictionary();
            var _loc_1:* = [228, 229, 230];
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = GlobalCfgObj.getInstance().getCfgById(_loc_1[_loc_3]);
                _loc_5 = _loc_4.q_int_value;
                _loc_6 = _loc_4.q_string_value;
                _loc_6 = _loc_6.replace(/\"/g, "");
                _loc_7 = _loc_6.split(";");
                _loc_8 = _loc_7.length;
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    this._map[int(_loc_7[_loc_9])] = _loc_5;
                    _loc_9++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function getRealKey(param1:int) : int
        {
            return this._map[param1];
        }// end function

        public static function get instance() : ProtectCfgObj
        {
            if (_instance == null)
            {
                _instance = new ProtectCfgObj;
            }
            return _instance;
        }// end function

    }
}
