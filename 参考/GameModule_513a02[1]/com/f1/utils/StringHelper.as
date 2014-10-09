package com.f1.utils
{
    import flash.utils.*;

    public class StringHelper extends Object
    {
        static const hexChars:String = "0123456789ABCDEF";
        static const spaceChars:String = " \t\r\n";

        public function StringHelper()
        {
            return;
        }// end function

        public static function getTimeFormat(param1:uint) : String
        {
            var _loc_2:* = uint(param1 / 3600);
            var _loc_3:* = uint(param1 % 3600 / 60);
            var _loc_4:* = uint(param1 % 60);
            return (_loc_2 < 10 ? ("0" + _loc_2) : (_loc_2)) + " : " + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3)) + " : " + (_loc_4 < 10 ? ("0" + _loc_4) : (_loc_4));
        }// end function

        public static function getTimeFormatHS(param1:uint) : String
        {
            var _loc_2:* = uint(param1 % 3600 / 60);
            var _loc_3:* = uint(param1 % 60);
            return (_loc_2 < 10 ? ("0" + _loc_2) : (_loc_2)) + ":" + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3));
        }// end function

        public static function byte2hexstr(param1:uint) : String
        {
            var _loc_2:* = "";
            _loc_2 = _loc_2 + hexChars.charAt(param1 >> 4 & 15);
            _loc_2 = _loc_2 + hexChars.charAt(param1 & 15);
            return _loc_2;
        }// end function

        public static function short2hexstr(param1:int, param2:Boolean = false) : String
        {
            var _loc_3:* = "";
            if (param2)
            {
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 12 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 8 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 4 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 & 15);
            }
            else
            {
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 4 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 12 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 8 & 15);
            }
            return _loc_3;
        }// end function

        public static function int2hexstr(param1:int, param2:Boolean = false) : String
        {
            var _loc_3:* = "";
            if (param2)
            {
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 28 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 24 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 20 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 16 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 12 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 8 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 4 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 & 15);
            }
            else
            {
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 4 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 12 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 8 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 20 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 16 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 28 & 15);
                _loc_3 = _loc_3 + hexChars.charAt(param1 >> 24 & 15);
            }
            return _loc_3;
        }// end function

        public static function buf2hexstr(param1:ByteArray, param2:uint = 0, param3:uint = 0, param4:Boolean = true, param5:Boolean = true) : String
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_6:* = "";
            if (param1 != null && param1.length > 0 && param2 + param3 <= param1.length)
            {
                _loc_7 = param2;
                _loc_8 = param3 > 0 ? (param2 + param3) : (param1.length);
                _loc_9 = 0;
                if (param4)
                {
                    _loc_9 = _loc_7;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_6 = _loc_6 + StringHelper.byte2hexstr(param1[_loc_9]);
                        _loc_6 = _loc_6 + (_loc_9 % 16 == 15 ? ("\n") : (" "));
                        _loc_9++;
                    }
                }
                else
                {
                    _loc_9 = _loc_7;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_6 = _loc_6 + StringHelper.byte2hexstr(param1[_loc_9]);
                        _loc_9++;
                    }
                }
                if (!param5)
                {
                    _loc_6 = _loc_6.toLowerCase();
                }
            }
            return _loc_6;
        }// end function

        public static function hexstr2buf(param1:String) : ByteArray
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 != null && param1.length > 0)
            {
                _loc_2 = param1.toUpperCase();
                _loc_3 = new ByteArray();
                _loc_4 = _loc_2.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (spaceChars.indexOf(_loc_2.charAt(_loc_5)) >= 0)
                    {
                        _loc_5++;
                        continue;
                    }
                    if (_loc_5 == (_loc_4 - 1))
                    {
                        return null;
                    }
                    _loc_6 = hexChars.indexOf(_loc_2.charAt(_loc_5));
                    _loc_7 = hexChars.indexOf(_loc_2.charAt((_loc_5 + 1)));
                    if (_loc_6 >= 0 && _loc_7 >= 0)
                    {
                        _loc_3.writeByte((_loc_6 << 4) + _loc_7);
                        _loc_5 = _loc_5 + 2;
                        continue;
                    }
                    return null;
                }
                _loc_3.position = 0;
                return _loc_3;
            }
            return null;
        }// end function

        public static function getColorText(param1:String, param2:uint) : String
        {
            return "<font color=\"#" + param2.toString(16) + "\">" + param1 + "</font>";
        }// end function

        public static function getBoldText(param1:String) : String
        {
            return "<b>" + param1 + "</b>";
        }// end function

        public static function getUnderlineText(param1:String) : String
        {
            return "<u>" + param1 + "</u>";
        }// end function

        public static function getHttpLinkText(param1:String, param2:String) : String
        {
            return "<a href=\"" + param2 + "\">" + param1 + "</a>";
        }// end function

        public static function getEventLinkText(param1:String, param2:String) : String
        {
            return "<a href=\"event:" + param2 + "\">" + param1 + "</a>";
        }// end function

        public static function getDetailHttpLinkText(param1:String, param2:String, param3:uint, param4:Boolean) : String
        {
            var _loc_5:* = getColorText(getHttpLinkText(param1, param2), param3);
            if (param4)
            {
                _loc_5 = getUnderlineText(_loc_5);
            }
            return _loc_5;
        }// end function

        public static function getDetailEventLinkText(param1:String, param2:String, param3:uint, param4:Boolean) : String
        {
            var _loc_5:* = getColorText(getEventLinkText(param1, param2), param3);
            if (param4)
            {
                _loc_5 = getUnderlineText(_loc_5);
            }
            return _loc_5;
        }// end function

    }
}
