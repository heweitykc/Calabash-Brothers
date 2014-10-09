package com.game.role.util
{
    import com.f1.*;
    import com.staticdata.*;

    public class RoleLevelUtil extends Object
    {

        public function RoleLevelUtil()
        {
            return;
        }// end function

        public static function getMasterLevel(param1:int, param2:String = null) : String
        {
            var _loc_3:* = null;
            if (param1 <= Params.ROLE_MAX_LEVEL)
            {
                if (param2)
                {
                    _loc_3 = param2 + param1;
                }
                else
                {
                    _loc_3 = param1.toString();
                }
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("12455") + (param1 - Params.ROLE_MAX_LEVEL);
            }
            return _loc_3;
        }// end function

        public static function getMasterLv(param1:int) : int
        {
            return param1 - Params.ROLE_MAX_LEVEL;
        }// end function

        public static function isMasterLevel(param1:int) : Boolean
        {
            if (param1 > Params.ROLE_MAX_LEVEL)
            {
                return true;
            }
            return false;
        }// end function

    }
}
