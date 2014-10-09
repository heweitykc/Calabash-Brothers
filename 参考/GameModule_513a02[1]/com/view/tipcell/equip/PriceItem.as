package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.text.*;

    public class PriceItem extends BaseItem
    {
        private var _priceTxt:TextField;
        private var _priceValueTxt:TextField;
        private var _goldIcon:Bitmap;

        public function PriceItem()
        {
            this._priceTxt = new TextField();
            _textFormat.align = TextFormatAlign.CENTER;
            _textFormat.leading = 2;
            this._priceTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._priceTxt.defaultTextFormat = _textFormat;
            this._priceTxt.autoSize = "left";
            this._priceTxt.textColor = 16187136;
            this._priceTxt.text = LanguageCfgObj.getInstance().getByIndex("10177");
            addChild(this._priceTxt);
            this._priceValueTxt = new TextField();
            this._priceValueTxt.defaultTextFormat = _textFormat;
            this._priceValueTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._priceValueTxt.textColor = 16187136;
            this._priceValueTxt.y = 2;
            addChild(this._priceValueTxt);
            this._goldIcon = ToolKit.getNewDO("gold") as Bitmap;
            this._goldIcon.y = 3;
            addChild(this._goldIcon);
            return;
        }// end function

        public function initPriceSp(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = null;
            if (param1.q_sell)
            {
                _loc_3 = "";
                if (param1.num > 1)
                {
                    _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11844"), [param1.num, param1.q_sell_price * param1.num]);
                }
                else
                {
                    _loc_3 = _loc_3 + param1.q_sell_price;
                }
                this._priceValueTxt.htmlText = _loc_3;
                this._priceValueTxt.width = this._priceValueTxt.textWidth + 35;
                this._priceValueTxt.height = this._priceValueTxt.textHeight + 5;
                this._goldIcon.x = this._priceTxt.x + this._priceTxt.width;
                this._priceValueTxt.x = this._goldIcon.x + this._goldIcon.width + 3;
                param2.add(this);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
