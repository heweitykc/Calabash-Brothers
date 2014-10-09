package com.game.historymsg.util
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class HistorymsgUiUtil extends Object
    {

        public function HistorymsgUiUtil()
        {
            return;
        }// end function

        public static function createButton(param1:Component, param2:String, param3:Function = null) : BaseButton
        {
            var _loc_4:* = new BaseButton(param1.getDisplayChildByName(param2));
            if (param3 != null)
            {
                _loc_4.addEventListener(MouseEvent.CLICK, param3);
            }
            return _loc_4;
        }// end function

        public static function createButtonWithExtraLabel(param1:Component, param2:String, param3:Function = null) : BaseButton
        {
            var _loc_4:* = new BaseButton(param1.getDisplayChildByName(param2));
            if (param3 != null)
            {
                _loc_4.addEventListener(MouseEvent.CLICK, param3);
            }
            var _loc_5:* = param1.getDisplayChildByName(param2 + "_label");
            if (param1.getDisplayChildByName(param2 + "_label") is InteractiveObject)
            {
                (_loc_5 as InteractiveObject).mouseEnabled = false;
            }
            if (_loc_5 is DisplayObjectContainer)
            {
                (_loc_5 as DisplayObjectContainer).mouseChildren = false;
            }
            _loc_5.x = (_loc_4.width - _loc_5.width) / 2;
            _loc_5.y = (_loc_4.height - _loc_5.height) / 2;
            _loc_4.addChild(_loc_5);
            return _loc_4;
        }// end function

        public static function getTitleTextField(param1:Component, param2:String) : TextField
        {
            return (param1.getDisplayChildByName(param2) as Sprite).getChildByName("txt") as TextField;
        }// end function

    }
}
