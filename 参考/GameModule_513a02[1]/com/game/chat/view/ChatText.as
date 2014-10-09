package com.game.chat.view
{
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.text.*;

    public class ChatText extends Object
    {
        private var _text:String;
        private var _prop:PropInfo;

        public function ChatText(param1:PropInfo)
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._prop = param1;
            if (param1 is EquipmentInfo)
            {
                _loc_2 = PropUtil.getEquipColor(param1);
                _loc_3 = PropUtil.getEquipName(param1, false, false);
                this._text = StringUtil.formatString("<font color=\'#{0}\'>[{1}]</font>", _loc_2.toString(16), _loc_3);
            }
            else if (param1 is PropInfo)
            {
                this._text = "<font color=\'#" + PropUtil.getPropColor(param1.q_quality_lv).toString(16) + "\'>[" + param1.q_name + "]</font>";
            }
            return;
        }// end function

        public function get prop() : PropInfo
        {
            return this._prop;
        }// end function

        public function set prop(param1:PropInfo) : void
        {
            this._prop = param1;
            return;
        }// end function

        public function toText() : String
        {
            return this._text;
        }// end function

        public function text() : String
        {
            var _loc_1:* = new TextField();
            _loc_1.htmlText = this._text;
            return _loc_1.text;
        }// end function

    }
}
