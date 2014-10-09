package com.game.map.control
{
    import __AS3__.vec.*;

    public class PointTable extends Object
    {
        private static var _dataMap:Object;
        private static var _keyList:Vector.<String>;
        private static var _weight:Vector.<Vector.<int>>;

        public function PointTable()
        {
            return;
        }// end function

        public static function create(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            _dataMap = param1;
            _keyList = new Vector.<String>;
            for (_loc_2 in _dataMap)
            {
                
                _keyList.push(_loc_2);
            }
            _loc_3 = _keyList.length;
            _weight = new Vector.<Vector.<int>>(_loc_3);
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _weight[_loc_4] = new Vector.<int>(_loc_3);
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    if (_loc_4 == _loc_5)
                    {
                        _weight[_loc_4][_loc_5] = 0;
                    }
                    else
                    {
                        _weight[_loc_4][_loc_5] = -1;
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = _keyList[_loc_4];
                _loc_6 = _loc_11[_loc_2];
                _loc_7 = _loc_6.child;
                _loc_5 = 0;
                while (_loc_5 < _loc_7.length)
                {
                    
                    _loc_8 = _loc_7[_loc_5] as String;
                    _loc_9 = _keyList.indexOf(_loc_8);
                    if (_loc_9 != -1)
                    {
                        _weight[_loc_4][_loc_9] = _loc_6.w[_loc_5];
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            return;
        }// end function

        public static function getPath(param1:String, param2:String) : Array
        {
            var _loc_3:* = _keyList.indexOf(param1);
            var _loc_4:* = _keyList.indexOf(param2);
            var _loc_5:* = dijkstra(_weight, _loc_3, _loc_4);
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5.length)
            {
                
                _loc_6.push(_keyList[_loc_5[_loc_7]]);
                _loc_7++;
            }
            return _loc_6;
        }// end function

        public static function dijkstra(param1:Vector.<Vector.<int>>, param2:int, param3:int) : Vector.<int>
        {
            var _loc_14:* = 0;
            var _loc_4:* = param1.length;
            var _loc_5:* = new Vector.<Boolean>(_loc_4);
            var _loc_6:* = new Vector.<int>(_loc_4);
            var _loc_7:* = 0;
            var _loc_8:* = new Vector.<int>(_loc_4);
            var _loc_9:* = 0;
            while (_loc_9 < _loc_4)
            {
                
                _loc_8[_loc_9] = param1[param2][_loc_9];
                _loc_9++;
            }
            var _loc_10:* = param2;
            _loc_6[_loc_7] = _loc_10;
            var _loc_11:* = new Vector.<int>(_loc_4);
            _loc_9 = 0;
            while (_loc_9 < _loc_11.length)
            {
                
                _loc_11[_loc_9] = param2;
                _loc_9++;
            }
            _loc_5[_loc_10] = true;
            while (_loc_7 < param1[0].length)
            {
                
                _loc_14 = int.MAX_VALUE;
                _loc_9 = 0;
                while (_loc_9 < _loc_8.length)
                {
                    
                    if (!_loc_5[_loc_9] && _loc_8[_loc_9] != -1 && _loc_9 != _loc_10)
                    {
                        if (_loc_8[_loc_9] < _loc_14)
                        {
                            _loc_14 = _loc_8[_loc_9];
                            _loc_10 = _loc_9;
                        }
                    }
                    _loc_9++;
                }
                if (_loc_10 == param3)
                {
                    break;
                }
                _loc_5[_loc_10] = true;
                _loc_7++;
                _loc_6[_loc_7] = _loc_10;
                _loc_9 = 0;
                while (_loc_9 < _loc_8.length)
                {
                    
                    if (_loc_8[_loc_9] == -1 && param1[_loc_10][_loc_9] != -1 && !_loc_5[_loc_9])
                    {
                        _loc_8[_loc_9] = _loc_8[_loc_10] + param1[_loc_10][_loc_9];
                        _loc_11[_loc_9] = _loc_10;
                    }
                    else if (param1[_loc_10][_loc_9] != -1 && _loc_8[_loc_10] + param1[_loc_10][_loc_9] < _loc_8[_loc_9])
                    {
                        _loc_8[_loc_9] = _loc_8[_loc_10] + param1[_loc_10][_loc_9];
                        _loc_11[_loc_9] = _loc_10;
                    }
                    _loc_9++;
                }
            }
            var _loc_12:* = new Vector.<int>;
            _loc_9 = param3;
            _loc_12[0] = _loc_9;
            var _loc_13:* = 1;
            while (_loc_11[_loc_9] != param2)
            {
                
                _loc_9 = _loc_11[_loc_9];
                _loc_12[_loc_13] = _loc_9;
                _loc_13++;
            }
            _loc_12[_loc_13] = param2;
            return _loc_12.reverse();
        }// end function

    }
}
