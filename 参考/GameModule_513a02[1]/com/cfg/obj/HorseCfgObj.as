package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import com.model.vo.*;

    public class HorseCfgObj extends Object
    {
        private var _map:Object;
        public static var HORSE_UP_TOOLS_1:int = 100016;
        public static var HORSE_UP_TOOLS_2:int = 100015;
        public static var HORSE_UP_TOOLS_3:int = 100014;
        public static var HORSE_UP_TOOLS_4:int = 100013;
        public static var HORSE_UP_TOOLS_NORMAL:Object = 100012;
        private static var _instance:HorseCfgObj;

        public function HorseCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("horse");
            return;
        }// end function

        public function getInfoFromLevel(param1:int, param2:HorseInfo = null) : HorseInfo
        {
            param1 = param1 < 1 ? (1) : (param1);
            param1 = param1 > 72 ? (72) : (param1);
            if (!param2)
            {
                param2 = new HorseInfo();
            }
            if (param1 == param2.horse_level)
            {
                return param2;
            }
            var _loc_3:* = this._map[param1];
            if (_loc_3)
            {
                param2.parse(_loc_3);
                return param2;
            }
            return null;
        }// end function

        public function getInfoByStep(param1:uint) : HorseInfo
        {
            var _loc_2:* = param1 * 10;
            return this.getInfoFromLevel(_loc_2);
        }// end function

        public function getNestGradeInfoFromLevel(param1:int) : HorseInfo
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._map[param1].horse_step;
            for each (_loc_4 in this._map)
            {
                
                if (_loc_4 && _loc_4.horse_step > _loc_2)
                {
                    _loc_3 = new HorseInfo();
                    _loc_3.parse(_loc_4);
                    return _loc_3;
                }
            }
            if (_loc_4)
            {
                _loc_3 = new HorseInfo();
                _loc_3.parse(_loc_4);
                return _loc_3;
            }
            return null;
        }// end function

        public function getNestStepExp(param1:int, param2:int) : uint
        {
            var _loc_5:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = param1 + 1;
            while (_loc_4 <= param2)
            {
                
                _loc_5 = this._map[_loc_4];
                if (_loc_5)
                {
                    _loc_3 = _loc_3 + int(_loc_5.horse_exp);
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function getCombatValue(param1:HorseTableVo) : int
        {
            var _loc_2:* = NaN;
            _loc_2 = param1.horse_hp + (param1.horse_max_magicatk + param1.horse_min_magicatk) * 6 + param1.horse_defense * 12 + param1.horse_mp / 10 + 384 * 12 * (param1.horse_perfectatk_percent / 10000) + param1.horse_ignoredefense / 10000 * 9600;
            return int(Math.ceil(_loc_2));
        }// end function

        public static function getInstance() : HorseCfgObj
        {
            if (!_instance)
            {
                _instance = new HorseCfgObj;
            }
            return _instance;
        }// end function

    }
}
