package com.view.tipcell
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class CurrencyTips extends BaseTips
    {
        protected var _backImg:Sprite;
        protected var _iconBg:Sprite;
        protected var _nameTxt:TextField;
        protected var _content:Sprite;
        protected var _image:Image;
        protected var _countTxt:TextField;
        protected var _excisionLine:Bitmap;

        public function CurrencyTips()
        {
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this._image = new Image();
            this._image.smoothing = true;
            this._image.x = 3;
            this._image.y = 13;
            this._content.addChild(this._image);
            this._nameTxt = new TextField();
            this._nameTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._nameTxt.width = 150;
            this._nameTxt.height = 20;
            var _loc_1:* = this._nameTxt.defaultTextFormat;
            _loc_1.font = "simsun";
            _loc_1.size = 14;
            _loc_1.color = 16748800;
            _loc_1.align = "left";
            this._nameTxt.x = 70;
            this._nameTxt.y = 30;
            this._nameTxt.defaultTextFormat = _loc_1;
            this._content.addChild(this._nameTxt);
            this._excisionLine = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine.x = 0;
            this._excisionLine.y = this._image.y + 55;
            this._content.addChild(this._excisionLine);
            this._countTxt = new TextField();
            this._countTxt.y = this._excisionLine.y + this._excisionLine.height + 5;
            this._countTxt.textColor = 16777215;
            this._countTxt.autoSize = "left";
            this._content.addChild(this._countTxt);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            this._image.load(param1.url);
            this._nameTxt.text = param1.q_name || "";
            this._countTxt.text = param1.q_name + LanguageCfgObj.getInstance().getByIndex("11788") + param1.num;
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 34 + this._content.height;
            return;
        }// end function

    }
}
