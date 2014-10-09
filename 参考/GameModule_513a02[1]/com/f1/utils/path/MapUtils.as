package com.f1.utils.path
{
    import com.f1.*;
    import flash.utils.*;

    public class MapUtils extends Object
    {
        public static const DIRECT_0:uint = 0;
        public static const DIRECT_45:uint = 1;
        public static const DIRECT_90:uint = 2;
        public static const DIRECT_135:uint = 3;
        public static const DIRECT_180:uint = 4;
        public static const DIRECT_225:uint = 5;
        public static const DIRECT_270:uint = 6;
        public static const DIRECT_315:uint = 7;
        public static const GRID_BORDER:uint = 25;
        public static const TILE_STAT_CAN_WALK:int = 0;
        public static const TILE_STAT_NO_WALK:int = 1;
        public static const TITE_STAT_TRANSPARENT:int = 2;
        private static var _aPath:APath;
        public static var openPointSeek:Boolean = true;

        public function MapUtils()
        {
            return;
        }// end function

        public static function get aPath() : APath
        {
            if (!_aPath)
            {
                _aPath = new APath();
            }
            return _aPath;
        }// end function

        public static function roleDir2MapDirect(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case FrameworkGlobal.DIRECT_0:
                {
                    _loc_2 = 0;
                    break;
                }
                case FrameworkGlobal.DIRECT_45:
                {
                    _loc_2 = 1;
                    break;
                }
                case FrameworkGlobal.DIRECT_90:
                {
                    _loc_2 = 2;
                    break;
                }
                case FrameworkGlobal.DIRECT_135:
                {
                    _loc_2 = 3;
                    break;
                }
                case FrameworkGlobal.DIRECT_180:
                {
                    _loc_2 = 4;
                    break;
                }
                case -FrameworkGlobal.DIRECT_135:
                {
                    _loc_2 = 5;
                    break;
                }
                case -FrameworkGlobal.DIRECT_90:
                {
                    _loc_2 = 6;
                    break;
                }
                case -FrameworkGlobal.DIRECT_45:
                {
                    _loc_2 = 7;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function mapDirect2RoleDir(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = FrameworkGlobal.DIRECT_0;
                    break;
                }
                case 1:
                {
                    _loc_2 = FrameworkGlobal.DIRECT_45;
                    break;
                }
                case 2:
                {
                    _loc_2 = FrameworkGlobal.DIRECT_90;
                    break;
                }
                case 3:
                {
                    _loc_2 = FrameworkGlobal.DIRECT_135;
                    break;
                }
                case 4:
                {
                    _loc_2 = FrameworkGlobal.DIRECT_180;
                    break;
                }
                case 5:
                {
                    _loc_2 = -FrameworkGlobal.DIRECT_135;
                    break;
                }
                case 6:
                {
                    _loc_2 = -FrameworkGlobal.DIRECT_90;
                    break;
                }
                case 7:
                {
                    _loc_2 = -FrameworkGlobal.DIRECT_45;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function coo2Tile(param1:Number) : uint
        {
            return Math.floor(param1 / GRID_BORDER);
        }// end function

        public static function tile2Coo(param1:Array) : Array
        {
            return [uint(param1[0] * GRID_BORDER + GRID_BORDER / 2), uint(param1[1] * GRID_BORDER + GRID_BORDER / 2)];
        }// end function

        public static function findPath(param1:ByteArray, param2:uint, param3:uint, param4:uint, param5:uint, param6:int = 0, param7:int = 0) : Array
        {
            aPath.tiles = param1;
            var _loc_8:* = aPath.findPath(param2, param3, param4, param5, param6, param7);
            return aPath.findPath(param2, param3, param4, param5, param6, param7);
        }// end function

        public static function getImgDir(param1:uint) : String
        {
            switch(param1)
            {
                case 0:
                {
                    return "↑";
                }
                case 1:
                {
                    return "↗";
                }
                case 2:
                {
                    return "→";
                }
                case 3:
                {
                    return "↘";
                }
                case 4:
                {
                    return "↓";
                }
                case 5:
                {
                    return "↙";
                }
                case 6:
                {
                    return "←";
                }
                case 7:
                {
                    return "↖";
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public static function countDistance(param1:Array, param2:Array) : uint
        {
            return Math.max(Math.abs(param2[0] - param1[0]), Math.abs(param2[1] - param1[1]));
        }// end function

        public static function countDirection(param1:Number, param2:Number, param3:Number, param4:Number) : int
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (param2 == param4 && param1 == param3)
            {
                return 4;
            }
            if (param2 == param4)
            {
                if (param1 < param3)
                {
                    return 2;
                }
                return 6;
            }
            else
            {
                if (param1 == param3)
                {
                    if (param2 < param4)
                    {
                        return 4;
                    }
                    return 0;
                }
                else
                {
                    _loc_5 = Math.atan((param4 - param2) / (-(param3 - param1)));
                    _loc_6 = Math.PI / 8;
                    _loc_7 = Math.PI / 2 - _loc_6;
                    if (_loc_5 > -_loc_6 && _loc_5 <= _loc_6)
                    {
                        if (param1 < param3)
                        {
                            return 2;
                        }
                        return 6;
                    }
                    else
                    {
                        if (_loc_5 > _loc_6 && _loc_5 <= _loc_7)
                        {
                            if (param1 < param3)
                            {
                                return 1;
                            }
                            return 5;
                        }
                        else
                        {
                            if (_loc_5 > -_loc_7 && _loc_5 <= -_loc_6)
                            {
                                if (param1 < param3)
                                {
                                    return 3;
                                }
                                return 7;
                            }
                            else
                            {
                                if (param2 < param4)
                                {
                                    return 4;
                                }
                                return 0;
                            }
                        }
                    }
                }
            }
        }// end function

        public static function countTileDirection(param1:Array, param2:Array) : uint
        {
            if (param1[1] == param2[1] && param1[0] == param2[0])
            {
                return 4;
            }
            if (param1[1] == param2[1])
            {
                if (param1[0] < param2[0])
                {
                    return 2;
                }
                return 6;
            }
            else
            {
                if (param1[0] == param2[0])
                {
                    if (param1[1] < param2[1])
                    {
                        return 4;
                    }
                    return 0;
                }
                else
                {
                    if (param1[0] < param2[0])
                    {
                        if (param1[1] < param2[1])
                        {
                            return 3;
                        }
                        return 1;
                    }
                    else
                    {
                        if (param1[1] < param2[1])
                        {
                            return 5;
                        }
                        return 7;
                    }
                }
            }
        }// end function

        public static function countDirectionAddtion(param1:int) : Array
        {
            switch(param1)
            {
                case 0:
                {
                    return [0, -1];
                }
                case 1:
                {
                    return [1, -1];
                }
                case 2:
                {
                    return [1, 0];
                }
                case 3:
                {
                    return [1, 1];
                }
                case 4:
                {
                    return [0, 1];
                }
                case 5:
                {
                    return [-1, 1];
                }
                case 6:
                {
                    return [-1, 0];
                }
                case 7:
                {
                    return [-1, -1];
                }
                default:
                {
                    return [0, 0];
                    break;
                }
            }
        }// end function

        public static function countAngleOfDir(param1:int, param2:int) : uint
        {
            var _loc_3:* = Math.abs(param1 - param2);
            return _loc_3 > 4 ? (8 - _loc_3) : (_loc_3);
        }// end function

    }
}
