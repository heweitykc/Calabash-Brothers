package com.game.auction.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.auction.events.*;
    import com.game.mall.utils.*;
    import com.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.*;

    public class AuctionGoodItem extends Component implements IDragItem
    {
        protected var _selected:Boolean;
        protected var _icon:IconItem;
        private var _info:AuctionItemInfo;
        protected var _goldTxt:TextField;
        protected var _nameTxt:TextField;
        protected var _type:int;
        protected var _isMine:Boolean;
        private var _iconSingle:Bitmap;
        private var _score:EquipScoreIcon;
        protected var _countTxt:TextField;
        private var _priTimer:int;
        protected var _bg:MovieClip;
        protected var _currencyTouchArea:Sprite;
        protected var _boardBtn:BaseButton;
        private var _class:String;
        private var _costType:int;
        protected var _accpetKey:Array;

        public function AuctionGoodItem(param1 = null)
        {
            super(param1);
            this.initUI();
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            addEvtListener(MouseEvent.CLICK, this.__click);
            this._accpetKey = [Params.ITEM_PLACE_BACKPACK];
            return;
        }// end function

        public function get isMine() : Boolean
        {
            return this._isMine;
        }// end function

        public function set isMine(param1:Boolean) : void
        {
            this._isMine = param1;
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

        public function get info() : AuctionItemInfo
        {
            return this._info;
        }// end function

        public function set info(param1:AuctionItemInfo) : void
        {
            this._info = param1;
            if (!this.isMine)
            {
                if (this._info && this.info.item.itemModelId == -1)
                {
                    this._type = 1;
                }
                else if (this._info && this.info.item.itemModelId == -2)
                {
                    this._type = 2;
                }
                else
                {
                    this._type = 0;
                }
            }
            this.update();
            return;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            if (!param1)
            {
            }
            return;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            AuctionControl.getInstance().addToStalls(param1 as PropInfo);
            return;
        }// end function

        public function dragEnter() : void
        {
            this.over();
            return;
        }// end function

        public function dragOut() : void
        {
            this.out();
            return;
        }// end function

        protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 300)
            {
            }
            else
            {
                this._priTimer = _loc_2;
                dispatchEvent(new StallsEvent(StallsEvent.SELECTEDGOOD, this, true));
            }
            return;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            if (!visible)
            {
                return false;
            }
            return this.acceptKey().indexOf(param1.getKey()) != -1 && this._isMine;
        }// end function

        protected function update() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Object();
            if (this._info)
            {
                if (this._info.item is EquipmentInfo)
                {
                    _loc_4 = PropUtil.getEquipNameAndColor(this._info.item as EquipmentInfo);
                    this._nameTxt.htmlText = PropUtil.getHtmlTxt(this._info.item);
                }
                else
                {
                    this._nameTxt.htmlText = this._info.item.q_name;
                    this._nameTxt.textColor = PropUtil.getPropColor(this._info.item.q_quality_lv);
                }
                this._icon.setInfo(this._info.item);
                this.drawType(CostType.GOLD);
                _loc_2 = CostType.GOLD;
                this._goldTxt.text = ToolKit.getMoneyString(this._info.price);
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10234");
                _loc_3 = _loc_3 + this._info.price;
                _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("10048");
                this._boardBtn.visible = true;
                StringTip.create(this._currencyTouchArea, _loc_3);
            }
            else
            {
                if (this._iconSingle && this._iconSingle.parent)
                {
                    this._costType = -1;
                    this._iconSingle.parent.removeChild(this._iconSingle);
                }
                StringTip.dispose(this._currencyTouchArea);
                this._icon.setInfo(null);
                this._goldTxt.text = "";
                this._nameTxt.text = "";
                this._boardBtn.visible = false;
            }
            if (this._info)
            {
                if (this._info.item is EquipmentInfo)
                {
                    this._countTxt.visible = false;
                    if (this._score == null)
                    {
                        this._score = new EquipScoreIcon();
                    }
                    this._score.y = this._countTxt.y;
                    this._score.x = this._countTxt.x;
                    addChild(this._score);
                    this._score.info = this._info.item as EquipmentInfo;
                }
                else
                {
                    ToolKit.disappear(this._score);
                    if (this._info.item.itemModelId < 0)
                    {
                        this._countTxt.visible = true;
                        this._countTxt.text = this._info.item.num.toString();
                    }
                    else
                    {
                        this._countTxt.visible = false;
                    }
                }
            }
            else
            {
                ToolKit.disappear(this._score);
                this._countTxt.text = "";
            }
            return;
        }// end function

        protected function initUI() : void
        {
            this._icon = new IconItem();
            this._icon.image.x = 6;
            this._icon.image.y = 5;
            this._icon.move(5, 4);
            this._icon.setImageSize(56, 56);
            this._icon.setCountTxtXY(66 - 10, 66 - 20);
            addChild(this._icon);
            this._goldTxt = getDisplayChildByName("txt_gold");
            this._nameTxt = getDisplayChildByName("txt_name");
            this._bg = getDisplayChildByName("bg");
            this._countTxt = getDisplayChildByName("txt_count");
            this._boardBtn = new BaseButton(getDisplayChildByName("btn_board"));
            this._boardBtn.setText(LanguageCfgObj.getInstance().getByIndex("10236"));
            this._boardBtn.addEvtListener(MouseEvent.CLICK, this.__board);
            this._currencyTouchArea = new Sprite();
            this._currencyTouchArea.x = this._bg.width * 0.5;
            this._currencyTouchArea.graphics.beginFill(0);
            this._currencyTouchArea.graphics.drawRect(0, 0, this._bg.width * 0.5, this._bg.height);
            this._currencyTouchArea.graphics.endFill();
            addChild(this._currencyTouchArea);
            this._currencyTouchArea.alpha = 0;
            this._goldTxt.text = "";
            this._nameTxt.text = "";
            this._countTxt.text = "";
            addChild(this._boardBtn);
            return;
        }// end function

        protected function __board(event:MouseEvent) : void
        {
            if (this._info)
            {
                event.stopImmediatePropagation();
                dispatchEvent(new StallsEvent(StallsEvent.BOARD, this, true));
            }
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
                this._iconSingle.x = this._goldTxt.x - this._iconSingle.width - 5;
                this._iconSingle.y = this._goldTxt.y;
                addChild(this._iconSingle);
            }
            return;
        }// end function

        public function reset() : void
        {
            this._nameTxt.text = "";
            this._goldTxt.text = "";
            this._icon.setInfo(null);
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
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

        protected function __over(event:MouseEvent) : void
        {
            this.over();
            var _loc_2:* = DragManager.getInstance().isInDrag();
            if (this._isMine && _loc_2)
            {
                DragManager.getInstance().onMouseIn(this);
            }
            return;
        }// end function

        protected function __out(event:MouseEvent) : void
        {
            this.out();
            if (this._isMine && DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseOut(this);
            }
            return;
        }// end function

        protected function over() : void
        {
            if (!this._selected)
            {
                this._bg.gotoAndStop(2);
            }
            return;
        }// end function

        protected function out() : void
        {
            if (!this._selected)
            {
                this._bg.gotoAndStop(1);
            }
            return;
        }// end function

        public function getKey() : String
        {
            return "";
        }// end function

        public function acceptKey() : Array
        {
            return this._accpetKey;
        }// end function

    }
}
