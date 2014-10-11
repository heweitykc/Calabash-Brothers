package com.game.auction.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.auction.control.*;
    import com.game.stalls.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class StallsItemChangePanel extends BaseBox
    {
        private var _infoItem:IconInfoItem;
        private var _confirmBtn:BaseButton;
        private var _offBtn:BaseButton;
        private var _type:int;
        private var _bg:Sprite;
        private var _info:StallsGoodInfo;
        private var _posContainer:Sprite;
        private var _upBtn:BaseButton;
        private var _coinContainer:Sprite;
        private var _goldContainer:Sprite;
        private var _coinCommissionContainer:Sprite;
        private var _goldCommissionContainer:Sprite;
        private var _downBtn:BaseButton;
        private var _special:int;
        private var _pos:int;
        private var _coinTxt:TextField;
        private var _goldTxt:TextField;
        private var _coinCommissionTxt:TextField;
        private var _goldCommissionTxt:TextField;
        private var _countTxt:TextField;

        public function StallsItemChangePanel(param1 = "stallsItemChangePanel")
        {
            super.initBaseBoxUI(param1);
            this.initUI();
            this.addListener();
            if (this._info)
            {
                this.update();
            }
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get info() : StallsGoodInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsGoodInfo) : void
        {
            this._info = param1;
            if (this._info.prop.itemModelId == -1)
            {
                this._special = 1;
            }
            else if (this._info.prop.itemModelId == -2)
            {
                this._special = 2;
            }
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._offBtn.addEvtListener(MouseEvent.CLICK, this.__offClick);
            this._upBtn.addEvtListener(MouseEvent.CLICK, this.__upClick);
            this._downBtn.addEvtListener(MouseEvent.CLICK, this.__downClick);
            return;
        }// end function

        private function initUI() : void
        {
            this._infoItem = new IconInfoItem(getDisplayChildByName("infoItem"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("10295"));
            this._offBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._offBtn.setText(LanguageCfgObj.getInstance().getByIndex("10296"));
            this._posContainer = getDisplayChildByName("poscontainer");
            this._coinContainer = getDisplayChildByName("coincontainer");
            this._goldContainer = getDisplayChildByName("goldcontainer");
            this._coinCommissionContainer = getDisplayChildByName("coincommissioncontainer");
            this._goldCommissionContainer = getDisplayChildByName("goldcommissioncontainer");
            this._coinTxt = this._coinContainer.getChildByName("txt_coin") as TextField;
            this._goldTxt = this._goldContainer.getChildByName("txt_gold") as TextField;
            this._upBtn = new BaseButton(this._posContainer.getChildByName("btn_up"));
            this._upBtn.setText(LanguageCfgObj.getInstance().getByIndex("10297"));
            this._downBtn = new BaseButton(this._posContainer.getChildByName("btn_down"));
            this._downBtn.setText(LanguageCfgObj.getInstance().getByIndex("10298"));
            this._coinCommissionTxt = this._coinCommissionContainer.getChildByName("txt_coinCommission") as TextField;
            this._goldCommissionTxt = this._goldCommissionContainer.getChildByName("txt_goldCommission") as TextField;
            this._countTxt = getDisplayChildByName("txt_count");
            this._bg = getDisplayChildByName("bg");
            return;
        }// end function

        private function __offClick(event:MouseEvent) : void
        {
            AuctionControl.getInstance().downLoad(this._info.prop.itemId);
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            if (this._special == 1)
            {
                AuctionControl.getInstance().changeItem(this._info.prop.itemId, int(this._coinTxt.text), 0, int(this._countTxt.text), this.pos);
            }
            else if (this._special == 2)
            {
                AuctionControl.getInstance().changeItem(this._info.prop.itemId, 0, int(this._coinTxt.text), int(this._countTxt.text), this.pos);
            }
            else
            {
                AuctionControl.getInstance().changeItem(this._info.prop.itemId, int(this._coinTxt.text), int(this._goldTxt.text), int(this._countTxt.text), this.pos);
            }
            return;
        }// end function

        private function __downClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._pos - 1;
            _loc_2._pos = _loc_3;
            this.updateBtn();
            return;
        }// end function

        private function __upClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._pos + 1;
            _loc_2._pos = _loc_3;
            this.updateBtn();
            return;
        }// end function

        private function getCommission(param1:int) : String
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.vipid;
            if (_loc_2 > 0)
            {
                param1 = param1 * 0.07;
            }
            else
            {
                param1 = param1 * 0.3;
            }
            return param1.toString();
        }// end function

        private function update() : void
        {
            this._infoItem.info = this._info.prop;
            if (this._special == 1)
            {
                if (this._posContainer.parent)
                {
                    this._posContainer.parent.removeChild(this._posContainer);
                }
                this._coinTxt.text = this._info.priceyuanbao.toString();
                this._goldContainer.visible = false;
                this._goldCommissionContainer.visible = false;
            }
            else if (this._special == 2)
            {
                if (this._posContainer.parent)
                {
                    this._posContainer.parent.removeChild(this._posContainer);
                }
                this._coinTxt.text = this._info.pricegold.toString();
                this._goldContainer.visible = false;
                this._goldCommissionContainer.visible = false;
            }
            else
            {
                if (!this._posContainer.parent)
                {
                    addChild(this._posContainer);
                }
                this._goldContainer.visible = true;
                this._goldCommissionContainer.visible = true;
                this.updateBtn();
            }
            return;
        }// end function

        private function updateBtn() : void
        {
            if (this.pos == 1)
            {
                this._upBtn.enabled = false;
            }
            else
            {
                this._upBtn.enabled = true;
            }
            if (this.pos == StallsObj.getInstance().maxPos)
            {
                this._downBtn.enabled = false;
            }
            else
            {
                this._downBtn.enabled = true;
            }
            return;
        }// end function

        private function resizeWH() : void
        {
            if (!this._special)
            {
                this._confirmBtn.y = 380;
                this._offBtn.y = 380;
                this._bg.height = 400;
            }
            else
            {
                this._confirmBtn.y = 460;
                this._offBtn.y = 460;
                this._bg.height = 480;
            }
            return;
        }// end function

    }
}
