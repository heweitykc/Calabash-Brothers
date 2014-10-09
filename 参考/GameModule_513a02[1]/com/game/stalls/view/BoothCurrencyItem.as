package com.game.stalls.view
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.stalls.events.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class BoothCurrencyItem extends BoothGoodItem
    {
        private var _selected:Boolean;
        private var _icon:IconItem;
        private var _info:StallsGoodInfo;
        private var _goldTxt:TextField;
        private var _nameTxt:TextField;
        private var _countTxt:TextField;
        private var _iconSingle:Bitmap;
        private var _tipsTxt:TextField;
        private var _diamondBmp:Bitmap;
        private var _prop:PropInfo;
        private var _priTimer:int;
        private var _bg:MovieClip;
        private var _currencyMC:MovieClip;
        private var _currencyTouchArea:Sprite;
        private var _class:String;

        public function BoothCurrencyItem(param1 = null, param2:int = 1)
        {
            _type = param2;
            super(param1);
            this.initUI();
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
                if (!_isMine)
                {
                    dispatchEvent(new StallsEvent(StallsEvent.BUY, this, true));
                }
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
            if (_type == 1)
            {
                if (this._info)
                {
                    this._currencyMC.gotoAndStop(2);
                    this._goldTxt.text = ToolKit.getMoneyString(this._info.priceyuanbao);
                    this._tipsTxt.visible = false;
                    this._countTxt.text = ToolKit.getMoneyString(this._info.prop.num);
                    this._iconSingle.visible = true;
                    this._diamondBmp.visible = true;
                    this._diamondBmp.x = this._goldTxt.x - this._diamondBmp.width - 5;
                    this._diamondBmp.y = this._goldTxt.y;
                    this._iconSingle.x = this._countTxt.x - this._iconSingle.width;
                    this._iconSingle.y = this._countTxt.y;
                    this._prop.num = this._info.prop.num;
                    _loc_1 = LanguageCfgObj.getInstance().getByIndex("11193");
                    _loc_1 = _loc_1 + this._info.priceyuanbao;
                    _loc_1 = _loc_1 + (" " + LanguageCfgObj.getInstance().getByIndex("10048"));
                    StringTip.create(this._currencyTouchArea, _loc_1);
                }
                else
                {
                    this._currencyMC.gotoAndStop(1);
                    this._goldTxt.text = "";
                    this._tipsTxt.visible = true;
                    this._countTxt.text = "";
                    this._iconSingle.visible = true;
                    this._diamondBmp.visible = false;
                    this._iconSingle.x = this._countTxt.x - this._iconSingle.width;
                    this._iconSingle.y = this._countTxt.y;
                    this._tipsTxt.text = LanguageCfgObj.getInstance().getByIndex("11194");
                    this._prop.num = 0;
                }
                ItemTips.create(this._currencyMC, this._prop, CurrencyTips);
            }
            else if (_type == 2)
            {
                if (this._info)
                {
                    this._currencyMC.gotoAndStop(2);
                    this._goldTxt.text = ToolKit.getMoneyString(this._info.pricegold);
                    this._countTxt.text = ToolKit.getMoneyString(this._info.prop.num);
                    this._tipsTxt.visible = false;
                    this._iconSingle.visible = true;
                    this._diamondBmp.visible = true;
                    this._iconSingle.x = this._goldTxt.x - this._iconSingle.width - 5;
                    this._iconSingle.y = this._goldTxt.y;
                    this._diamondBmp.x = this._countTxt.x - this._diamondBmp.width;
                    this._diamondBmp.y = this._countTxt.y;
                    this._prop.num = this._info.prop.num;
                    _loc_1 = LanguageCfgObj.getInstance().getByIndex("11193");
                    _loc_1 = _loc_1 + this._info.pricegold;
                    _loc_1 = _loc_1 + LanguageCfgObj.getInstance().getByIndex("10049");
                    StringTip.create(this._currencyTouchArea, _loc_1);
                }
                else
                {
                    this._currencyMC.gotoAndStop(1);
                    this._goldTxt.text = "";
                    this._tipsTxt.visible = true;
                    this._tipsTxt.text = LanguageCfgObj.getInstance().getByIndex("11196");
                    this._countTxt.text = "";
                    this._diamondBmp.x = this._countTxt.x - this._diamondBmp.width;
                    this._diamondBmp.y = this._countTxt.y;
                    this._iconSingle.visible = false;
                    this._prop.num = 0;
                }
                ItemTips.create(this._currencyMC, this._prop, CurrencyTips);
            }
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            if (param1)
            {
                this._bg.gotoAndStop(3);
            }
            else
            {
                this._bg.gotoAndStop(1);
            }
            return;
        }// end function

        override protected function initUI() : void
        {
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
            this._currencyMC.x = 14;
            this._currencyMC.y = 8;
            addChild(this._currencyMC);
            this._goldTxt = getDisplayChildByName("txt_gold");
            this._nameTxt = getDisplayChildByName("txt_name");
            this._countTxt = getDisplayChildByName("txt_count");
            this._bg = getDisplayChildByName("bg");
            this._tipsTxt = getDisplayChildByName("txt_tips");
            this._bg = getDisplayChildByName("bg");
            this._currencyTouchArea = new Sprite();
            this._currencyTouchArea.x = this._bg.width * 0.5;
            this._currencyTouchArea.graphics.beginFill(0);
            this._currencyTouchArea.graphics.drawRect(0, 0, this._bg.width * 0.5, this._bg.height);
            this._currencyTouchArea.graphics.endFill();
            addChild(this._currencyTouchArea);
            this._currencyTouchArea.alpha = 0;
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

        override public function get info() : StallsGoodInfo
        {
            return this._info;
        }// end function

        override public function set info(param1:StallsGoodInfo) : void
        {
            this._info = param1;
            if (!isMine)
            {
                if (this._info && this.info.prop.itemModelId == -1)
                {
                    _type = 1;
                }
                else if (this._info && this.info.prop.itemModelId == -2)
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
            if (!this._selected)
            {
                this._bg.gotoAndStop(2);
            }
            return;
        }// end function

        override protected function out() : void
        {
            if (!this._selected)
            {
                this._bg.gotoAndStop(1);
            }
            return;
        }// end function

    }
}
