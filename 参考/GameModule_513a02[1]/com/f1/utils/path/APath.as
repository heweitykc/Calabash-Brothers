package com.f1.utils.path
{
    import flash.utils.*;

    public class APath extends AStar
    {
        public static const SPLIT_GRID_LENGTH:uint = 6;

        public function APath()
        {
            return;
        }// end function

        public function findPath(param1:uint, param2:uint, param3:uint, param4:uint, param5:int = 0, param6:int = 0) : Array
        {
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (param1 == param3 && param2 == param4)
            {
                return null;
            }
            var _loc_7:* = getTimer();
            var _loc_8:* = find(param1, param2, param3, param4, param6);
            if (find(param1, param2, param3, param4, param6))
            {
                _loc_9 = Math.max(1, _loc_8.length - param5);
                _loc_10 = _loc_8.slice(0, _loc_9);
                if (_loc_10)
                {
                    _loc_10 = combineAndSplitStraight(_loc_10);
                }
            }
            return _loc_10;
        }// end function

        public static function combineAndSplitStraight(param1:Array) : Array
        {
            var _loc_4:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = -1;
            var _loc_5:* = param1.length - 1;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_4 = MapUtils.countTileDirection(param1[_loc_7], param1[(_loc_7 + 1)]);
                if (_loc_4 != _loc_3)
                {
                    _loc_2.push(param1[_loc_7]);
                }
                else if (_loc_6 >= SPLIT_GRID_LENGTH)
                {
                    _loc_2.push(param1[_loc_7]);
                    _loc_6 = 0;
                }
                _loc_6 = _loc_6 + 1;
                _loc_3 = _loc_4;
                _loc_7 = _loc_7 + 1;
            }
            _loc_2.push(param1[_loc_7]);
            return _loc_2;
        }// end function

    }
}
