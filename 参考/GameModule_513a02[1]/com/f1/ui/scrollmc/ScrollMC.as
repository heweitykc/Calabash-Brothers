package com.f1.ui.scrollmc
{
    import com.f1.effect.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import flash.display.*;
    import flash.utils.*;

    public class ScrollMC extends Object
    {
        public static const DIRECT_TYPE:uint = 1;
        public static const TWO_STEP_TYPE:uint = 2;
        public static const SCALE_TYPE:uint = 3;
        public static const BEZIER_TYPE:uint = 4;
        public static const EXP_TYPE:uint = 6;
        public static const MISS_TYPE:uint = 7;
        public static const BLOOD_TYPE:uint = 8;
        public static const CRIT_TYPE:uint = 9;
        public static const MONSTER_DAMAGE_TYPE:uint = 10;
        public static const MAP_NAME_TYPE:uint = 11;
        public static const FPS:uint = 24;
        public static const EXP_SCALE:Number = 1.5;
        public static const EXP_EFFECT_DURING1:Number = 0.208333;
        public static const EXP_EFFECT_DURING2:Number = 0.375;
        public static const EXP_EFFECT_DURING3:Number = 1.08333;
        public static const MISS_SCALE:Number = 1;
        public static const MISS_EFFECT_DURING1:Number = 0.208333;
        public static const MISS_EFFECT_DURING2:Number = 0.0833333;
        public static const MISS_EFFECT_DURING3:Number = 0.25;
        public static const MISS_EFFECT_DURING4:Number = 0.25;
        public static const BLOOD_EFFECT_DURING1:Number = 0.208333;
        public static const BLOOD_EFFECT_DURING2:Number = 1.125;
        public static const CRIT_SCALE:Number = 1.5;
        public static const CRIT_EFFECT_DURING1:Number = 0.375;
        public static const CRIT_EFFECT_DURING2:Number = 0.0833333;
        public static const CRIT_EFFECT_DURING3:Number = 0.833333;
        public static const CRIT_EFFECT_DURING4:Number = 1;
        public static const MONSTER_DAMAGE_SCALE:Number = 0;
        public static const MONSTER_DAMAGE_EFFECT_DURING1:Number = 0.166667;
        public static const MONSTER_DAMAGE_EFFECT_DURING2:Number = 0.666667;
        public static const MONSTER_DAMAGE_EFFECT_DURING3:Number = 2;
        public static var SCROLL_OVER:String = "scrollOver";
        private static var timeLineDic:Dictionary = new Dictionary();
        private static var mcList:Array = [];

        public function ScrollMC()
        {
            return;
        }// end function

        public static function startArr(param1:Array, param2:Number = 0.5, param3:Number = 1.5, param4:uint = 1) : void
        {
            var _loc_6:* = null;
            var _loc_5:* = 0;
            for each (_loc_6 in param1)
            {
                
                _loc_6.alpha = 0;
                TweenLite.killTweensOf(_loc_6);
                TweenLite.delayedCall(_loc_5 * param2, start, [_loc_6, param3, param4]);
                _loc_5++;
            }
            return;
        }// end function

        public static function start(param1:DisplayObject, param2:Number = 1.5, param3:uint = 1, param4:uint = 100, param5:int = 1, param6:int = 22, param7:int = 1) : void
        {
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            if (timeLineDic[param1])
            {
                TimelineLite(timeLineDic[param1]).setEnabled(false);
                timeLineDic[param1] = null;
                delete timeLineDic[param1];
                _loc_13 = mcList.indexOf(param1);
                if (_loc_13 != -1)
                {
                    mcList.splice(_loc_13, 1);
                }
            }
            if (mcList.length >= 30)
            {
                _loc_14 = mcList.shift();
                onComplete(_loc_14, 0, 0);
            }
            TweenLite.killTweensOf(param1);
            param1.alpha = 0;
            var _loc_8:* = param1.x;
            var _loc_9:* = param1.y;
            var _loc_10:* = new TimelineLite();
            timeLineDic[param1] = _loc_10;
            mcList.push(param1);
            _loc_10.autoRemoveChildren = true;
            var _loc_11:* = param2 / 4;
            var _loc_12:* = param2 / 2;
            if (param3 == DIRECT_TYPE)
            {
                TweenLite.to(param1, param2, {y:_loc_9 - param4});
                _loc_10.append(new TweenLite(param1, _loc_11, {alpha:1}));
                _loc_10.append(new TweenLite(param1, _loc_12, {}));
                _loc_10.append(new TweenLite(param1, _loc_11, {alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == MAP_NAME_TYPE)
            {
                _loc_10.append(new TweenLite(param1, 0.8, {alpha:1}));
                _loc_10.append(new TweenLite(param1, 1, {}));
                _loc_10.append(new TweenLite(param1, param2, {y:_loc_9 - param4, alpha:0}));
            }
            else if (param3 == TWO_STEP_TYPE)
            {
                _loc_10.append(new TweenLite(param1, _loc_11, {y:_loc_9 - param4 / 2, alpha:1}));
                _loc_10.append(new TweenLite(param1, _loc_12, {}));
                _loc_10.append(new TweenLite(param1, _loc_11, {y:_loc_9 - param4, alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == SCALE_TYPE)
            {
                Effects.flash(param1, 1.5, 0.5, 0.1, 0, 0, 2);
            }
            else if (param3 == BEZIER_TYPE)
            {
                param1.alpha = 1;
                TweenMax.to(param1, param2, new TweenMaxVars().bezier([{x:_loc_8 + 100, y:_loc_9 + 70}, {x:_loc_8 + 200, y:_loc_9 - 100}]));
                _loc_10.append(new TweenLite(param1, _loc_12, {}));
                _loc_10.append(new TweenLite(param1, _loc_12, {alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == EXP_TYPE)
            {
                param1.alpha = 1;
                param1.scaleX = EXP_SCALE;
                param1.scaleY = EXP_SCALE;
                _loc_10.append(new TweenLite(param1, EXP_EFFECT_DURING1, {scaleX:0.66, scaleY:0.65}));
                _loc_10.append(new TweenLite(param1, EXP_EFFECT_DURING2, {}));
                _loc_10.append(new TweenLite(param1, EXP_EFFECT_DURING3, {alpha:0, y:_loc_9 - 57, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == MISS_TYPE)
            {
                param1.alpha = 1;
                param1.scaleX = MISS_SCALE;
                param1.scaleY = MISS_SCALE;
                _loc_10.append(new TweenLite(param1, MISS_EFFECT_DURING1, {x:(_loc_8 + 1), y:_loc_9 - 45, scaleX:1.66, scaleY:1.63}));
                _loc_10.append(new TweenLite(param1, MISS_EFFECT_DURING2, {x:_loc_8 - 0.5, y:_loc_9 - 56, scaleX:1.12, scaleY:1.11}));
                _loc_10.append(new TweenLite(param1, MISS_EFFECT_DURING3, {x:_loc_8 + 1.1, y:_loc_9 - 54, scaleX:1.75, scaleY:1.7}));
                _loc_10.append(new TweenLite(param1, MISS_EFFECT_DURING3, {alpha:0, y:_loc_9 - 100, scaleX:1.75, scaleY:1.7, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == BLOOD_TYPE)
            {
                param1.alpha = 1;
                _loc_10.append(new TweenLite(param1, BLOOD_EFFECT_DURING1, {y:_loc_9 - 30}));
                _loc_10.append(new TweenLite(param1, BLOOD_EFFECT_DURING2, {y:_loc_9 - 90, alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == CRIT_TYPE)
            {
                param1.alpha = 1;
                param1.scaleX = CRIT_SCALE;
                param1.scaleY = CRIT_SCALE;
                _loc_10.append(new TweenLite(param1, CRIT_EFFECT_DURING1, {x:_loc_8 + 55, y:_loc_9 - 51, scaleX:0.66, scaleY:0.66}));
                _loc_10.append(new TweenLite(param1, CRIT_EFFECT_DURING2, {x:_loc_8 + 58, y:_loc_9 - 62, scaleX:0.6, scaleY:0.6}));
                _loc_10.append(new TweenLite(param1, CRIT_EFFECT_DURING3, {y:_loc_9 - 121}));
                _loc_10.append(new TweenLite(param1, CRIT_EFFECT_DURING4, {alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            else if (param3 == MONSTER_DAMAGE_TYPE)
            {
                _loc_15 = param1.width;
                _loc_16 = param1.height;
                param1.alpha = 0;
                _loc_21 = Math.random() * 30 + 30;
                _loc_22 = Math.random() * 60 + 15;
                switch(param5)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    {
                        _loc_17 = param6 * Math.cos(_loc_21 * Math.PI / 180);
                        _loc_18 = (-param6) * Math.sin(_loc_21 * Math.PI / 180);
                        _loc_19 = 35 * Math.SQRT1_2;
                        _loc_20 = -35 * Math.SQRT1_2;
                        break;
                    }
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    {
                        _loc_17 = (-param6) * Math.cos(_loc_21 * Math.PI / 180);
                        _loc_18 = (-param6) * Math.sin(_loc_21 * Math.PI / 180);
                        _loc_19 = -35 * Math.SQRT1_2;
                        _loc_20 = -35 * Math.SQRT1_2;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_25 = 120;
                switch(param5)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    {
                        _loc_23 = _loc_25 * Math.cos(_loc_22 * Math.PI / 180);
                        _loc_24 = (-_loc_25) * Math.sin(_loc_22 * Math.PI / 180);
                        break;
                    }
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    {
                        _loc_23 = (-_loc_25) * Math.cos(_loc_22 * Math.PI / 180);
                        _loc_24 = (-_loc_25) * Math.sin(_loc_22 * Math.PI / 180);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_10.append(new TweenLite(param1, 0.1, {onComplete:onComplete1, onCompleteParams:[param1]}));
                _loc_10.append(new TweenLite(param1, MONSTER_DAMAGE_EFFECT_DURING1, {scaleX:1, scaleY:1, x:_loc_8 + _loc_17, y:_loc_9 + _loc_18}));
                _loc_10.append(new TweenLite(param1, 0.1, {scaleX:1.2, scaleY:1.2, x:_loc_8 + _loc_17 - _loc_15 * 0.1, y:_loc_9 + _loc_18 - _loc_16 * 0.1}));
                _loc_10.append(new TweenLite(param1, 0.1, {scaleX:1, scaleY:1, x:_loc_8 + _loc_17, y:_loc_9 + _loc_18}));
                _loc_10.append(new TweenLite(param1, 0.3, {}));
                _loc_10.append(new TweenLite(param1, MONSTER_DAMAGE_EFFECT_DURING3, {scaleX:1, scaleY:1, x:_loc_8 + _loc_17 + _loc_23, y:_loc_9 + _loc_18 + _loc_24, alpha:0, onComplete:onComplete, onCompleteParams:[param1, _loc_8, _loc_9]}));
            }
            return;
        }// end function

        private static function onComplete1(param1:DisplayObject) : void
        {
            param1.alpha = 1;
            return;
        }// end function

        private static function onComplete(param1:DisplayObject, param2:Number, param3:Number) : void
        {
            var _loc_4:* = 0;
            param1.x = param2;
            param1.y = param3;
            if (timeLineDic[param1])
            {
                TimelineLite(timeLineDic[param1]).setEnabled(false);
                timeLineDic[param1] = null;
                delete timeLineDic[param1];
                _loc_4 = mcList.indexOf(param1);
                if (_loc_4 != -1)
                {
                    mcList.splice(_loc_4, 1);
                }
            }
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
                if (param1 is ImgNumber)
                {
                    ObjectPool.CheckIn(param1);
                }
                if (param1 is (getDefinitionByName("fightMonsterMiss") as Class))
                {
                    ObjectPool.CheckIn(param1);
                }
                if (param1 is (getDefinitionByName("fightPlayerMiss") as Class))
                {
                    ObjectPool.CheckIn(param1);
                }
            }
            return;
        }// end function

    }
}
