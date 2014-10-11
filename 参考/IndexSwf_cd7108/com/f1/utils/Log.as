package com.f1.utils
{
    import com.f1.*;
    import com.hexagonstar.util.debug.*;
    import flash.system.*;
    import flash.utils.*;

    public class Log extends Object
    {
        private static var _strAll:String = "";
        private static var LOG_MAX_LENGTH:uint = 320000;
        private static var lastIndex:int = 0;
        private static var hasOnlyLog:Boolean;
        private static var startTime:int;
        private static var startMem:int;
        private static var ZERO:String = "                                ";

        public function Log()
        {
            return;
        }// end function

        public static function get strAll() : String
        {
            return _strAll;
        }// end function

        public static function set strAll(param1:String) : void
        {
            _strAll = param1;
            return;
        }// end function

        public static function clear() : void
        {
            _strAll = "";
            return;
        }// end function

        private static function appendStr(param1:String) : String
        {
            var _loc_2:* = _strAll.length;
            if (_loc_2 > LOG_MAX_LENGTH)
            {
                _strAll = _strAll.substr(-LOG_MAX_LENGTH);
            }
            _strAll = _strAll + (param1 + "\r\n");
            return _strAll;
        }// end function

        public static function onlyLog(... args) : void
        {
            hasOnlyLog = false;
            log(args);
            hasOnlyLog = true;
            return;
        }// end function

        public static function log(... args) : void
        {
            var _loc_3:* = null;
            if (hasOnlyLog)
            {
                return;
            }
            args = ToolKit.getLogDate(new Date().time);
            for each (_loc_3 in args)
            {
                
                args = args + (_loc_3 + " ");
            }
            if (!FrameworkGlobal.published)
            {
                trace(args);
            }
            appendStr(args);
            return;
        }// end function

        public static function error(... args) : void
        {
            var _loc_3:* = null;
            args = ToolKit.getLogDate(new Date().time);
            for each (_loc_3 in args)
            {
                
                args = args + (_loc_3 + " ");
            }
            args = "Error!!!===: " + args;
            trace(args);
            if (!FrameworkGlobal.published)
            {
                throw new Error(args);
            }
            return;
        }// end function

        public static function debug(... args) : void
        {
            Debug.trace(args);
            return;
        }// end function

        public static function debugObj(param1:Object) : void
        {
            Debug.traceObj(param1);
            return;
        }// end function

        public static function monitorStart() : void
        {
            startTime = getTimer();
            startMem = System.totalMemory;
            return;
        }// end function

        public static function monitorStop() : void
        {
            startTime = getTimer();
            startMem = System.totalMemory;
            return;
        }// end function

        public static function monitorTrace(param1:String) : void
        {
            monitorStop();
            monitorStart();
            return;
        }// end function

        private static function toMoneyString(param1:int, param2:int = 13) : String
        {
            var _loc_3:* = "" + param1;
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = Math.ceil(_loc_4 / 3);
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < (_loc_5 - 1))
            {
                
                _loc_6.unshift(_loc_3.substr(_loc_4 - (1 + _loc_7) * 3, 3));
                _loc_7++;
            }
            _loc_6.unshift(_loc_3.substr(0, 3 - (_loc_5 * 3 - _loc_4)));
            var _loc_8:* = _loc_6.join(",");
            var _loc_9:* = param2 - _loc_8.length;
            return (param2 - _loc_8.length > 0 ? (ZERO.substr(0, _loc_9)) : ("")) + _loc_8;
        }// end function

    }
}
