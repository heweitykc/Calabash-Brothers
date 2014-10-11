package com.game.artifact.util
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.artifact.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactUiUtil extends Object
    {

        public function ArtifactUiUtil()
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

        public static function getButton(param1:Component, param2:String, param3:Function = null)
        {
            var _loc_4:* = param1.getDisplayChildByName(param2);
            if (param3 != null)
            {
                _loc_4.addEventListener(MouseEvent.CLICK, param3);
            }
            return _loc_4;
        }// end function

        public static function getTextFields(param1:Component, param2:String, param3:uint) : Vector.<TextField>
        {
            var _loc_5:* = null;
            var _loc_4:* = new Vector.<TextField>;
            var _loc_6:* = 0;
            while (_loc_6 < param3)
            {
                
                _loc_5 = param1.getDisplayChildByName(param2 + _loc_6);
                _loc_4.push(_loc_5);
                _loc_6 = _loc_6 + 1;
            }
            return _loc_4;
        }// end function

        public static function createDownListBox(param1:Component, param2:String, param3:Array, param4:Function = null, param5:uint = 0) : ArtifactDownListBox
        {
            var _loc_12:* = null;
            var _loc_6:* = param1.getDisplayChildByName(param2 + "_label");
            var _loc_7:* = new BaseButton(param1.getDisplayChildByName(param2 + "_button"));
            var _loc_8:* = param1.getDisplayChildByName(param2 + "_list");
            var _loc_9:* = param1.getDisplayChildByName(param2 + "_bg");
            var _loc_10:* = new ArtifactDownListBox(_loc_9, _loc_6, _loc_7, _loc_8);
            var _loc_11:* = new Array();
            for each (_loc_12 in param3)
            {
                
                _loc_11.push({label:_loc_12});
            }
            _loc_10.dataProvider = _loc_11;
            _loc_10.selectIndex = param5;
            if (param4 != null)
            {
                _loc_10.getListView().addEventListener(Event.CHANGE, param4);
            }
            return _loc_10;
        }// end function

    }
}
