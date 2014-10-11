package com.f1
{
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import flash.utils.*;

    public class LoadHelper extends Object
    {
        private static var _map:Object;
        private static var _path:String;
        private static const myPattern:RegExp = /\\/g;

        public function LoadHelper()
        {
            return;
        }// end function

        public static function init(param1:String, param2:Function) : void
        {
            var path:* = param1;
            var callBack:* = param2;
            Log.log("LoadHelper", path);
            if (_path)
            {
                return;
            }
            _path = path;
            VResManager.load(path, function (param1:ByteArray) : void
            {
                param1.uncompress();
                var _loc_2:* = getTimer();
                _map = param1.readObject();
                callBack.call();
                return;
            }// end function
            , null, null, null, false, false, true);
            return;
        }// end function

        public static function getFileSize(param1:String) : uint
        {
            var _loc_2:* = null;
            if (_map)
            {
                _loc_2 = _map[param1];
                if (_loc_2)
                {
                    return _loc_2.size;
                }
            }
            return 0;
        }// end function

        public static function getTrueURL(param1:String, param2:Boolean = false) : String
        {
            var _loc_3:* = null;
            param1 = param1.replace(myPattern, "/");
            if (param1.indexOf("res/") == 0 && FrameworkGlobal.language != "")
            {
                param1 = FrameworkGlobal.language + "/" + param1;
            }
            if (param2)
            {
                return param1;
            }
            if (!FrameworkGlobal.published)
            {
                return param1;
            }
            if (_map)
            {
                _loc_3 = _map[param1];
                if (_loc_3 && _loc_3.ver)
                {
                    param1 = param1.replace(".", "_" + _loc_3.ver + ".");
                    return param1;
                }
                Log.log("没有这个文件的MD5信息", param1);
            }
            return null;
        }// end function

    }
}
