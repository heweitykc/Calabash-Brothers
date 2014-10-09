package com.game.country.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class CountryGainAwardTips extends BaseTips
    {
        private var _backBmp:Sprite;
        private var _iconBg:Sprite;
        private var _txtTitle:TextField;
        private var _nameTxt:TextField;
        private var _image:IconItem;
        private var _txtPrival:TextField;
        private var _txtPrivalDes:TextField;
        private var _txtBannel:TextField;
        private var _content:Sprite;
        private var awardID:int = 200058;

        public function CountryGainAwardTips()
        {
            this._backBmp = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backBmp);
            this._content = new Sprite();
            this._content.x = 10;
            this._content.y = 10;
            addChild(this._content);
            this._txtTitle = new TextField();
            this._txtTitle.width = 210;
            this._txtTitle.height = 20;
            this._txtTitle.x = 10;
            this._txtTitle.y = 5;
            this._txtTitle.autoSize = "center";
            this._txtTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10571");
            this._content.addChild(this._txtTitle);
            this._nameTxt = new TextField();
            this._nameTxt.multiline = true;
            this._nameTxt.width = 105;
            this._nameTxt.x = 80;
            this._nameTxt.y = 40;
            var _loc_1:* = this._nameTxt.defaultTextFormat;
            _loc_1.align = "left";
            _loc_1.leading = 1;
            this._nameTxt.defaultTextFormat = _loc_1;
            this._content.addChild(this._nameTxt);
            var _loc_2:* = LanguageCfgObj.getInstance().getByIndex("11971");
            this._nameTxt.htmlText = _loc_2;
            this._iconBg = ToolKit.getNew("itemtipsborder");
            this._iconBg.x = 0;
            this._iconBg.y = 40;
            this._content.addChild(this._iconBg);
            this._image = new IconItem("");
            this._image.x = 1;
            this._image.y = 1;
            this._image.setWH(56, 56);
            this._image.setImageSize(56, 56);
            var _loc_3:* = new PropInfo();
            _loc_3.convByCfg(this.awardID);
            this._image.setInfo(_loc_3);
            this._iconBg.addChild(this._image);
            this._txtPrival = new TextField();
            this._txtPrival.width = 200;
            this._txtPrival.height = 20;
            this._txtPrival.x = 10;
            this._txtPrival.y = this._iconBg.y + 80;
            this._txtPrival.htmlText = LanguageCfgObj.getInstance().getByIndex("10572");
            this._content.addChild(this._txtPrival);
            this._txtPrivalDes = new TextField();
            this._txtPrivalDes.width = 200;
            this._txtPrivalDes.multiline = true;
            this._txtPrivalDes.htmlText = LanguageCfgObj.getInstance().getByIndex("10573");
            this._txtPrivalDes.x = 10;
            this._txtPrivalDes.y = this._txtPrival.y + this._txtPrival.height + 5;
            this._content.addChild(this._txtPrivalDes);
            this._txtBannel = new TextField();
            this._txtBannel.width = 200;
            this._txtBannel.height = 20;
            this._txtBannel.htmlText = LanguageCfgObj.getInstance().getByIndex("10574");
            this._txtBannel.x = 10;
            this._txtBannel.y = this._txtPrivalDes.y + this._txtPrivalDes.textHeight + 10;
            this._content.addChild(this._txtBannel);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            if (param1 == null)
            {
                return;
            }
            this._backBmp.height = this._content.height + 30;
            this._backBmp.width = this._content.width + 20;
            return;
        }// end function

    }
}
