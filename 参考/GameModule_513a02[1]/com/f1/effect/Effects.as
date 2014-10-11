package com.f1.effect
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import com.greensock.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class Effects extends BaseEventDispatcher
    {
        private var target:DisplayObject;
        private var tick:int = 1;
        private var oriX:int;
        private var oriY:int;
        private var time:uint;
        private var offsetX:uint;
        private var offsetY:uint;
        public static var brightnessFilter:Array = ColorFilter.brightness(50);

        public function Effects()
        {
            return;
        }// end function

        public static function ice(param1:DisplayObject) : ColorMatrixFilter
        {
            var _loc_4:* = null;
            var _loc_2:* = new Array();
            _loc_2 = _loc_2.concat([0, 0, 0, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0.4, 0, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0.6, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0, 1, 0]);
            var _loc_3:* = new ColorMatrixFilter(_loc_2);
            if (param1.filters != null && param1.filters is Array)
            {
                _loc_4 = param1.filters;
                _loc_4.push(_loc_3);
                param1.filters = _loc_4;
            }
            else
            {
                param1.filters = [_loc_3];
            }
            return _loc_3;
        }// end function

        private static function addFilter() : void
        {
            return;
        }// end function

        public static function blin(param1:DisplayObject, param2:uint = 1) : void
        {
            param1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 200, 200, 200);
            TweenLite.to(param1, 0.2, {colorTransform:{tint:null, brightness:1}});
            return;
        }// end function

        public static function flash(param1:Object, param2:Number = 1, param3:Number = 0.5, param4:Number = 0.1, param5:uint = 0, param6:uint = 0, param7:int = 3, param8:Function = null, param9:Array = null) : void
        {
            var oriX:Number;
            var oriY:Number;
            var s1:Number;
            var mc:* = param1;
            var scale:* = param2;
            var alpha:* = param3;
            var inter:* = param4;
            var offsetX:* = param5;
            var offsetY:* = param6;
            var time:* = param7;
            var completeFun:* = param8;
            var completeParams:* = param9;
            if (!mc)
            {
                return;
            }
            oriX = mc.x;
            oriY = mc.y;
            var oriScaleX:* = mc.scaleX;
            var oriScaleY:* = mc.scaleY;
            var x1:* = mc.x;
            var y1:* = mc.y;
            if (scale > 1)
            {
                s1 = Math.abs(oriScaleX - scale) / 2;
                x1 = oriX - mc.width * s1;
                y1 = oriY - mc.height * s1;
            }
            TweenLite.killTweensOf(mc);
            var obj1:Object;
            var obj2:Object;
            var timeline:* = new TimelineMax();
            timeline.append(new TweenLite(mc, inter, obj1));
            timeline.append(new TweenLite(mc, inter, obj2));
            timeline.repeat = time - 1;
            timeline.play();
            timeline.addEventListener(TweenEvent.COMPLETE, function (event:Event) : void
            {
                mc.x = oriX;
                mc.y = oriY;
                if (completeFun != null)
                {
                    completeFun.apply(null, completeParams);
                }
                return;
            }// end function
            );
            return;
        }// end function

        public static function flashNumText(param1:TextField, param2:Boolean, param3:String, param4:uint = 16777215) : TimelineMax
        {
            var textField:* = param1;
            var isUp:* = param2;
            var finalValStr:* = param3;
            var oriColor:* = param4;
            var setColor:* = function (param1:TextField, param2:uint) : void
            {
                param1.textColor = param2;
                return;
            }// end function
            ;
            if (!textField)
            {
                return null;
            }
            var showColor:uint;
            if (isUp)
            {
                showColor;
            }
            else
            {
                showColor;
            }
            var inter:Number;
            var repeatTime:uint;
            var obj1:Object;
            var obj2:Object;
            TweenLite.killTweensOf(textField);
            var timeline:* = new TimelineMax();
            timeline.append(new TweenLite(textField, inter, obj1));
            timeline.append(new TweenLite(textField, inter, obj2));
            timeline.repeat = repeatTime;
            timeline.play();
            timeline.addEventListener(TweenEvent.COMPLETE, function (event:Event) : void
            {
                textField.textColor = oriColor;
                textField.text = finalValStr;
                return;
            }// end function
            );
            return timeline;
        }// end function

        public static function textBubble(param1:DisplayObject, param2:String, param3:uint, param4:Boolean = true) : void
        {
            if (!param1)
            {
                return;
            }
            return;
        }// end function

    }
}
