package com.view.tipcell.equip
{
    import com.f1.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class BaseItem extends Sprite
    {
        protected var _textFormat:TextFormat;

        public function BaseItem()
        {
            this._textFormat = new TextFormat("SimSun", 12, 16748800, null, null, null, null, null, TextFormatAlign.LEFT, null, null, null, 1);
            return;
        }// end function

        protected function addGapPoint(param1:int, param2:int = 1) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param2)
            {
                
                _loc_4 = ToolKit.getNew("generalTextPoint") as Sprite;
                _loc_4.x = -15;
                _loc_4.y = (param1 + 1) + _loc_3 * 16;
                addChild(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        protected function addGapLine(param1:int) : Bitmap
        {
            var _loc_2:* = null;
            _loc_2 = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = -5;
            _loc_2.y = param1 + 8;
            addChild(_loc_2);
            return _loc_2;
        }// end function

    }
}
