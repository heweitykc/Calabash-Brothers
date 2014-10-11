package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class BindItem extends BaseItem
    {
        private var _bindTxt:TextField;
        private var _bindIcon:Bitmap;

        public function BindItem()
        {
            this._bindTxt = new TextField();
            this._bindTxt.textColor = 16711680;
            _textFormat = this._bindTxt.defaultTextFormat;
            this._bindTxt.defaultTextFormat = _textFormat;
            this._bindTxt.autoSize = "left";
            this._bindTxt.text = LanguageCfgObj.getInstance().getByIndex("10172");
            this._bindTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            addChild(this._bindTxt);
            this._bindIcon = ToolKit.getNewDO("bindIcon") as Bitmap;
            this._bindIcon.x = this._bindTxt.x + this._bindTxt.width + 5;
            this._bindIcon.y = 2;
            addChild(this._bindIcon);
            addGapLine(height);
            return;
        }// end function

    }
}
