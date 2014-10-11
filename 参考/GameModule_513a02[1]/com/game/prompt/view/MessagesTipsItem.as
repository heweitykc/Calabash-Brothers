package com.game.prompt.view
{
    import com.f1.*;
    import flash.text.*;

    public class MessagesTipsItem extends TextField
    {
        private var _lineWidth:int;

        public function MessagesTipsItem()
        {
            var _loc_1:* = defaultTextFormat;
            _loc_1.font = "SimSun";
            _loc_1.leading = 2;
            defaultTextFormat = _loc_1;
            textColor = 16766079;
            filters = [FrameworkGlobal.BLACK_FILTER];
            multiline = true;
            wordWrap = true;
            return;
        }// end function

        public function get lineWidth() : int
        {
            return this._lineWidth;
        }// end function

        public function set lineWidth(param1:int) : void
        {
            this._lineWidth = param1;
            width = this._lineWidth;
            return;
        }// end function

    }
}
