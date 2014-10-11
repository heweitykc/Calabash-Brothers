package com.game.auction.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.mall.utils.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class AuctionBuyPanel extends BaseBox
    {
        private var _infoItem:IconInfoItem;
        private var _countTxt:TextField;
        private var _coinContainer:Sprite;
        private var _diamondContainer:Sprite;
        private var _priceTxt:TextField;
        private var _info:AuctionItemInfo;
        private var _buyBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _coinBtn:BaseButton;
        private var _goldBtn:BaseButton;
        private var _iconSingle:Bitmap;
        private var _class:String;
        private var _maxBtn:BaseButton;
        private var _isNPC:int;
        private var _personId:long;
        private var _curitem:BaseButton;
        private var _confirmBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _costType:int;
        private var _activeSp:int;

        public function AuctionBuyPanel(param1:String = "stallsbuypanel")
        {
            loadDisplay("res/auctionbuy.swf");
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.stalls.view::StallsBox"];
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("auctionbuypanel");
            this.initUI();
            this.addListener();
            if (this._info)
            {
                this.update();
            }
            super.displayReady();
            return;
        }// end function

        public function get isNPC() : int
        {
            return this._isNPC;
        }// end function

        public function set isNPC(param1:int) : void
        {
            this._isNPC = param1;
            return;
        }// end function

        public function get info() : AuctionItemInfo
        {
            return this._info;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function set info(param1:AuctionItemInfo) : void
        {
            this._info = param1;
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this._buyClick);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this._cancelClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function _buyClick(event:MouseEvent) : void
        {
            if (this._info.price)
            {
                if (this._info.price > UserObj.getInstance().playerInfo.gold)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10226"));
                    this.close();
                    return;
                }
            }
            AuctionControl.getInstance().buy(this._info.itemId);
            this.close();
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

        private function _cancelClick(event:MouseEvent) : void
        {
            this.close();
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
                this._iconSingle.x = this._priceTxt.x - this._iconSingle.width - 14;
                this._iconSingle.y = this._priceTxt.y;
                addChild(this._iconSingle);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._infoItem = new IconInfoItem(getDisplayChildByName("infoItem"));
            this._countTxt = getDisplayChildByName("txt_num");
            this._coinContainer = getDisplayChildByName("coin");
            this._diamondContainer = getDisplayChildByName("diamond");
            this._priceTxt = getDisplayChildByName("txt_price");
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10228"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10229"));
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = new Object();
            if (this._info.item.itemModelId == -1)
            {
                this._infoItem.info = this._info.item;
                ItemTips.create(this._infoItem.icon, this._info.item, CurrencyTips);
            }
            else if (this._info.item.itemModelId == -2)
            {
                this._infoItem.info = this._info.item;
                ItemTips.create(this._infoItem.icon, this._info.item, CurrencyTips);
            }
            else
            {
                this._infoItem.info = this._info.item;
            }
            if (this._info.price)
            {
                this._priceTxt.text = ToolKit.getMoneyString(this._info.price);
                this.drawType(CostType.GOLD);
            }
            this._countTxt.text = this._info.item.num.toString();
            return;
        }// end function

    }
}
