package com.game.auction.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.mall.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class AuctionItemPanel extends BaseBox
    {
        private var _info:PropInfo;
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
        private var _helpBtn:BaseButton;
        private var _maxBtn:BaseButton;
        private var _commissionTipsTxt:TextField;
        private var _titleTxt:TextField;
        private const MIN_PRICE:int = 2;
        private var _type:int = 2;
        private var _orginValue:int;
        private var _preTime:int;
        private var _timeOutId:int;
        private var _addOper:int;
        private var _class:String;
        private static var TEMPLATE:String = LanguageCfgObj.getInstance().getByIndex("11256");

        public function AuctionItemPanel(param1:String = "itemstallpanel")
        {
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.auction.view::StallsBox"];
            super.initBaseBoxUI(param1);
            this.initUI();
            this.addListener();
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            this.update();
            this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            return;
        }// end function

        private function update() : void
        {
            this._infoItem.info = this._info;
            this._coinPriceTxt.text = this.MIN_PRICE.toString();
            this._coinCommissionTxt.text = "";
            this._countTxt.text = "1";
            this._count = 1;
            this._titleTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10238");
            this.drawType(CostType.GOLD);
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10239"));
            this._countTxt.type = TextFieldType.INPUT;
            this.drawType(CostType.GOLD);
            this.__coinChange();
            if (this._info.num == 1)
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
            this._maxBtn = new BaseButton(getDisplayChildByName("btn_max"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10239"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10241"));
            this._coinPriceTxt = getDisplayChildByName("txt_coin");
            this._coinCommissionTxt = getDisplayChildByName("txt_Commission");
            this._commissionTipsTxt = getDisplayChildByName("txt_commissionTip");
            this._countTxt = getDisplayChildByName("txt_count");
            this._addBtn = new BaseButton(getDisplayChildByName("btn_add"));
            this._subBtn = new BaseButton(getDisplayChildByName("btn_sub"));
            this._helpBtn = new BaseButton(getDisplayChildByName("btn_help"));
            this._countTxt.type = "input";
            this._countTxt.restrict = "0-9";
            this._countTxt.maxChars = 3;
            this._coinPriceTxt.type = "input";
            this._coinPriceTxt.restrict = "0-9";
            this._coinPriceTxt.maxChars = 8;
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
            this._maxBtn.addEvtListener(MouseEvent.CLICK, this.__maxClick);
            this._coinPriceTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            this._addBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._subBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            return;
        }// end function

        private function __mouseUp(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            clearTimeout(this._timeOutId);
            var _loc_2:* = int(this._countTxt.text);
            removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            this._addOper = 0;
            this._preTime = 0;
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            if (event.target == this._addBtn)
            {
                this._addOper = 1;
            }
            else if (event.target == this._subBtn)
            {
                this._addOper = -1;
            }
            this._orginValue = int(this._countTxt.text);
            this._preTime = getTimer();
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            this._timeOutId = setTimeout(this.addToEnterFrame, 200);
            return;
        }// end function

        private function addToEnterFrame() : void
        {
            clearTimeout(this._timeOutId);
            var _loc_1:* = int(this._countTxt.text);
            if (this._addOper == 1 && _loc_1 < this._info.num)
            {
                addEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            }
            if (this._addOper == -1 && _loc_1 > 1)
            {
                addEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            }
            return;
        }// end function

        private function __OperEnterFrame(event:Event) : void
        {
            var _loc_2:* = 0;
            if (this._preTime == 0 || this._addOper == 0)
            {
                removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                this._addOper = 0;
                return;
            }
            var _loc_3:* = int((getTimer() - this._preTime) * 0.01);
            if (this._addOper == 1)
            {
                if (_loc_3 >= this._info.num - this._orginValue)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                    this._addOper = 0;
                    _loc_3 = this._info.num - this._orginValue;
                }
                _loc_2 = this._orginValue + _loc_3;
            }
            else if (this._addOper == -1)
            {
                _loc_2 = this._orginValue - _loc_3;
                if (_loc_2 <= 1)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                    this._addOper = 0;
                    _loc_2 = 1;
                }
            }
            this._countTxt.text = _loc_2.toString();
            this._count = _loc_2;
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            this._coinPriceTxt.text = "";
            this._coinPriceTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn);
            return;
        }// end function

        private function __maxClick(event:MouseEvent) : void
        {
            this._countTxt.text = this._info.num.toString();
            this._count = this._info.num;
            return;
        }// end function

        private function __coinClick(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (int(this._coinPriceTxt.text) < this.MIN_PRICE)
            {
                _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11889"), [this.MIN_PRICE]);
                Global.popManager.cue(_loc_2, "");
                return;
            }
            AuctionControl.getInstance().upload(this._info.itemId, int(this._coinPriceTxt.text), int(this._countTxt.text));
            this.close();
            return;
        }// end function

        private function __addClick(event:MouseEvent) : void
        {
            if (this._orginValue == int(this._countTxt.text))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._count + 1;
                _loc_2._count = _loc_3;
                if (this._count > this._info.num)
                {
                    this._count = this._info.num;
                }
                this._countTxt.text = this._count.toString();
            }
            return;
        }// end function

        private function __subClick(event:MouseEvent) : void
        {
            if (this._orginValue == int(this._countTxt.text))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._count - 1;
                _loc_2._count = _loc_3;
                if (this._count < 1)
                {
                    this._count = 1;
                }
                this._countTxt.text = this._count.toString();
            }
            return;
        }// end function

        private function __cancelClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function drawType(param1:int) : void
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
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (!AuctionControl.getInstance().fastChoose)
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
                _loc_2 = Math.ceil(_loc_2 * GlobalCfgObj.getInstance().getVipTex() / 100);
            }
            else
            {
                _loc_2 = Math.ceil(_loc_2 * GlobalCfgObj.getInstance().getTex() / 100);
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
