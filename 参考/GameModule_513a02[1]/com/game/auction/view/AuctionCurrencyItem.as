package com.game.auction.view
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.auction.events.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class AuctionCurrencyItem extends AuctionGoodItem
    {
        private var _info:AuctionItemInfo;
        private var _iconSingle:Bitmap;
        private var _tipsTxt:TextField;
        private var _diamondBmp:Bitmap;
        private var _prop:PropInfo;
        private var _priTimer:int;
        private var _currencyMC:MovieClip;
        private var _class:String;

        public function AuctionCurrencyItem(param1 = null, param2:int = 1)
        {
            _type = param2;
            super(param1);
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            addEvtListener(MouseEvent.CLICK, this.__click);
            _accpetKey = [Params.ITEM_PLACE_BACKPACK];
            this.drawIcon();
            this._prop = new PropInfo();
            this._prop.itemModelId = param2 == 1 ? (-1) : (-2);
            this._prop.q_name = param2 == 1 ? (LanguageCfgObj.getInstance().getByIndex("10049")) : (LanguageCfgObj.getInstance().getByIndex("10048"));
            this._prop.url = param2 == 1 ? (Params.ITEM_PATH + "i50002.png") : (Params.ITEM_PATH + "i50003.png");
            return;
        }// end function

        override protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 300)
            {
                this._priTimer = 0;
            }
            else
            {
                this._priTimer = _loc_2;
                dispatchEvent(new StallsEvent(StallsEvent.SELECTEDGOOD, this, true));
            }
            return;
        }// end function

        override protected function update() : void
        {
            var _loc_1:* = null;
            if (this._info)
            {
                this._currencyMC.gotoAndStop(2);
                _goldTxt.text = ToolKit.getMoneyString(this._info.price);
                this._tipsTxt.visible = false;
                _countTxt.text = ToolKit.getMoneyString(this._info.item.num);
                this._iconSingle.visible = false;
                this._diamondBmp.visible = true;
                this._diamondBmp.x = _goldTxt.x - this._diamondBmp.width - 5;
                this._diamondBmp.y = _goldTxt.y;
                this._iconSingle.x = _countTxt.x - this._iconSingle.width;
                this._iconSingle.y = _countTxt.y;
                _nameTxt.text = LanguageCfgObj.getInstance().getByIndex("10230");
                this._prop.num = this._info.item.num;
                _loc_1 = LanguageCfgObj.getInstance().getByIndex("10231");
                _loc_1 = _loc_1 + this._info.price;
                _loc_1 = _loc_1 + (" " + LanguageCfgObj.getInstance().getByIndex("10048"));
                _boardBtn.visible = true;
                StringTip.create(_currencyTouchArea, _loc_1);
            }
            else
            {
                this._currencyMC.gotoAndStop(1);
                _goldTxt.text = "";
                this._tipsTxt.visible = true;
                _countTxt.text = "";
                _nameTxt.text = "";
                this._iconSingle.visible = false;
                this._diamondBmp.visible = false;
                this._iconSingle.x = _countTxt.x - this._iconSingle.width;
                this._iconSingle.y = _countTxt.y;
                this._tipsTxt.text = LanguageCfgObj.getInstance().getByIndex("10232");
                _boardBtn.visible = false;
                this._prop.num = 0;
                StringTip.dispose(_currencyTouchArea);
            }
            ItemTips.create(this._currencyMC, this._prop, CurrencyTips);
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            _selected = param1;
            if (param1)
            {
                _bg.gotoAndStop(3);
            }
            else
            {
                _bg.gotoAndStop(1);
            }
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            this._currencyMC = getDisplayChildByName("mc_currency");
            if (this._currencyMC == null)
            {
                if (_type == 1)
                {
                    this._currencyMC = ToolKit.getNew("stallscoinmc");
                }
                else if (_type == 2)
                {
                    this._currencyMC = ToolKit.getNew("stallsdiamondmc");
                }
            }
            addChild(this._currencyMC);
            _goldTxt = getDisplayChildByName("txt_gold");
            _nameTxt = getDisplayChildByName("txt_name");
            _countTxt = getDisplayChildByName("txt_count");
            _bg = getDisplayChildByName("bg");
            this._tipsTxt = getDisplayChildByName("txt_tips");
            _bg = getDisplayChildByName("bg");
            ToolKit.disappear(_icon);
            _icon = null;
            return;
        }// end function

        private function drawIcon() : void
        {
            this._iconSingle = ToolKit.getNewDO("icon_gold") as Bitmap;
            this._diamondBmp = ToolKit.getNewDO("icon_diamond") as Bitmap;
            addChild(this._iconSingle);
            addChild(this._diamondBmp);
            return;
        }// end function

        override protected function __board(event:MouseEvent) : void
        {
            if (this._info)
            {
                event.stopImmediatePropagation();
                dispatchEvent(new StallsEvent(StallsEvent.BOARD, this, true));
            }
            return;
        }// end function

        override protected function __over(event:MouseEvent) : void
        {
            this.over();
            var _loc_2:* = DragManager.getInstance().isInDrag();
            if (_isMine && _loc_2)
            {
                DragManager.getInstance().onMouseIn(this);
            }
            return;
        }// end function

        override protected function __out(event:MouseEvent) : void
        {
            this.out();
            if (_isMine && DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseOut(this);
            }
            return;
        }// end function

        override public function get info() : AuctionItemInfo
        {
            return this._info;
        }// end function

        override public function set info(param1:AuctionItemInfo) : void
        {
            this._info = param1;
            if (!isMine)
            {
                if (this._info && this.info.item.itemModelId == -1)
                {
                    _type = 1;
                }
                else if (this._info && this.info.item.itemModelId == -2)
                {
                    _type = 2;
                }
                else
                {
                    _type = 0;
                }
            }
            this.update();
            return;
        }// end function

        override protected function over() : void
        {
            if (!_selected)
            {
                _bg.gotoAndStop(2);
            }
            return;
        }// end function

        override protected function out() : void
        {
            if (!_selected)
            {
                _bg.gotoAndStop(1);
            }
            return;
        }// end function

    }
}
