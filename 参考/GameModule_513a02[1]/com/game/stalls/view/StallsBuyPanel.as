package com.game.stalls.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.mall.utils.*;
    import com.game.stalls.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class StallsBuyPanel extends BaseBox
    {
        private var _infoItem:IconInfoItem;
        private var _countTxt:TextField;
        private var _coinContainer:Sprite;
        private var _diamondContainer:Sprite;
        private var _priceTxt:TextField;
        private var _info:StallsGoodInfo;
        private var _buyBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _coinBtn:BaseButton;
        private var _goldBtn:BaseButton;
        private var _iconSingle:Bitmap;
        private var _class:String;
        private var _isNPC:int;
        private var _personId:long;
        private var _curitem:BaseButton;
        private var _confirmBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _costType:int;
        private var _activeSp:int;

        public function StallsBuyPanel(param1:String = "stallsbuypanel")
        {
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.stalls.view::StallsBox"];
            super.initBaseBoxUI(param1);
            this.initUI();
            this.addListener();
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

        public function get info() : StallsGoodInfo
        {
            return this._info;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function set info(param1:StallsGoodInfo) : void
        {
            this._info = param1;
            this.update();
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
            if (this._info.pricegold)
            {
                if (this._info.pricegold > UserObj.getInstance().playerInfo.money)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11245"));
                    this.close();
                    return;
                }
            }
            else if (this._info.priceyuanbao)
            {
                if (this._info.priceyuanbao > UserObj.getInstance().playerInfo.gold)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11246"));
                    this.close();
                    return;
                }
            }
            else if (this._info.souldiamond)
            {
                if (this._info.souldiamond > BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND))
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11247"));
                    this.close();
                    return;
                }
            }
            if (!this.isNPC)
            {
                StallsControl.getInstance().buy(this._personId, this._info.pricegold, this._info.priceyuanbao, this._info.prop.itemId);
            }
            else
            {
                StallsControl.getInstance().buyShopItem(this.isNPC, this._info);
            }
            this.close();
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
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11248"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11249"));
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = null;
            _loc_1 = new Object();
            if (this._info.prop.itemModelId == -1)
            {
                this._infoItem.icon.image.load(Params.ICON_PATH + "coin.png");
                this._infoItem.icon.image.x = 5;
                this._infoItem.icon.image.y = 5;
                this._infoItem.icon.setImageSize(56, 56);
                this._infoItem.nameTxt.text = LanguageCfgObj.getInstance().getByIndex("11250");
                _loc_1.type = 1;
                _loc_1.num = this._info.prop.num;
                ItemTips.create(this._infoItem.icon, _loc_1, CurrencyTips);
            }
            else if (this._info.prop.itemModelId == -2)
            {
                this._infoItem.icon.image.load(Params.ICON_PATH + "diamond.png");
                this._infoItem.nameTxt.text = LanguageCfgObj.getInstance().getByIndex("11251");
                this._infoItem.icon.image.x = 5;
                this._infoItem.icon.image.y = 5;
                this._infoItem.icon.setImageSize(56, 56);
                _loc_1.type = 2;
                _loc_1.num = this._info.prop.num;
                ItemTips.create(this._infoItem.icon, _loc_1, CurrencyTips);
            }
            else
            {
                this._infoItem.info = this._info.prop;
            }
            if (this._info.pricegold)
            {
                this._priceTxt.text = ToolKit.getMoneyString(this._info.pricegold);
                this.drawType(CostType.COIN);
            }
            else if (this._info.priceyuanbao)
            {
                this._priceTxt.text = ToolKit.getMoneyString(this._info.priceyuanbao);
                this.drawType(CostType.GOLD);
            }
            else if (this._info.souldiamond)
            {
                this._priceTxt.text = ToolKit.getMoneyString(this._info.souldiamond);
                this.drawType(CostType.SOULDIAMOND);
            }
            this._countTxt.text = this._info.prop.num.toString();
            return;
        }// end function

    }
}
