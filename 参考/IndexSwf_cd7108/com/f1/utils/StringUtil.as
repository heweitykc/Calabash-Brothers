package com.f1.utils
{

    public class StringUtil extends Object
    {

        public function StringUtil()
        {
            throw new Error("StringUtil class is static container only");
        }// end function

        public static function languageReplace(param1:String, param2:Array = null) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = param1;
            if (param2 && param2.length)
            {
                _loc_4 = 0;
                _loc_7 = param2.length;
                while (_loc_4 < _loc_7)
                {
                    
                    _loc_6 = "#" + _loc_4 + "#";
                    _loc_5 = _loc_3.indexOf(_loc_6);
                    while (_loc_5 != -1)
                    {
                        
                        _loc_3 = _loc_3.replace(_loc_6, param2[_loc_4]);
                        _loc_5 = _loc_3.indexOf(_loc_6);
                    }
                    _loc_4++;
                }
            }
            return _loc_3;
        }// end function

        public static function searchs(param1:String, param2:String) : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = [];
            _loc_3 = param1.indexOf(param2);
            var _loc_5:* = param1.length;
            var _loc_6:* = -1;
            while (_loc_3 < (_loc_5 - 1) && _loc_3 != -1)
            {
                
                trace(_loc_3);
                _loc_4.push(_loc_3);
                param1 = param1.substring((_loc_3 + 1), param1.length);
                _loc_3 = param1.indexOf(param2);
            }
            var _loc_7:* = 1;
            while (_loc_7 < _loc_4.length)
            {
                
                _loc_4[_loc_7] = _loc_4[_loc_7] + _loc_4[(_loc_7 - 1)] + 1;
                _loc_7++;
            }
            if (_loc_4.length != 0)
            {
                return _loc_4;
            }
            return null;
        }// end function

        public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
        {
            return param1.toLowerCase() == param2.toLowerCase();
        }// end function

        public static function equals(param1:String, param2:String) : Boolean
        {
            return param1 == param2;
        }// end function

        public static function isEmail(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isDouble(param1:String) : Boolean
        {
            param1 = trim(param1);
            var _loc_2:* = /^[-\+]?\d+(\.\d+)?$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isInteger(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /^[-\+]?\d+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isEnglish(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /^[A-Za-z]+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isChinese(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /^[Α-￥]+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isDoubleChar(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /^[^\x00-\xff]+$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function hasChineseChar(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1);
            var _loc_2:* = /[^\x00-\xff]/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function hasAccountChar(param1:String, param2:uint = 15) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            if (param2 < 10)
            {
                param2 = 15;
            }
            param1 = trim(param1);
            var _loc_3:* = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + param2 + "}$", "");
            var _loc_4:* = _loc_3.exec(param1);
            if (_loc_3.exec(param1) == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isURL(param1:String) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            param1 = trim(param1).toLowerCase();
            var _loc_2:* = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        public static function isWhitespace(param1:String) : Boolean
        {
            switch(param1)
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                {
                    return true;
                }
                default:
                {
                    return false;
                    break;
                }
            }
        }// end function

        public static function trim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            return rtrim(ltrim(param1));
        }// end function

        public static function ltrim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_2:* = /^\s*/;
            return param1.replace(_loc_2, "");
        }// end function

        public static function rtrim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_2:* = /\s*$/;
            return param1.replace(_loc_2, "");
        }// end function

        public static function beginsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(0, param2.length);
        }// end function

        public static function endsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(param1.length - param2.length);
        }// end function

        public static function remove(param1:String, param2:String) : String
        {
            return replace(param1, param2, "");
        }// end function

        public static function replace(param1:String, param2:String, param3:String) : String
        {
            return param1.split(param2).join(param3);
        }// end function

        public static function utf16to8(param1:String) : String
        {
            var _loc_5:* = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.charCodeAt(_loc_4);
                if (_loc_5 >= 1 && _loc_5 <= 127)
                {
                    _loc_2[_loc_4] = param1.charAt(_loc_4);
                }
                else if (_loc_5 > 2047)
                {
                    _loc_2[_loc_4] = String.fromCharCode(224 | _loc_5 >> 12 & 15, 128 | _loc_5 >> 6 & 63, 128 | _loc_5 >> 0 & 63);
                }
                else
                {
                    _loc_2[_loc_4] = String.fromCharCode(192 | _loc_5 >> 6 & 31, 128 | _loc_5 >> 0 & 63);
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_2.join("");
        }// end function

        public static function utf8to16(param1:String) : String
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_7 = param1.charCodeAt(_loc_4++);
                switch(_loc_7 >> 4)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    {
                        _loc_2[_loc_2.length] = param1.charAt((_loc_4 - 1));
                        break;
                    }
                    case 12:
                    case 13:
                    {
                        _loc_5 = param1.charCodeAt(_loc_4++);
                        _loc_2[_loc_2.length] = String.fromCharCode((_loc_7 & 31) << 6 | _loc_5 & 63);
                        break;
                    }
                    case 14:
                    {
                        _loc_5 = param1.charCodeAt(_loc_4++);
                        _loc_6 = param1.charCodeAt(_loc_4++);
                        _loc_2[_loc_2.length] = String.fromCharCode((_loc_7 & 15) << 12 | (_loc_5 & 63) << 6 | (_loc_6 & 63) << 0);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_2.join("");
        }// end function

        public static function getLastString(param1:String, param2:uint) : String
        {
            return param1.substring(param1.length - param2, param1.length);
        }// end function

        public static function sliceNumber(param1:Number, param2:int = 2) : Number
        {
            param1 = param1 * (10 * param2);
            var _loc_3:* = int(param1);
            var _loc_4:* = _loc_3 / (10 * param2);
            return _loc_3 / (10 * param2);
        }// end function

        public static function clearJsonQuote(param1:String) : String
        {
            var _loc_2:* = param1.indexOf("\"");
            if (_loc_2 == 0)
            {
                param1 = param1.replace(/\"/, "");
            }
            _loc_2 = param1.lastIndexOf("\"");
            if (_loc_2 == (param1.length - 1))
            {
                param1 = param1.substr(0, _loc_2);
            }
            param1 = param1.replace(/\"\"/g, "\"");
            return param1;
        }// end function

        public static function decodeAttribute(param1:String) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = param1.indexOf("[");
            var _loc_4:* = param1.indexOf("]");
            param1 = param1.substring((_loc_3 + 1), _loc_4);
            var _loc_5:* = param1.split(",");
            var _loc_6:* = param1.split(",") ? (_loc_5.length) : (0);
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                param1 = _loc_5[_loc_7];
                _loc_2[_loc_7] = param1.split(":");
                _loc_7++;
            }
            return _loc_2;
        }// end function

        public static function formatString(param1:String, ... args) : String
        {
            args = 0;
            while (args < args.length)
            {
                
                param1 = param1.replace(new RegExp("\\{" + args + "\\}", "g"), args[args]);
                args++;
            }
            return param1;
        }// end function

    }
}
