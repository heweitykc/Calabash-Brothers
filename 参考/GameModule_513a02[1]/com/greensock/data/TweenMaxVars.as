package com.greensock.data
{
    import com.greensock.*;
    import com.greensock.motionPaths.*;
    import flash.display.*;
    import flash.geom.*;

    public class TweenMaxVars extends Object
    {
        protected var _vars:Object;
        public static const version:Number = 5.1;

        public function TweenMaxVars(param1:Object = null)
        {
            var _loc_2:* = null;
            this._vars = {};
            if (param1 != null)
            {
                for (_loc_2 in param1)
                {
                    
                    this._vars[_loc_2] = _loc_4[_loc_2];
                }
            }
            if (TweenLite.version < 11.4)
            {
            }
            return;
        }// end function

        protected function _set(param1:String, param2, param3:Boolean = false) : TweenMaxVars
        {
            if (param2 == null)
            {
                delete this._vars[param1];
            }
            else
            {
                this._vars[param1] = param2;
            }
            if (param3 && !(param1 in TweenLite.plugins))
            {
            }
            return this;
        }// end function

        public function prop(param1:String, param2:Number, param3:Boolean = false) : TweenMaxVars
        {
            return this._set(param1, param3 ? (String(param2)) : (param2));
        }// end function

        public function data(param1) : TweenMaxVars
        {
            return this._set("data", param1);
        }// end function

        public function delay(param1:Number) : TweenMaxVars
        {
            return this._set("delay", param1);
        }// end function

        public function ease(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("easeParams", param2);
            return this._set("ease", param1);
        }// end function

        public function immediateRender(param1:Boolean) : TweenMaxVars
        {
            return this._set("immediateRender", param1, false);
        }// end function

        public function onComplete(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onCompleteParams", param2);
            return this._set("onComplete", param1);
        }// end function

        public function onCompleteListener(param1:Function) : TweenMaxVars
        {
            return this._set("onCompleteListener", param1);
        }// end function

        public function onInit(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onInitParams", param2);
            return this._set("onInit", param1);
        }// end function

        public function onStart(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onStartParams", param2);
            return this._set("onStart", param1);
        }// end function

        public function onStartListener(param1:Function) : TweenMaxVars
        {
            return this._set("onStartListener", param1);
        }// end function

        public function onUpdate(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onUpdateParams", param2);
            return this._set("onUpdate", param1);
        }// end function

        public function onUpdateListener(param1:Function) : TweenMaxVars
        {
            return this._set("onUpdateListener", param1);
        }// end function

        public function onRepeat(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onRepeatParams", param2);
            return this._set("onRepeat", param1);
        }// end function

        public function onReverseComplete(param1:Function, param2:Array = null) : TweenMaxVars
        {
            this._set("onReverseCompleteParams", param2);
            return this._set("onReverseComplete", param1);
        }// end function

        public function onReverseCompleteListener(param1:Function) : TweenMaxVars
        {
            return this._set("onReverseCompleteListener", param1);
        }// end function

        public function overwrite(param1:int) : TweenMaxVars
        {
            return this._set("overwrite", param1, false);
        }// end function

        public function paused(param1:Boolean) : TweenMaxVars
        {
            return this._set("paused", param1, false);
        }// end function

        public function repeat(param1:int) : TweenMaxVars
        {
            return this._set("repeat", param1);
        }// end function

        public function repeatDelay(param1:Number) : TweenMaxVars
        {
            return this._set("repeatDelay", param1);
        }// end function

        public function reversed(param1:Boolean) : TweenMaxVars
        {
            return this._set("reversed", param1);
        }// end function

        public function runBackwards(param1:Boolean) : TweenMaxVars
        {
            return this._set("runBackwards", param1, false);
        }// end function

        public function timeScale(param1:Number) : TweenMaxVars
        {
            return this._set("timeScale", param1, false);
        }// end function

        public function useFrames(param1:Boolean) : TweenMaxVars
        {
            return this._set("useFrames", param1, false);
        }// end function

        public function startAt(param1:TweenMaxVars) : TweenMaxVars
        {
            return this._set("repeatDelay", param1);
        }// end function

        public function yoyo(param1:Boolean) : TweenMaxVars
        {
            return this._set("yoyo", param1);
        }// end function

        public function autoAlpha(param1:Number) : TweenMaxVars
        {
            return this._set("autoAlpha", param1, true);
        }// end function

        public function bevelFilter(param1:Number = 4, param2:Number = 45, param3:uint = 16777215, param4:Number = 0.5, param5:uint = 0, param6:Number = 0.5, param7:Number = 4, param8:Number = 4, param9:Number = 1, param10:int = 2, param11:Boolean = false, param12:Boolean = false, param13:int = -1) : TweenMaxVars
        {
            var _loc_14:* = {distance:param1, angle:param2, highlightColor:param3, highlightAlpha:param4, shadowColor:param5, shadowAlpha:param6, blurX:param7, blurY:param8, strength:param9, quality:param10, addFilter:param12, remove:param11};
            if (param13 > -1)
            {
                _loc_14.index = param13;
            }
            return this._set("bevelFilter", _loc_14, true);
        }// end function

        public function bezier(param1:Array) : TweenMaxVars
        {
            return this._set("bezier", param1, true);
        }// end function

        public function bezierThrough(param1:Array) : TweenMaxVars
        {
            return this._set("bezierThrough", param1, true);
        }// end function

        public function blurFilter(param1:Number, param2:Number, param3:int = 2, param4:Boolean = false, param5:Boolean = false, param6:int = -1) : TweenMaxVars
        {
            var _loc_7:* = {blurX:param1, blurY:param2, quality:param3, addFilter:param5, remove:param4};
            if (param6 > -1)
            {
                _loc_7.index = param6;
            }
            return this._set("blurFilter", _loc_7, true);
        }// end function

        public function circlePath2D(param1:MotionPath, param2:Number, param3:Number, param4:Boolean = false, param5:String = "clockwise", param6:uint = 0, param7:Number = 0, param8:Boolean = false) : TweenMaxVars
        {
            return this._set("circlePath2D", {path:param1, startAngle:param2, endAngle:param3, autoRotate:param4, direction:param5, extraRevolutions:param6, rotationOffset:param7, useRadians:param8}, true);
        }// end function

        public function colorMatrixFilter(param1:uint = 16777215, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 0, param7:Number = -1, param8:Boolean = false, param9:Boolean = false, param10:int = -1) : TweenMaxVars
        {
            var _loc_11:* = {saturation:param3, contrast:param4, brightness:param5, hue:param6, addFilter:param9, remove:param8};
            if (param1 != 16777215)
            {
                _loc_11.colorize = param1;
                _loc_11.amount = param2;
            }
            if (param7 > -1)
            {
                _loc_11.threshold = param7;
            }
            if (param10 > -1)
            {
                _loc_11.index = param10;
            }
            return this._set("colorMatrixFilter", _loc_11, true);
        }// end function

        public function colorTransform(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN, param7:Number = NaN, param8:Number = NaN, param9:Number = NaN, param10:Number = NaN, param11:Number = NaN, param12:Number = NaN) : TweenMaxVars
        {
            var _loc_14:* = null;
            var _loc_13:* = {tint:param1, tintAmount:isNaN(param1) ? (NaN) : (param2), exposure:param3, brightness:param4, redMultiplier:param5, greenMultiplier:param6, blueMultiplier:param7, alphaMultiplier:param8, redOffset:param9, greenOffset:param10, blueOffset:param11, alphaOffset:param12};
            for (_loc_14 in _loc_13)
            {
                
                if (isNaN(_loc_13[_loc_14]))
                {
                    delete _loc_13[_loc_14];
                }
            }
            return this._set("colorTransform", _loc_13, true);
        }// end function

        public function dropShadowFilter(param1:Number = 4, param2:Number = 4, param3:Number = 4, param4:Number = 1, param5:Number = 45, param6:uint = 0, param7:Number = 2, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:uint = 2, param12:Boolean = false, param13:Boolean = false, param14:int = -1) : TweenMaxVars
        {
            var _loc_15:* = {distance:param1, blurX:param2, blurY:param3, alpha:param4, angle:param5, color:param6, strength:param7, inner:param8, knockout:param9, hideObject:param10, quality:param11, addFilter:param13, remove:param12};
            if (param14 > -1)
            {
                _loc_15.index = param14;
            }
            return this._set("dropShadowFilter", _loc_15, true);
        }// end function

        public function dynamicProps(param1:Object, param2:Object = null) : TweenMaxVars
        {
            if (param2 != null)
            {
                param1.params = param2;
            }
            return this._set("dynamicProps", param1, true);
        }// end function

        public function endArray(param1:Array) : TweenMaxVars
        {
            return this._set("endArray", param1, true);
        }// end function

        public function frame(param1:int, param2:Boolean = false) : TweenMaxVars
        {
            return this._set("frame", param2 ? (String(param1)) : (param1), true);
        }// end function

        public function frameBackward(param1:int) : TweenMaxVars
        {
            return this._set("frameBackward", param1, true);
        }// end function

        public function frameForward(param1:int) : TweenMaxVars
        {
            return this._set("frameForward", param1, true);
        }// end function

        public function frameLabel(param1:String) : TweenMaxVars
        {
            return this._set("frameLabel", param1, true);
        }// end function

        public function glowFilter(param1:Number = 10, param2:Number = 10, param3:uint = 16777215, param4:Number = 1, param5:Number = 2, param6:Boolean = false, param7:Boolean = false, param8:uint = 2, param9:Boolean = false, param10:Boolean = false, param11:int = -1) : TweenMaxVars
        {
            var _loc_12:* = {blurX:param1, blurY:param2, color:param3, alpha:param4, strength:param5, inner:param6, knockout:param7, quality:param8, addFilter:param10, remove:param9};
            if (param11 > -1)
            {
                _loc_12.index = param11;
            }
            return this._set("glowFilter", _loc_12, true);
        }// end function

        public function hexColors(param1:Object) : TweenMaxVars
        {
            return this._set("hexColors", param1, true);
        }// end function

        public function motionBlur(param1:Number = 1, param2:Boolean = false, param3:int = 2, param4:int = 10) : TweenMaxVars
        {
            return this._set("motionBlur", {strength:param1, fastMode:param2, quality:param3, padding:param4}, true);
        }// end function

        public function orientToBezier(param1:Object = null) : TweenMaxVars
        {
            return this._set("orientToBezier", param1 == null ? (true) : (param1), false);
        }// end function

        public function physics2D(param1:Number, param2:Number, param3:Number = 0, param4:Number = 90, param5:Number = 0) : TweenMaxVars
        {
            return this._set("physics2D", {velocity:param1, angle:param2, acceleration:param3, accelerationAngle:param4, friction:param5}, true);
        }// end function

        public function physicsProps(param1:Object) : TweenMaxVars
        {
            return this._set("physicsProps", param1, true);
        }// end function

        public function quaternions(param1:Object) : TweenMaxVars
        {
            return this._set("quaternions", param1, true);
        }// end function

        public function removeTint(param1:Boolean = true) : TweenMaxVars
        {
            return this._set("removeTint", param1, true);
        }// end function

        public function roundProps(param1:Array) : TweenMaxVars
        {
            return this._set("roundProps", param1, true);
        }// end function

        public function scrollRect(param1:Object) : TweenMaxVars
        {
            return this._set("scrollRect", param1, true);
        }// end function

        public function setSize(param1:Number = NaN, param2:Number = NaN) : TweenMaxVars
        {
            var _loc_3:* = {};
            if (!isNaN(param1))
            {
                _loc_3.width = param1;
            }
            if (!isNaN(param2))
            {
                _loc_3.height = param2;
            }
            return this._set("setSize", _loc_3, true);
        }// end function

        public function shortRotation(param1:Object) : TweenMaxVars
        {
            if (typeof(param1) == "number")
            {
                param1 = {rotation:param1};
            }
            return this._set("shortRotation", param1, true);
        }// end function

        public function soundTransform(param1:Number = 1, param2:Number = 0, param3:Number = 1, param4:Number = 0, param5:Number = 0, param6:Number = 1) : TweenMaxVars
        {
            return this._set("soundTransform", {volume:param1, pan:param2, leftToLeft:param3, leftToRight:param4, rightToLeft:param5, rightToRight:param6}, true);
        }// end function

        public function stageQuality(param1:Stage, param2:String = "medium", param3:String = null) : TweenMaxVars
        {
            if (param3 == null)
            {
                param3 = param1.quality;
            }
            return this._set("stageQuality", {stage:param1, during:param2, after:param3}, true);
        }// end function

        public function tint(param1:uint) : TweenMaxVars
        {
            return this._set("tint", param1, true);
        }// end function

        public function transformAroundCenter(param1:Object) : TweenMaxVars
        {
            return this._set("transformAroundCenter", param1, true);
        }// end function

        public function transformAroundPoint(param1:Point, param2:Object) : TweenMaxVars
        {
            param2.point = param1;
            return this._set("transformAroundPoint", param2, true);
        }// end function

        public function transformMatrix(param1:Object) : TweenMaxVars
        {
            return this._set("transformMatrix", param1, true);
        }// end function

        public function visible(param1:Boolean) : TweenMaxVars
        {
            return this._set("visible", param1, true);
        }// end function

        public function volume(param1:Number) : TweenMaxVars
        {
            return this._set("volume", param1, true);
        }// end function

        public function get vars() : Object
        {
            return this._vars;
        }// end function

        public function get isGSVars() : Boolean
        {
            return true;
        }// end function

    }
}
