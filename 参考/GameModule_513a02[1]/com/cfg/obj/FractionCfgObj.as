package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class FractionCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:FractionCfgObj;

        public function FractionCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("fraction");
            return;
        }// end function

        public function getFractionList() : Vector.<Fraction>
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Vector.<Fraction>;
            for each (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3.fraction_positon);
                if (_loc_2 != 0)
                {
                    _loc_4 = new Fraction();
                    _loc_4.parse(_loc_3);
                    _loc_1.push(_loc_4);
                }
            }
            _loc_1.sort(this.sortIntegers);
            return _loc_1;
        }// end function

        private function sortIntegers(param1:Fraction, param2:Fraction) : Number
        {
            if (param1.fraction_positon < param2.fraction_positon)
            {
                return -1;
            }
            if (param1.fraction_positon > param2.fraction_positon)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function getInstance() : FractionCfgObj
        {
            if (!_instance)
            {
                _instance = new FractionCfgObj;
            }
            return _instance;
        }// end function

    }
}
