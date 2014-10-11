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
    import com.game.shop.view.*;
    import com.game.stalls.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class StallsItemPanel extends BaseBox
    {
        private var _info:StallsGoodInfo;
        private var _infoItem:IconInfoItem;
        private var _coinPriceTxt:TextField;
        private var _coinCommissionTxt:TextField;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _addBtn:BaseButton;
        private var _subBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _countTxt:TextField;
        protected var _iconSingle:Bitmap;
        private var _count:int;
        private var _coinContainer:CostItemSP;
        private var _diamondContainer:CostItemSP;
        private var _helpBtn:BaseButton;
        private var _commissionTipsTxt:TextField;
        private var _titleTxt:TextField;
        private var _type:int = -1;
        private var _class:String;
        private static var TEMPLATE:String = LanguageCfgObj.getInstance().getByIndex("11256");

        public function StallsItemPanel(param1:String = "itemstallpanel")
        {
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.stalls.view::StallsBox"];
            super.initBaseBoxUI(param1);
            this.initUI();
            this.addListener();
            return;
        }// end function

        public function get info() : StallsGoodInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsGoodInfo) : void
        {
            this._info = param1;
            this.update();
            this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            this._infoItem.info = this._info.prop;
            if (this._info.isNew)
            {
                this._coinPriceTxt.text = "1";
                this._coinCommissionTxt.text = "";
                this._countTxt.text = "1";
                this._count = 1;
                this._diamondContainer.selected = false;
                this._coinContainer.selected = true;
                this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11257");
                this.drawType(CostType.COIN);
                this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11258"));
                this._countTxt.type = TextFieldType.INPUT;
            }
            else
            {
                _loc_1 = this._info.pricegold ? (this._info.pricegold) : (this._info.priceyuanbao);
                this._coinPriceTxt.text = _loc_1.toString();
                _loc_2 = _loc_1;
                this._countTxt.text = this._info.prop.num.toString();
                _loc_3 = UserObj.getInstance().playerInfo.vipid;
                this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11259");
                this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11260"));
                this._countTxt.type = TextFieldType.DYNAMIC;
                if (this._info.pricegold)
                {
                    this._diamondContainer.selected = false;
                    this._coinContainer.selected = true;
                    this.drawType(CostType.COIN);
                }
                else
                {
                    this._diamondContainer.selected = true;
                    this._coinContainer.selected = false;
                    this.drawType(CostType.GOLD);
                }
            }
            this.__coinChange();
            if (this._info.prop.num == 1)
            {
                this._addBtn.enabled = false;
                this._subBtn.enabled = false;
            }
            else
            {
                this._addBtn.enabled = true;
                this._subBtn.enabled = true;
            }
            StringTip.create(this._helpBtn, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11655"), [Math.round(GlobalCfgObj.getInstance().getVipTex())]));
            return;
        }// end function

        private function initUI() : void
        {
            this._infoItem = new IconInfoItem(getDisplayChildByName("infoItem"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11258"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11262"));
            this._coinPriceTxt = getDisplayChildByName("txt_coin");
            this._coinCommissionTxt = getDisplayChildByName("txt_Commission");
            this._commissionTipsTxt = getDisplayChildByName("txt_commissionTip");
            this._countTxt = getDisplayChildByName("txt_count");
            this._addBtn = new BaseButton(getDisplayChildByName("btn_add"));
            this._subBtn = new BaseButton(getDisplayChildByName("btn_sub"));
            this._coinContainer = new CostItemSP(getDisplayChildByName("coin"));
            this._diamondContainer = new CostItemSP(getDisplayChildByName("diamond"));
            this._helpBtn = new BaseButton(getDisplayChildByName("btn_help"));
            this._countTxt.type = "input";
            this._countTxt.restrict = "0-9";
            this._countTxt.maxChars = 3;
            this._coinPriceTxt.type = "input";
            this._coinPriceTxt.restrict = "0-9";
            this._coinPriceTxt.maxChars = 9;
            this._titleTxt = getDisplayChildByName("txt_title");
            return;
        }// end function

        private function addListener() : void
        {
            this._coinPriceTxt.addEventListener(Event.CHANGE, this.__coinChange);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._addBtn.addEvtListener(MouseEvent.CLICK, this.__addClick);
            this._subBtn.addEvtListener(MouseEvent.CLICK, this.__subClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._coinContainer.addEvtListener(MouseEvent.CLICK, this.__coinClick);
            this._diamondContainer.addEvtListener(MouseEvent.CLICK, this.__coinClick);
            this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            this._coinPriceTxt.text = "";
            this._coinPriceTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function __coinClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._coinContainer:
                {
                    if (this._diamondContainer.selected)
                    {
                        this._diamondContainer.selected = false;
                    }
                    this._coinContainer.selected = true;
                    break;
                }
                case this._diamondContainer:
                {
                    if (this._coinContainer.selected)
                    {
                        this._coinContainer.selected = false;
                    }
                    this._diamondContainer.selected = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._coinContainer.selected)
            {
                this.drawType(CostType.COIN);
            }
            else
            {
                this.drawType(CostType.GOLD);
            }
            this.__coinChange();
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            if (int(this._coinPriceTxt.text) == 0)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11263"));
                return;
            }
            if (this._info.isNew)
            {
                if (this._type == 1)
                {
                    StallsControl.getInstance().upload(this._info.prop.itemId, int(this._coinPriceTxt.text), 0, int(this._countTxt.text), StallsControl.getInstance().getMineCurrentNum());
                }
                else if (this._type == 2)
                {
                    StallsControl.getInstance().upload(this._info.prop.itemId, 0, int(this._coinPriceTxt.text), int(this._countTxt.text), StallsControl.getInstance().getMineCurrentNum());
                }
            }
            else if (this._type == 1)
            {
                StallsControl.getInstance().changeItem(this._info.prop.itemId, int(this._coinPriceTxt.text), 0, int(this._countTxt.text), this._info.pos);
            }
            else if (this._type == 2)
            {
                StallsControl.getInstance().changeItem(this._info.prop.itemId, 0, int(this._coinPriceTxt.text), int(this._countTxt.text), this._info.pos);
            }
            this.close();
            return;
        }// end function

        private function __addClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._count + 1;
            _loc_2._count = _loc_3;
            if (this._count > this._info.prop.num)
            {
                this._count = this._info.prop.num;
            }
            this._countTxt.text = this._count.toString();
            return;
        }// end function

        private function __subClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._count - 1;
            _loc_2._count = _loc_3;
            if (this._count < 1)
            {
                this._count = 1;
            }
            this._countTxt.text = this._count.toString();
            return;
        }// end function

        private function __cancelClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function drawType(param1:int) : void
        {
            if (this._type != param1)
            {
                this._type = param1;
                if (this._iconSingle && this._iconSingle.parent)
                {
                    this._iconSingle.parent.removeChild(this._iconSingle);
                }
                this._iconSingle = IconUtil.getIcon(this._type);
                this._iconSingle.x = this._coinPriceTxt.x - this._iconSingle.width - 12;
                this._iconSingle.y = this._coinPriceTxt.y;
                addChild(this._iconSingle);
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

        private function __coinChange(event:Event = null) : void
        {
            var _loc_2:* = int(this._coinPriceTxt.text);
            var _loc_3:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_3 > 0)
            {
                _loc_2 = _loc_2 * GlobalCfgObj.getInstance().getVipTex() * 0.01;
            }
            else
            {
                _loc_2 = _loc_2 * GlobalCfgObj.getInstance().getTex() * 0.01;
            }
            if (_loc_2 < 1)
            {
                _loc_2 = 1;
            }
            this._coinCommissionTxt.htmlText = TEMPLATE.replace("{1}", _loc_2).replace("{2}", this._type == 1 ? (LanguageCfgObj.getInstance().getByIndex("10049")) : (LanguageCfgObj.getInstance().getByIndex("10048")));
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

    }
}
