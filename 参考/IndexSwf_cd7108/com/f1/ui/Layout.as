package com.f1.ui
{
    import com.f1.*;
    import com.greensock.*;
    import flash.display.*;

    public class Layout extends Object
    {
        public static const CENTER:uint = 1;
        public static const TOP_CENTER:uint = 2;
        public static const LEFT_CENTER:uint = 3;
        public static const RIGHT_CENTER:uint = 5;
        public static const BOTTOM:uint = 6;
        public static const BOTTOM_CENTER:uint = 7;
        public static const BOTTOM_RIGHT:uint = 8;
        public static const RIGHT:uint = 9;
        public static const SPREAD:uint = 10;
        public static const NORMAL:uint = 11;

        public function Layout()
        {
            return;
        }// end function

        public static function layoutGroup(param1:DisplayObject, param2:Array, param3:uint, param4:int, param5:int, param6:Number, param7:Number = NaN, param8:Number = NaN) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            for each (_loc_12 in param2)
            {
                
                if (_loc_12 is BaseSprite)
                {
                    _loc_9 = _loc_9 + (_loc_12 as BaseSprite)._w;
                    _loc_11 = (_loc_12 as BaseSprite)._h;
                }
                else
                {
                    _loc_9 = _loc_9 + _loc_12.width;
                    _loc_11 = _loc_12.height;
                }
                if (_loc_11 > _loc_10)
                {
                    _loc_10 = _loc_11;
                }
            }
            param4 = 0;
            for each (_loc_12 in param2)
            {
                
                layoutMCByWH(param1, _loc_12, _loc_9, _loc_10, param3, param4, param5, param6, param7, param8);
                if (_loc_12 is BaseSprite)
                {
                    param4 = param4 + (_loc_12 as BaseSprite)._w;
                    continue;
                }
                param4 = param4 + _loc_12.width;
            }
            return;
        }// end function

        public static function layoutMC(param1:DisplayObject, param2:DisplayObject, param3:uint = 1, param4:int = 0, param5:int = 0, param6:Number = 0, param7:Number = NaN, param8:Number = NaN) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (param2 is BaseSprite)
            {
                _loc_9 = (param2 as BaseSprite)._w;
                _loc_10 = (param2 as BaseSprite)._h;
            }
            else
            {
                _loc_9 = param2.width;
                _loc_10 = param2.height;
            }
            layoutMCByWH(param1, param2, _loc_9, _loc_10, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        private static function layoutMCByWH(param1:DisplayObject, param2:DisplayObject, param3:uint, param4:uint, param5:uint, param6:int, param7:int, param8:Number, param9:Number = NaN, param10:Number = NaN) : void
        {
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            if (param1 is BaseSprite)
            {
                _loc_11 = (param1 as BaseSprite)._w;
                _loc_12 = (param1 as BaseSprite)._h;
            }
            else if (param1 is Stage)
            {
                _loc_11 = Stage(param1).stageWidth;
                _loc_12 = Stage(param1).stageHeight;
            }
            else
            {
                _loc_11 = param1.width;
                _loc_12 = param1.height;
            }
            switch(param5)
            {
                case CENTER:
                {
                    _loc_13 = (_loc_11 - param3) / 2 + param6;
                    _loc_14 = (_loc_12 - param4) / 2 + param7;
                    break;
                }
                case LEFT_CENTER:
                {
                    _loc_13 = param6;
                    _loc_14 = (_loc_12 - param4) / 2 + param7;
                    break;
                }
                case RIGHT:
                {
                    _loc_13 = _loc_11 - param3 - param6;
                    _loc_14 = param7;
                    break;
                }
                case RIGHT_CENTER:
                {
                    _loc_13 = _loc_11 - param3 - param6;
                    _loc_14 = (_loc_12 - param4) / 2 + param7;
                    break;
                }
                case TOP_CENTER:
                {
                    _loc_13 = (_loc_11 - param3) / 2 + param6;
                    _loc_14 = param7;
                    break;
                }
                case BOTTOM:
                {
                    _loc_13 = param6;
                    _loc_14 = _loc_12 - param4 - param7;
                    break;
                }
                case BOTTOM_CENTER:
                {
                    _loc_13 = (_loc_11 - param3) / 2 + param6;
                    _loc_14 = _loc_12 - param4 - param7;
                    break;
                }
                case BOTTOM_RIGHT:
                {
                    _loc_13 = _loc_11 - param3 - param6;
                    _loc_14 = _loc_12 - param4 - param7;
                    break;
                }
                case SPREAD:
                {
                    setHeight(param2, _loc_12);
                    param3 = setWidth(param2, param3 * (_loc_12 / param4));
                    _loc_13 = (_loc_11 - param3) / 2;
                    break;
                }
                case NORMAL:
                {
                    _loc_13 = param6;
                    _loc_14 = param7;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_13 = _loc_13 >> 0;
            _loc_14 = _loc_14 >> 0;
            move(param2, _loc_13, _loc_14, param8, param9, param10);
            return;
        }// end function

        private static function setWidth(param1:DisplayObject, param2:Number) : Number
        {
            if (param1 is BaseSprite)
            {
                (param1 as BaseSprite).setWidth(param2);
            }
            else
            {
                param1.width = param2;
            }
            return param2;
        }// end function

        private static function setHeight(param1:DisplayObject, param2:Number) : Number
        {
            if (param1 is BaseSprite)
            {
                (param1 as BaseSprite).setHeight(param2);
            }
            else
            {
                param1.height = param2;
            }
            return param2;
        }// end function

        private static function move(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number = NaN, param6:Number = NaN) : void
        {
            var _loc_7:* = null;
            if (!param1)
            {
                return;
            }
            if (param4 > 0)
            {
                _loc_7 = {x:param2, y:param3};
                if (!isNaN(param5))
                {
                    _loc_7.alpha = param5;
                }
                if (!isNaN(param6))
                {
                    _loc_7.scaleX = param6;
                    _loc_7.scaleY = param6;
                }
                TweenLite.to(param1, param4, _loc_7);
            }
            else if (param1 is BaseSprite)
            {
                (param1 as BaseSprite).move(param2, param3);
            }
            else
            {
                param1.x = param2;
                param1.y = param3;
            }
            return;
        }// end function

    }
}
