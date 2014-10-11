package com.util
{
    import com.f1.manager.*;
    import com.f1.utils.*;

    public class StringRes extends Object
    {
        private static var _map:Object;
        private static var instance:StringRes;

        public function StringRes()
        {
            _map = CfgManager.getInstance().getMap("systemmessage");
            return;
        }// end function

        public function getMessage(param1:String, param2:Array = null) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_3:* = _map[param1].system_message;
            if (_loc_3 == null)
            {
                Log.log("StringRes失败： mark=" + param1);
                return "";
            }
            _loc_4 = param2 == null ? (0) : (param2.length);
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = _loc_3.replace("#s" + (_loc_5 + 1), param2[_loc_5]);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function getSite(param1:String) : int
        {
            if (_map[param1])
            {
                return _map[param1].site;
            }
            return 0;
        }// end function

        public function getMusic(param1:String) : int
        {
            if (_map[param1])
            {
                return _map[param1].music;
            }
            return 0;
        }// end function

        public static function getInstance() : StringRes
        {
            if (instance == null)
            {
                instance = new StringRes;
            }
            return instance;
        }// end function

    }
}
