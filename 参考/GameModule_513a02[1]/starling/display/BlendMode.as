﻿package starling.display
{
    import flash.display3D.*;
    import starling.errors.*;

    public class BlendMode extends Object
    {
        private static var sBlendFactors:Array = [{none:[Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO], normal:[Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA], add:[Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.DESTINATION_ALPHA], multiply:[Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA], screen:[Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE], erase:[Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA]}, {none:[Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO], normal:[Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA], add:[Context3DBlendFactor.ONE, Context3DBlendFactor.ONE], multiply:[Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA], screen:[Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR], erase:[Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA]}];
        public static const AUTO:String = "auto";
        public static const NONE:String = "none";
        public static const NORMAL:String = "normal";
        public static const ADD:String = "add";
        public static const MULTIPLY:String = "multiply";
        public static const SCREEN:String = "screen";
        public static const ERASE:String = "erase";

        public function BlendMode()
        {
            throw new AbstractClassError();
        }// end function

        public static function getBlendFactors(param1:String, param2:Boolean = true) : Array
        {
            var _loc_3:* = sBlendFactors[int(param2)];
            if (param1 in _loc_3)
            {
                return _loc_3[param1];
            }
            throw new ArgumentError("Invalid blend mode");
        }// end function

        public static function register(param1:String, param2:String, param3:String, param4:Boolean = true) : void
        {
            var _loc_5:* = sBlendFactors[int(param4)];
            _loc_5[param1] = [param2, param3];
            var _loc_6:* = sBlendFactors[int(!param4)];
            if (!(param1 in _loc_6))
            {
                _loc_6[param1] = [param2, param3];
            }
            return;
        }// end function

    }
}
