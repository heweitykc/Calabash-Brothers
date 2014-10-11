package com.game.stalls.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.mall.utils.*;
    import com.game.stalls.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CurrencyStallsPanel extends BaseBox
    {
        private var _infoItem:IconItem;
        private var _coinPriceTxt:TextField;
        private var _coinCommissionTxt:TextField;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _countTxt:TextField;
        private var _type:int;
        private var _nameTxt:TextField;
        private var _closeBtn:BaseButton;
        private var _commissionTipsTxt:TextField;
        private var _iconSingle:Bitmap;
        private var _helpBtn:BaseButton;
        private var _info:StallsGoodInfo;
        private var _titleTxt:TextField;
        private var _costType:int;
        private static var TEMPLATE:String = LanguageCfgObj.getInstance().getByIndex("10268");

        public function CurrencyStallsPanel(param1 = "currencystallspanel")
        {
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.stalls.view::StallsBox"];
            super.initBaseBoxUI("currencystallspanel");
            this.initUI();
            this.addListener();
            if (this.info)
            {
                this.update();
            }
            return;
        }// end function

        public function get info() : StallsGoodInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsGoodInfo) : void
        {
            this._info = param1;
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = new Object();
            if (this._info.prop.itemModelId == -1)
            {
                this._info.prop.url = Params.ITEM_PATH + "i50002.png";
                this._info.prop.q_name = LanguageCfgObj.getInstance().getByIndex("10269");
                this._type = 1;
            }
            else if (this._info.prop.itemModelId == -2)
            {
                this._info.prop.url = Params.ITEM_PATH + "i50003.png";
                this._info.prop.q_name = LanguageCfgObj.getInstance().getByIndex("10270");
                this._type = 2;
            }
            if (this._type == 1)
            {
                this._infoItem.image.load(Params.ICON_PATH + "coin.png");
                this._nameTxt.text = LanguageCfgObj.getInstance().getByIndex("10269");
                _loc_1.type = 1;
                _loc_1.itemModelId = -1;
                _loc_1.num = this._info.prop.num;
                ItemTips.create(this._infoItem, this._info.prop, CurrencyTips);
                this.drawType(CostType.GOLD);
                this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10272");
            }
            else if (this._type == 2)
            {
                this._infoItem.image.load(Params.ICON_PATH + "diamond.png");
                this._nameTxt.text = LanguageCfgObj.getInstance().getByIndex("10270");
                _loc_1.type = 2;
                _loc_1.itemModelId = -2;
                _loc_1.num = this._info.prop.num;
                this.drawType(CostType.COIN);
                ItemTips.create(this._infoItem, this._info.prop, CurrencyTips);
                this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10274");
            }
            if (this._info.isNew)
            {
                this._coinPriceTxt.text = "1";
                this._coinCommissionTxt.text = "";
                this._countTxt.text = "1";
                this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10275"));
                this._countTxt.type = "input";
                this.__coinChange();
            }
            else
            {
                this._coinPriceTxt.text = this._info.pricegold > 0 ? (this._info.pricegold.toString()) : (this._info.priceyuanbao.toString());
                this.__coinChange();
                this._countTxt.text = this._info.prop.num.toString();
                this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11209"));
                this._countTxt.type = TextFieldType.DYNAMIC;
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._infoItem = new IconItem(null);
            this._infoItem.image.x = 5;
            this._infoItem.image.y = 5;
            this._infoItem.x = 40;
            this._infoItem.y = 60;
            addChild(this._infoItem);
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10275"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10277"));
            this._coinPriceTxt = getDisplayChildByName("txt_coin");
            this._coinCommissionTxt = getDisplayChildByName("txt_coinCommission");
            this._commissionTipsTxt = getDisplayChildByName("txt_commissionTip");
            this._nameTxt = getDisplayChildByName("txt_name");
            this._helpBtn = new BaseButton(getDisplayChildByName("btn_help"));
            this._countTxt = getDisplayChildByName("txt_count");
            this._coinPriceTxt.type = "input";
            this._countTxt.type = "input";
            this._countTxt.restrict = "0-9";
            this._countTxt.maxChars = 9;
            this._coinPriceTxt.maxChars = 9;
            StringTip.create(this._helpBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11655"), [Math.round(GlobalCfgObj.getInstance().getVipTex())]));
            this._titleTxt = getDisplayChildByName("txt_title");
            return;
        }// end function

        private function drawType(param1:int) : void
        {
            if (this._costType != param1)
            {
                this._costType = param1;
                if (this._iconSingle && this._iconSingle.parent)
                {
                    this._iconSingle.parent.removeChild(this._iconSingle);
                }
                this._iconSingle = IconUtil.getIcon(this._costType);
                this._iconSingle.x = this._coinPriceTxt.x - this._iconSingle.width - 12;
                this._iconSingle.y = this._coinPriceTxt.y;
                addChild(this._iconSingle);
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__inputChange);
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._coinPriceTxt.addEventListener(Event.CHANGE, this.__coinChange);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__inputChange, false, 0, true);
            return;
        }// end function

        private function __inputChange(event:FocusEvent) : void
        {
            this._coinPriceTxt.text = "";
            this.__coinChange();
            this._coinPriceTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__inputChange);
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = long.fromNumber(this._info.prop.itemModelId);
            if (this._info.isNew)
            {
                if (this._type == 1)
                {
                    StallsControl.getInstance().upload(_loc_3, 0, int(this._coinPriceTxt.text), int(this._countTxt.text), StallsControl.getInstance().getMineCurrentNum());
                }
                else if (this._type == 2)
                {
                    StallsControl.getInstance().upload(_loc_3, int(this._coinPriceTxt.text), 0, int(this._countTxt.text), StallsControl.getInstance().getMineCurrentNum());
                }
            }
            else if (this._type == 1)
            {
                StallsControl.getInstance().changeItem(_loc_3, 0, int(this._coinPriceTxt.text), int(this._countTxt.text), this._info.pos);
            }
            else if (this._type == 2)
            {
                StallsControl.getInstance().changeItem(_loc_3, int(this._coinPriceTxt.text), 0, int(this._countTxt.text), this._info.pos);
            }
            this.close();
            return;
        }// end function

        private function __cancelClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __coinChange(event:Event = null) : void
        {
            var _loc_2:* = int(this._coinPriceTxt.text);
            var _loc_3:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_3 > 0)
            {
                _loc_2 = _loc_2 * Number((GlobalCfgObj.getInstance().getVipTex() * 0.01).toFixed(2));
            }
            else
            {
                _loc_2 = _loc_2 * Number((GlobalCfgObj.getInstance().getTex() * 0.01).toFixed(2));
            }
            if (_loc_2 < 1)
            {
                _loc_2 = 1;
            }
            this._coinCommissionTxt.htmlText = TEMPLATE.replace("{1}", _loc_2).replace("{2}", this._type == 1 ? (LanguageCfgObj.getInstance().getByIndex("10048")) : (LanguageCfgObj.getInstance().getByIndex("10049")));
            if (_loc_3 > 0)
            {
                this._commissionTipsTxt.text = LanguageCfgObj.getInstance().getByIndex("11890") + Math.round(GlobalCfgObj.getInstance().getVipTex()) + "%";
            }
            else
            {
                this._commissionTipsTxt.text = LanguageCfgObj.getInstance().getByIndex("11890") + Math.round(GlobalCfgObj.getInstance().getTex()) + "%";
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (!StallsControl.getInstance().fastChoose)
            {
                Global.primaryCursorManager.hide();
            }
            return;
        }// end function

    }
}
