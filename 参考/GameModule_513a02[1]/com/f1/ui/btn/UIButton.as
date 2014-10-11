package com.f1.ui.btn
{
    import flash.filters.*;
    import flash.text.*;

    public class UIButton extends BaseButton
    {

        public function UIButton(param1 = null, param2:Boolean = false, param3 = null)
        {
            super(param1, param2, param3);
            _labelTxt = new TextField();
            _labelTxt.height = 20;
            _labelTxt.mouseEnabled = false;
            _labelTxt.selectable = false;
            _labelTxt.width = display.width;
            _labelTxt.y = 3;
            _labelTxt.filters = [new GlowFilter(0, 1, 3, 3)];
            addChild(_labelTxt);
            _labelTxt.defaultTextFormat = new TextFormat(null, 12, 16771767, null, null, null, null, null, "center");
            return;
        }// end function

        override protected function initLabel() : void
        {
            setText(label);
            return;
        }// end function

    }
}
