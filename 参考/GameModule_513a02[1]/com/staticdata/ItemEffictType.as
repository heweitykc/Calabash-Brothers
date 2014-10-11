package com.staticdata
{
    import com.f1.*;

    public class ItemEffictType extends Object
    {
        public static const MAGICBOOK_ATTACK_MIN:String = "3001";
        public static const MAGICBOOK_ATTACK_MAX:String = "3002";
        public static const MAGICBOOK_ATTACK_SPEED:String = "3003";
        public static const MAGICBOOK_ATTACK_SUCCESS:String = "3004";
        public static const MAGICBOOK_HEAT_DEEP:String = "3005";
        public static const MAGICBOOK_INORGE_INFENCE:String = "3006";

        public function ItemEffictType()
        {
            return;
        }// end function

        public static function getTypeString(param1:String) : String
        {
            var _loc_2:* = /\[.*?\]/gims;
            var _loc_3:* = _loc_2.exec(param1)[0];
            _loc_3 = _loc_3.substr(1, _loc_3.length - 2);
            _loc_3.split(",");
            return LanguageCfgObj.getInstance().getByIndex(_loc_3.split(",")[0], "lang_magicBook");
        }// end function

    }
}
