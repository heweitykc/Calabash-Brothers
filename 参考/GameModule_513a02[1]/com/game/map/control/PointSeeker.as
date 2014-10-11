package com.game.map.control
{
    import __AS3__.vec.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.map.model.*;
    import flash.utils.*;

    public class PointSeeker extends Object
    {
        private static var data:Object;
        private static const NEAR_MAX_RANGE:int = 3600;

        public function PointSeeker()
        {
            return;
        }// end function

        public static function path(param1:ByteArray, param2:int, param3:int, param4:int, param5:int, param6:int = 0) : Array
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = 0;
            data = MapObj.getInstance().pointsMap;
            if (!data)
            {
                return null;
            }
            var _loc_7:* = getTimer();
            var _loc_8:* = getNearPointStart(param2, param3);
            var _loc_12:* = uint.MAX_VALUE;
            for each (_loc_13 in _loc_8)
            {
                
                _loc_11 = getNearPointEnd(param4, param5, _loc_13.x + "_" + _loc_13.y);
                if (_loc_11.dis < _loc_12)
                {
                    _loc_12 = _loc_11.dis;
                    _loc_9 = _loc_13;
                    _loc_10 = _loc_11;
                }
            }
            if (!_loc_9 || !_loc_10)
            {
                return null;
            }
            var _loc_14:* = _loc_9.key;
            var _loc_15:* = _loc_10.key;
            var _loc_19:* = [];
            var _loc_20:* = _loc_14.split("_");
            var _loc_21:* = _loc_15.split("_");
            if (_loc_14 == _loc_15)
            {
                _loc_16 = _loc_20[0];
                _loc_17 = _loc_20[1];
                _loc_23 = MapUtils.findPath(param1, param2, param3, _loc_16, _loc_17, param6);
                if (!_loc_23)
                {
                    return null;
                }
                _loc_19 = _loc_19.concat(_loc_23);
                _loc_20 = _loc_15.split("_");
                _loc_16 = data[_loc_15].x;
                _loc_17 = data[_loc_15].y;
                if (_loc_16 == param4 && _loc_17 == param5)
                {
                    _loc_18 = [];
                }
                else
                {
                    _loc_18 = MapUtils.findPath(param1, _loc_16, _loc_17, param4, param5, param6);
                }
                if (!_loc_18)
                {
                    return null;
                }
                _loc_18.shift();
                _loc_19 = _loc_19.concat(_loc_18);
                return _loc_19;
            }
            var _loc_22:* = PointTable.getPath(_loc_14, _loc_15);
            if (PointTable.getPath(_loc_14, _loc_15) && _loc_22.length > 0)
            {
                _loc_24 = getRoadList(_loc_22);
                if (_loc_24)
                {
                    _loc_20 = _loc_14.split("_");
                    _loc_16 = _loc_20[0];
                    _loc_17 = _loc_20[1];
                    _loc_23 = _loc_9.path;
                    if (_loc_23)
                    {
                        _loc_27 = _loc_24.length >= 50 ? (50) : (_loc_24.length);
                        _loc_28 = 0;
                        while (_loc_28 < _loc_27)
                        {
                            
                            _loc_25 = _loc_24[_loc_28];
                            if ((_loc_25[0] - param2) * (_loc_20[0] - param2) < 0 || (_loc_25[1] - param3) * (_loc_20[1] - param3) < 0)
                            {
                                _loc_26 = MapUtils.findPath(param1, param2, param3, _loc_25[0], _loc_25[1], 0, 100);
                                if (_loc_26)
                                {
                                    _loc_24.splice(0, (_loc_28 + 1));
                                    _loc_23 = _loc_26;
                                }
                                break;
                            }
                            else if (_loc_25[0] == param2 && _loc_25[1] == param3)
                            {
                                _loc_23 = [];
                                _loc_24.splice(0, _loc_28);
                                break;
                            }
                            _loc_28++;
                        }
                    }
                    else
                    {
                        return null;
                    }
                    _loc_20 = _loc_15.split("_");
                    _loc_16 = _loc_20[0];
                    _loc_17 = _loc_20[1];
                    if (_loc_16 == param4 && _loc_17 == param5)
                    {
                        _loc_18 = [[_loc_16, _loc_17]];
                    }
                    else
                    {
                        _loc_18 = MapUtils.findPath(param1, _loc_16, _loc_17, param4, param5, param6);
                    }
                    if (_loc_18 && _loc_18.length)
                    {
                        _loc_27 = _loc_24.length >= 50 ? (_loc_24.length - 50) : (0);
                        _loc_28 = _loc_24.length - 1;
                        while (_loc_28 >= _loc_27)
                        {
                            
                            _loc_25 = _loc_24[_loc_28];
                            if ((_loc_25[0] - param4) * (_loc_21[0] - param4) < 0 || (_loc_25[1] - param5) * (_loc_21[1] - param5) < 0)
                            {
                                _loc_26 = MapUtils.findPath(param1, _loc_25[0], _loc_25[1], param4, param5, 0, 100);
                                if (_loc_26 && _loc_28 != (_loc_24.length + 1))
                                {
                                    _loc_24.splice((_loc_28 + 1), _loc_24.length - _loc_28 - 1);
                                    _loc_18 = _loc_26;
                                    break;
                                }
                                else
                                {
                                    _loc_18.shift();
                                }
                                break;
                            }
                            else if (_loc_25[0] == param4 && _loc_25[1] == param5 && _loc_24.length - _loc_28 - 2 > 0)
                            {
                                _loc_24.splice(_loc_28, _loc_24.length - _loc_28 - 2);
                                _loc_18 = [];
                                break;
                            }
                            _loc_28 = _loc_28 - 1;
                        }
                    }
                    else
                    {
                        return null;
                    }
                    _loc_19 = _loc_19.concat(_loc_23);
                    _loc_19 = _loc_19.concat(_loc_24);
                    _loc_19 = _loc_19.concat(_loc_18);
                }
                Log.log("寻路耗时：", getTimer() - _loc_7);
                return _loc_19;
            }
            else
            {
                return null;
            }
        }// end function

        private static function getNearPointStart(param1:int, param2:int) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_3:* = int.MAX_VALUE;
            var _loc_7:* = [];
            for (_loc_9 in data)
            {
                
                _loc_5 = _loc_9.split("_");
                _loc_12 = _loc_5[0];
                _loc_13 = _loc_5[1];
                _loc_4 = ToolKit.distanceSQ(param1, param2, _loc_12, _loc_13);
                if (_loc_4 > NEAR_MAX_RANGE)
                {
                    continue;
                }
                _loc_7.push({dis:_loc_4, x:_loc_12, y:_loc_13, select:_loc_9});
            }
            _loc_10 = 2;
            if (_loc_7.length > 0)
            {
                _loc_7.sortOn("dis", Array.NUMERIC);
                _loc_17 = 0;
                while (_loc_17 < _loc_7.length)
                {
                    
                    _loc_16 = _loc_7[_loc_17];
                    _loc_14 = _loc_16.select;
                    _loc_15 = MapUtils.findPath(MapObj.getInstance().tilesba, param1, param2, _loc_16.x, _loc_16.y, 0, 100);
                    if (_loc_15)
                    {
                        if (!_loc_11)
                        {
                            _loc_11 = [];
                        }
                        _loc_11.push({key:_loc_14, path:_loc_15, x:_loc_16.x, y:_loc_16.y});
                        if (_loc_11.length == _loc_10)
                        {
                            return _loc_11;
                        }
                    }
                    _loc_17 = _loc_17 + 1;
                }
            }
            return _loc_11;
        }// end function

        private static function getNearPointEnd(param1:int, param2:int, param3:String) : Object
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_4:* = int.MAX_VALUE;
            var _loc_9:* = [];
            for (_loc_11 in data)
            {
                
                _loc_7 = _loc_11.split("_");
                _loc_12 = _loc_7[0];
                _loc_13 = _loc_7[1];
                _loc_6 = ToolKit.distanceSQ(param1, param2, _loc_12, _loc_13);
                if (_loc_6 > NEAR_MAX_RANGE)
                {
                    continue;
                }
                _loc_5 = PointTable.getPath(param3, _loc_11);
                if (_loc_5 && _loc_5.length > 0)
                {
                    _loc_9.push({dis:_loc_5.length, x:_loc_12, y:_loc_13, select:_loc_11});
                }
            }
            if (_loc_9.length > 0)
            {
                _loc_9.sortOn("dis", Array.NUMERIC);
                _loc_17 = 0;
                while (_loc_17 < _loc_9.length)
                {
                    
                    _loc_16 = _loc_9[_loc_17];
                    _loc_14 = _loc_16.select;
                    _loc_15 = MapUtils.findPath(MapObj.getInstance().tilesba, param1, param2, _loc_16.x, _loc_16.y, 0, 100);
                    if (_loc_15 || param1 == _loc_16.x && param2 == _loc_16.y)
                    {
                        return {key:_loc_14, path:_loc_15, dis:_loc_16.dis};
                    }
                    _loc_17 = _loc_17 + 1;
                }
            }
            return null;
        }// end function

        private static function getRoadList(param1:Array) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = param1.length;
            var _loc_3:* = [];
            var _loc_4:* = 1;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = param1[(_loc_4 - 1)];
                _loc_7 = data[_loc_6];
                if (_loc_7)
                {
                    _loc_8 = _loc_7.child;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8.length)
                    {
                        
                        _loc_10 = _loc_8[_loc_9] as String;
                        if (_loc_10 == _loc_5)
                        {
                            _loc_11 = _loc_7.path;
                            _loc_12 = (_loc_11[_loc_9] as Array).slice(1);
                            _loc_3 = _loc_3.concat(_loc_12);
                            break;
                        }
                        _loc_9++;
                    }
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

    }
}
