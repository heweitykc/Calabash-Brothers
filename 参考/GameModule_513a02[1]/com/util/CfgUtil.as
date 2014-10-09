package com.util
{
    import com.f1.manager.*;
    import flash.utils.*;

    public class CfgUtil extends Object
    {

        public function CfgUtil()
        {
            return;
        }// end function

        public static function stringToInt(param1:String) : int
        {
            return int(param1);
        }// end function

        public static function stringToNumber(param1:String) : Number
        {
            return param1 == null ? (0) : (Number(param1));
        }// end function

        public static function stringToString(param1:String) : String
        {
            return param1;
        }// end function

        public static function parseArray(param1:String, param2:String, param3:Function = null) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            param1 = removeQuotationMark(param1);
            if (param3 == null)
            {
                param3 = stringToString;
            }
            var _loc_4:* = new Array();
            if (param1 != null && param1.length > 0)
            {
                _loc_5 = param1.split(param2);
                for each (_loc_6 in _loc_5)
                {
                    
                    _loc_4.push(CfgUtil.param3(_loc_6));
                }
            }
            return _loc_4;
        }// end function

        public static function putInDict(param1:Dictionary, param2, param3) : void
        {
            param1[param2] = param3;
            return;
        }// end function

        public static function putInDictWithMultiKeys(param1:Dictionary, param2, param3) : void
        {
            var _loc_4:* = undefined;
            for each (_loc_4 in param2)
            {
                
                param1[_loc_4] = param3;
            }
            return;
        }// end function

        public static function parseDict(param1:String, param2:String, param3:String, param4:Function = null, param5:Function = null, param6:Function = null) : Dictionary
        {
            var str:* = param1;
            var entrySep:* = param2;
            var keyValueSep:* = param3;
            var keyParser:* = param4;
            var valueParser:* = param5;
            var dictPutter:* = param6;
            if (keyParser == null)
            {
                keyParser = stringToString;
            }
            if (valueParser == null)
            {
                valueParser = stringToString;
            }
            return parseSpecialDict(str, entrySep, function (param1:String) : Array
            {
                var _loc_2:* = param1.split(keyValueSep);
                _loc_2[0] = keyParser(_loc_2[0]);
                _loc_2[1] = valueParser(_loc_2.length > 2 ? (_loc_2.slice(1)) : (_loc_2[1]));
                return _loc_2;
            }// end function
            , dictPutter);
        }// end function

        public static function parseSpecialDict(param1:String, param2:String, param3:Function, param4:Function = null) : Dictionary
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            param1 = removeQuotationMark(param1);
            if (param4 == null)
            {
                param4 = putInDict;
            }
            var _loc_5:* = new Dictionary();
            if (param1 != null && param1.length > 0)
            {
                _loc_6 = param1.split(param2);
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_8 = CfgUtil.param3(_loc_7);
                    _loc_9 = _loc_8[0];
                    _loc_10 = _loc_8[1];
                    CfgUtil.param4(_loc_5, _loc_9, _loc_10);
                }
            }
            return _loc_5;
        }// end function

        public static function parseNestedDict(param1:String, param2:String, param3:String, param4:Function = null, param5:Function = null, param6:Function = null) : Dictionary
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = null;
            param1 = removeQuotationMark(param1);
            if (param4 == null)
            {
                param4 = stringToString;
            }
            if (param5 == null)
            {
                param5 = stringToString;
            }
            if (param6 == null)
            {
                param6 = stringToString;
            }
            var _loc_7:* = new Dictionary();
            if (param1 != null && param1.length > 0)
            {
                _loc_8 = param1.split(param2);
                for each (_loc_9 in _loc_8)
                {
                    
                    _loc_10 = _loc_9.split(param3);
                    _loc_11 = CfgUtil.param4(_loc_10[0]);
                    _loc_12 = CfgUtil.param5(_loc_10[1]);
                    _loc_13 = CfgUtil.param6(_loc_10.length > 3 ? (_loc_10.slice(2)) : (_loc_10[2]));
                    _loc_14 = _loc_7[_loc_11];
                    if (_loc_14 == null)
                    {
                        var _loc_17:* = new Dictionary();
                        _loc_14 = new Dictionary();
                        _loc_7[_loc_11] = _loc_17;
                    }
                    _loc_14[_loc_12] = _loc_13;
                }
            }
            return _loc_7;
        }// end function

        public static function removeQuotationMark(param1:String) : String
        {
            return removeWrapper(param1, "\"", "\"", false);
        }// end function

        public static function removeWrapper(param1:String, param2:String, param3:String, param4:Boolean = true) : String
        {
            if (param4)
            {
                param1 = removeQuotationMark(param1);
            }
            if (param1 != null && param1.length > 2 && param1.charAt(0) == param2 && param1.charAt((param1.length - 1)) == param3)
            {
                return param1.substring(1, (param1.length - 1));
            }
            return param1;
        }// end function

        public static function getAndConvertMap(param1:String, param2:Class) : Object
        {
            var _loc_4:* = undefined;
            var _loc_3:* = CfgManager.getInstance().getMap(param1);
            if (_loc_3 == null)
            {
                _loc_3 = new Object();
            }
            for (_loc_4 in _loc_3)
            {
                
                _loc_3[_loc_4] = new param2(_loc_3[_loc_4]);
            }
            return _loc_3;
        }// end function

    }
}
