package com.game.map.control
{
    import com.cfg.obj.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class MapSeeker extends Object
    {
        private static var SEARCH_DEEP:int = 12;
        private static var data:Dictionary;
        private static var jumpers:Array;

        public function MapSeeker()
        {
            return;
        }// end function

        public static function getTransfer(param1:int, param2:int) : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            data = MapCfgObj.getInstance().getTransferMap();
            jumpers = [];
            find(param1, param2, 0);
            if (jumpers.length)
            {
                _loc_3 = int.MAX_VALUE;
                _loc_4 = 0;
                while (_loc_4 < jumpers.length)
                {
                    
                    _loc_5 = (jumpers[_loc_4] as Array).length;
                    if (_loc_3 > _loc_5)
                    {
                        _loc_3 = _loc_4;
                    }
                    _loc_4++;
                }
                return jumpers[_loc_3];
            }
            return null;
        }// end function

        private static function find(param1:int, param2:int, param3:int = 1, param4:Array = null, param5:Array = null) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (param3 > SEARCH_DEEP)
            {
                return;
            }
            if (param1 == param2)
            {
                jumpers.push(param5);
                return;
            }
            if (!param4)
            {
                param4 = [];
            }
            if (!param5)
            {
                param5 = [];
            }
            param4.push(param1);
            var _loc_6:* = data[param1];
            if (!data[param1])
            {
                return;
            }
            var _loc_7:* = _loc_6.length;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = _loc_6[_loc_8];
                _loc_10 = _loc_9.q_tran_to_map;
                if (param4.indexOf(_loc_10) == -1)
                {
                    _loc_11 = param4.concat();
                    _loc_12 = param5.concat();
                    _loc_12.push(_loc_9);
                    find(_loc_10, param2, (param3 + 1), _loc_11, _loc_12);
                }
                _loc_8++;
            }
            return;
        }// end function

    }
}
