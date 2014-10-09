package com.view.tipcell.equip
{
    import com.f1.ui.container.*;
    import com.util.*;
    import flash.text.*;

    public class DescribeItem extends BaseItem
    {
        private var _describeTxt:TextField;

        public function DescribeItem()
        {
            this._describeTxt = new TextField();
            _textFormat.leading = 3;
            this._describeTxt.defaultTextFormat = _textFormat;
            this._describeTxt.mouseEnabled = false;
            this._describeTxt.multiline = true;
            this._describeTxt.wordWrap = true;
            this._describeTxt.width = 215;
            this._describeTxt.autoSize = "left";
            this._describeTxt.textColor = PropUtil.GRAY;
            this._describeTxt.x = 0;
            this._describeTxt.y = 2;
            addChild(this._describeTxt);
            return;
        }// end function

        public function updateDesc(param1:String, param2:HBox) : void
        {
            this._describeTxt.htmlText = param1;
            addGapLine(this._describeTxt.y + this._describeTxt.height);
            param2.add(this);
            return;
        }// end function

    }
}
