package com.game.artifact.util
{
    import com.f1.*;

    public class ArtifactStringUtil extends Object
    {
        private static var numberChineseDict:Array = [LanguageCfgObj.getInstance().getByIndex("12308"), LanguageCfgObj.getInstance().getByIndex("12298"), LanguageCfgObj.getInstance().getByIndex("12299"), LanguageCfgObj.getInstance().getByIndex("12300"), LanguageCfgObj.getInstance().getByIndex("12301"), LanguageCfgObj.getInstance().getByIndex("12302"), LanguageCfgObj.getInstance().getByIndex("12303"), LanguageCfgObj.getInstance().getByIndex("12304"), LanguageCfgObj.getInstance().getByIndex("12305"), LanguageCfgObj.getInstance().getByIndex("12306"), LanguageCfgObj.getInstance().getByIndex("12307")];

        public function ArtifactStringUtil()
        {
            return;
        }// end function

        public static function getNumberChinese(param1:uint) : String
        {
            return numberChineseDict[param1];
        }// end function

        public static function getNumberString(param1:uint) : String
        {
            return param1.toString();
        }// end function

        public static function range(param1:uint, param2:uint, param3:String = "", param4:String = "", param5:Function = null) : Array
        {
            var first:* = param1;
            var last:* = param2;
            var prefix:* = param3;
            var suffix:* = param4;
            var numberConverter:* = param5;
            if (numberConverter == null)
            {
                numberConverter = getNumberString;
            }
            return multiFormat(first, last, function (param1:uint) : String
            {
                return prefix + numberConverter(param1) + suffix;
            }// end function
            );
        }// end function

        public static function multiFormat(param1:uint, param2:uint, param3:Function) : Array
        {
            var _loc_4:* = new Array();
            var _loc_5:* = param1;
            while (_loc_5 <= param2)
            {
                
                _loc_4.push(ArtifactStringUtil.param3(_loc_5));
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

    }
}
