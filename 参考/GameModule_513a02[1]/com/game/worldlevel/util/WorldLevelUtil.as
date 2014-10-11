package com.game.worldlevel.util
{

    public class WorldLevelUtil extends Object
    {

        public function WorldLevelUtil()
        {
            return;
        }// end function

        public static function getDateYYYYMMDDHHSS(param1:Date) : String
        {
            return fixedLengthNumber(param1.fullYear, 4) + "-" + fixedLengthNumber((param1.month + 1), 2) + "-" + fixedLengthNumber(param1.date, 2) + " " + fixedLengthNumber(param1.hours, 2) + ":" + fixedLengthNumber(param1.minutes, 2);
        }// end function

        public static function fixedLengthNumber(param1:uint, param2:uint) : String
        {
            var _loc_3:* = param1.toString();
            while (_loc_3.length < param2)
            {
                
                _loc_3 = "0" + _loc_3;
            }
            return _loc_3;
        }// end function

    }
}
