package com.view.tipcell
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.text.*;

    public class ElementHeartTips extends BaseTips
    {
        private var _backImg:Sprite;
        private var _iconBg:Sprite;
        private var _nameTxt:TextField;
        private var _typeTxt:TextField;
        private var _effect:VMCView;
        private var _priceSp:Sprite;
        private var _lines:Array;
        private var _excisionLine:Bitmap;
        private var _limitTxt:TextField;
        private var _goldIcon:Bitmap;
        private var _content:Sprite;
        private var _count:int;
        private var _lockedtimeTxt:TextField;
        private var _highLockSp:Sprite;
        private var _professionTxt:TextField;
        private var textformat:TextFormat;
        private var _info:ElementHeartInfo;

        public function ElementHeartTips()
        {
            this._lines = [];
            this._lines = [];
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this._nameTxt = new TextField();
            this._nameTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._nameTxt.width = 215;
            this._nameTxt.height = 20;
            this.textformat = this._nameTxt.defaultTextFormat;
            this.textformat.font = "simsun";
            this.textformat.size = 14;
            this.textformat.color = 16748800;
            this.textformat.align = "left";
            this._nameTxt.defaultTextFormat = this.textformat;
            this._content.addChild(this._nameTxt);
            this._excisionLine = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine.x = 0;
            this._excisionLine.y = this._nameTxt.y + this._nameTxt.height + 5;
            this._content.addChild(this._excisionLine);
            this._iconBg = ToolKit.getNew("itemtipsborder");
            this._iconBg.x = 0;
            this._iconBg.y = this._excisionLine.y + this._excisionLine.height + 10;
            this._content.addChild(this._iconBg);
            this._typeTxt = new TextField();
            this.textformat = this._typeTxt.defaultTextFormat;
            this.textformat.leading = 3;
            this.textformat.font = "SimSun";
            this._typeTxt.defaultTextFormat = this.textformat;
            this._typeTxt.x = this._iconBg.x + this._iconBg.width + 10;
            this._typeTxt.y = this._iconBg.y + 10;
            this._typeTxt.textColor = PropUtil.GREEN;
            this._content.addChild(this._typeTxt);
            this.textformat.font = "SimSun";
            this._professionTxt = new TextField();
            this.textformat = this._professionTxt.defaultTextFormat;
            this.textformat.font = "SimSun";
            this._professionTxt.defaultTextFormat = this.textformat;
            this._professionTxt.x = this._typeTxt.x;
            this._professionTxt.y = this._typeTxt.y + 28;
            this._professionTxt.textColor = 16777215;
            this._professionTxt.autoSize = "left";
            this._content.addChild(this._professionTxt);
            this.addGapLine(this._iconBg.y + this._iconBg.height);
            this._priceSp = new Sprite();
            this.textformat.font = "SimSun";
            this.textformat.font = "SimSun";
            this._goldIcon = ToolKit.getNewDO("gold") as Bitmap;
            this._goldIcon.y = 3;
            this._priceSp.addChild(this._goldIcon);
            this._effect = new VMCView();
            this._effect.auto = true;
            this._effect.updatePose("90", true);
            this._effect.move(this._iconBg.x + this._iconBg.width / 2 + 17, this._iconBg.y + this._iconBg.height / 2 + 12);
            addChild(this._effect);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = "lang_elementHeart";
            this._info = param1 as ElementHeartInfo;
            if (this._info == null)
            {
                return;
            }
            if (!this._info.isExpDan())
            {
                this._nameTxt.htmlText = "<b>" + this._info.q_name + "   Lv." + this._info.q_level + "</b>";
            }
            else
            {
                this._nameTxt.htmlText = "<b>" + this._info.q_name + "</b>";
            }
            this._nameTxt.textColor = PropUtil.getElementColor(Math.abs(this._info.q_quality));
            this._typeTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("eh1010", _loc_2) + "  " + PropUtil.getElementColorText(Math.abs(this._info.q_quality));
            this._typeTxt.textColor = PropUtil.getElementColor(Math.abs(this._info.q_quality));
            if (this._info.isExpDan())
            {
                this._professionTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1026", _loc_2), [this._info.q_swallow]);
            }
            else
            {
                this._professionTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("eh1015", _loc_2) + "  " + this._info.exp + "/" + this._info.q_exp_max + "<br/>";
                this._limitTxt = new TextField();
                this.textformat = this._limitTxt.defaultTextFormat;
                this.textformat.font = "SimSun";
                this._limitTxt.defaultTextFormat = this.textformat;
                this._limitTxt.textColor = 16777215;
                this._limitTxt.autoSize = "left";
                this._limitTxt.selectable = false;
                this._limitTxt.x = this._backImg.x;
                this._limitTxt.y = this._professionTxt.y + 45;
                this._content.addChild(this._limitTxt);
                this.addGapLine(this._limitTxt.y + 20);
                this._limitTxt.htmlText = this._info.getAttrTips();
                this.textformat.leading = 1;
                this.textformat.font = "SimSun";
            }
            if (this._info.effectUrl)
            {
                this._effect.loadRes(this._info.effectUrl);
                this._effect.auto = true;
            }
            else
            {
                this._effect.finalize();
            }
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 24 + this._content.height;
            return;
        }// end function

        protected function addGapLine(param1:int) : void
        {
            var _loc_2:* = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = 10;
            _loc_2.y = param1 + 8;
            this._content.addChild(_loc_2);
            this._lines.push(_loc_2);
            return;
        }// end function

    }
}
