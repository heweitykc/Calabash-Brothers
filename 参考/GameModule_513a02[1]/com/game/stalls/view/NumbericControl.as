package com.game.stalls.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import flash.events.*;
    import flash.text.*;

    public class NumbericControl extends Component
    {
        private var _txt:TextField;
        private var _max:int;
        private var _min:int;
        private var _addBtn:BaseButton;
        private var _subBtn:BaseButton;
        private var _textWidth:int;
        private var _value:int;

        public function NumbericControl(param1 = null)
        {
            super(param1);
            super.initComponentUI(param1);
            this.initUI();
            this._addBtn.addEvtListener(MouseEvent.CLICK, this.__addClick);
            this._subBtn.addEvtListener(MouseEvent.CLICK, this.__subClick);
            this._txt.addEventListener(FocusEvent.FOCUS_OUT, this.__change);
            return;
        }// end function

        public function get txt() : TextField
        {
            return this._txt;
        }// end function

        public function set txt(param1:TextField) : void
        {
            this._txt = param1;
            return;
        }// end function

        private function __change(event:FocusEvent) : void
        {
            var _loc_2:* = int(this._txt.text);
            _loc_2 = Math.max(this._min, _loc_2);
            _loc_2 = Math.min(_loc_2, this._max);
            this._value = _loc_2;
            this._txt.text = this._value.toString();
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function get textWidth() : int
        {
            return this._textWidth;
        }// end function

        public function set textWidth(param1:int) : void
        {
            this._textWidth = param1;
            this._txt.width = param1;
            this.update();
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName("txt_count");
            this._txt.width = 40;
            this._txt.restrict = "0-9";
            this._txt.type = "input";
            this._addBtn = new BaseButton(getDisplayChildByName("btn_add"));
            this._subBtn = new BaseButton(getDisplayChildByName("btn_sub"));
            return;
        }// end function

        private function __subClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.value - 1;
            _loc_2.value = _loc_3;
            this.value = Math.max(this._min, this.value);
            return;
        }// end function

        private function __addClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this.value + 1;
            _loc_2.value = _loc_3;
            this.value = Math.min(this._value, this._max);
            return;
        }// end function

        private function update() : void
        {
            this._addBtn.x = this._txt.width + 3;
            this._subBtn.x = this._addBtn.x + this._addBtn.width + 3;
            return;
        }// end function

        public function set value(param1:int) : void
        {
            param1 = Math.max(this._min, param1);
            param1 = Math.min(param1, this._max);
            this._value = param1;
            this._txt.text = this._value.toString();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get max() : int
        {
            return this._max;
        }// end function

        public function set max(param1:int) : void
        {
            this._max = param1;
            return;
        }// end function

    }
}
