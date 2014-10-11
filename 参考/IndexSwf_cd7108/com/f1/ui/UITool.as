package com.f1.ui
{
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class UITool extends Object
    {
        public static var FONT:String = "SimSun";
        public static const TF_POP_BOX_TITLE:TextFormat = new TextFormat(FONT, 14, 16755015, true);
        private static var tfMap:Dictionary = new Dictionary();
        private static const TF_BUTTON_BLUE_BIG:Object = {up:getTF(FONT, 12, 14543871, true), over:getTF(FONT, 12, 14543871, true), down:getTF(FONT, 12, 4344147, true), selected:getTF(FONT, 12, 16755012, true), disabled:getTF(FONT, 12, 11513775, true)};
        private static const TF_BUTTON_GOLD_BIG:Object = {up:getTF(FONT, 12, 16510687, true), over:getTF(FONT, 12, 16775150, true), down:getTF(FONT, 12, 7488295, true), selected:getTF(FONT, 12, 16755012, true), disabled:getTF(FONT, 12, 11513775, true)};
        private static const TF_BUTTON_GREEN_BIG:Object = {up:getTF(FONT, 12, 15990749, true), over:getTF(FONT, 12, 16187365, true), down:getTF(FONT, 12, 4938544, true), selected:getTF(FONT, 12, 16755012, true), disabled:getTF(FONT, 12, 11513775, true)};
        private static const TF_BUTTON_BLUE_BIG_SPECIAL:Object = {up:getTF(FONT, 12, 14543871, false), over:getTF(FONT, 12, 14543871, false), down:getTF(FONT, 12, 14543871, false), selected:getTF(FONT, 12, 16764028, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_GOLD_BIG_SPECIAL:Object = {up:getTF(FONT, 12, 16510687, false), over:getTF(FONT, 12, 16775150, false), down:getTF(FONT, 12, 7488295, false), selected:getTF(FONT, 12, 16755012, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_GREEN_BIG_SPECIAL:Object = {up:getTF(FONT, 12, 15990749, false), over:getTF(FONT, 12, 16187365, false), down:getTF(FONT, 12, 4938544, false), selected:getTF(FONT, 12, 16755012, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_UNDERLINE_BLUE:Object = {up:getTF(FONT, 12, 11911376, false), over:getTF(FONT, 12, 11911376, false), down:getTF(FONT, 12, 3883865, false), selected:getTF(FONT, 12, 3883865, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_UNDERLINE_GOLD:Object = {up:getTF(FONT, 12, 16377728, false), over:getTF(FONT, 12, 11911376, false), down:getTF(FONT, 12, 3883865, false), selected:getTF(FONT, 12, 3883865, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_UNDERLINE_GREEN:Object = {up:getTF(FONT, 12, 8965888, false), over:getTF(FONT, 12, 11911376, false), down:getTF(FONT, 12, 3883865, false), selected:getTF(FONT, 12, 3883865, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_BLUE_COMMON:Object = {up:getTF(FONT, 12, 7241104, false), over:getTF(FONT, 12, 14543871, false), down:getTF(FONT, 12, 4344147, false), selected:getTF(FONT, 12, 14543871, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_BLUE_SMALL:Object = {up:getTF(FONT, 12, 14543871, false), over:getTF(FONT, 12, 14543871, false), down:getTF(FONT, 12, 4344147, false), selected:getTF(FONT, 12, 16755012, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_BUTTON_GOLD_SMALL:Object = TF_BUTTON_BLUE_SMALL;
        private static const TF_BUTTON_GREEN_SMALL:Object = TF_BUTTON_BLUE_SMALL;
        private static const TF_RADIO_BUTTON:Object = TF_BUTTON_BLUE_SMALL;
        private static const TF_BUTTON_BLUE_MID_LONG:Object = {up:getTF(FONT, 12, 14543871, false), over:getTF(FONT, 12, 14543871, false, true), down:getTF(FONT, 12, 4344147, false), selected:getTF(FONT, 12, 16755012, false), disabled:getTF(FONT, 12, 11513775, false)};
        private static const TF_TAB_BUTTON_BIG:Object = {up:getTF(FONT, 12, 5660788, true), over:getTF(FONT, 12, 14543871, true), down:getTF(FONT, 12, 3094602, true), selected:getTF(FONT, 12, 16755012, true), disabled:getTF(FONT, 12, 11513775, true)};
        private static var tfsMap:Dictionary = initTfsMap();

        public function UITool()
        {
            return;
        }// end function

        private static function initTfsMap() : Dictionary
        {
            var _loc_1:* = new Dictionary();
            _loc_1["tab_button_blue"] = TF_TAB_BUTTON_BIG;
            _loc_1["button_blue_common"] = TF_BUTTON_BLUE_COMMON;
            _loc_1["button_blue_big"] = TF_BUTTON_BLUE_BIG;
            _loc_1["button_gold_big"] = TF_BUTTON_GOLD_BIG;
            _loc_1["button_green_big"] = TF_BUTTON_GREEN_BIG;
            _loc_1["button_blue_big_light"] = TF_BUTTON_BLUE_BIG_SPECIAL;
            _loc_1["button_gold_big_light"] = TF_BUTTON_GOLD_BIG_SPECIAL;
            _loc_1["button_green_big_light"] = TF_BUTTON_GREEN_BIG_SPECIAL;
            _loc_1["button_blue_small"] = TF_BUTTON_BLUE_SMALL;
            _loc_1["button_gold_small"] = TF_BUTTON_GOLD_SMALL;
            _loc_1["button_green_small"] = TF_BUTTON_GREEN_SMALL;
            _loc_1["button_underline_blue"] = TF_BUTTON_UNDERLINE_BLUE;
            _loc_1["button_underline_gold"] = TF_BUTTON_UNDERLINE_GOLD;
            _loc_1["button_underline_green"] = TF_BUTTON_UNDERLINE_GREEN;
            _loc_1["button_blue_mid_long"] = TF_BUTTON_BLUE_MID_LONG;
            _loc_1["button_radio"] = TF_RADIO_BUTTON;
            _loc_1["new_radio_button"] = TF_RADIO_BUTTON;
            return _loc_1;
        }// end function

        public static function wapperStyle(param1:BaseButton, param2:String = null) : BaseButton
        {
            var _loc_3:* = param1.getDisplay();
            var _loc_4:* = getStyleByType(_loc_3, param2);
            if (getStyleByType(_loc_3, param2) != null)
            {
                param1.setText(param1.getText());
            }
            return param1;
        }// end function

        public static function getStyleButton(param1, param2:Boolean = false, param3 = null, param4:String = null) : BaseButton
        {
            var _loc_5:* = new BaseButton(param1, param2, param3);
            return wapperStyle(_loc_5, param4);
        }// end function

        public static function getStyleByType(param1:DisplayObject, param2:String = null) : Object
        {
            var _loc_4:* = null;
            var _loc_3:* = getQualifiedClassName(param1);
            if (param2 != null)
            {
                _loc_4 = tfsMap[_loc_3 + "_" + param2];
            }
            if (!_loc_4)
            {
                _loc_4 = tfsMap[_loc_3];
            }
            return _loc_4;
        }// end function

        private static function getTF(param1:String, param2:int, param3:uint, param4:Boolean, param5:Boolean = false) : TextFormat
        {
            var _loc_6:* = param1 + param2 + param3 + param4 + param5;
            var _loc_7:* = tfMap[_loc_6];
            if (tfMap[_loc_6] == null)
            {
                _loc_7 = new TextFormat(param1, param2, param3, param4, null, param5);
                tfMap[_loc_6] = _loc_7;
            }
            return _loc_7;
        }// end function

    }
}
