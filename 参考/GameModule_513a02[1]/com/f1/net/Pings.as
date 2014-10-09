package com.f1.net
{
    import flash.utils.*;

    public class Pings extends Object
    {
        public static var pingMap:Dictionary = new Dictionary();
        private static var instance:Pings;

        public function Pings()
        {
            return;
        }// end function

        public function getLastPingByCmd(param1:uint) : uint
        {
            var _loc_2:* = pingMap[param1];
            if (_loc_2 && _loc_2.length > 0)
            {
                return _loc_2[(_loc_2.length - 1)];
            }
            return 0;
        }// end function

        public function calcPings() : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = pingMap;
            var _loc_2:* = "cmd_pings=";
            for (_loc_3 in _loc_1)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_1[_loc_3] = [];
                if (_loc_4 && _loc_4.length > 0)
                {
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        _loc_6 = 0;
                        _loc_6 = _loc_6 + int(_loc_4[_loc_5]);
                        _loc_5++;
                    }
                }
                _loc_2 = _loc_2 + (_loc_3 + "," + _loc_3.length + "," + int(10 * _loc_6 / _loc_4.length) / 10 + "|");
            }
            return _loc_2;
        }// end function

        public static function getInstance() : Pings
        {
            if (instance == null)
            {
                instance = new Pings;
            }
            return instance;
        }// end function

    }
}
