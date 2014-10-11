package com.game.backpack.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ItemSpiltPanel extends BaseBox
    {
        private var _closebtn:BaseButton;
        private var _totalIcon:IconItem;
        private var _oneIcon:IconItem;
        private var _otherIcon:IconItem;
        private var _addBtn:BaseButton;
        private var _subBtn:BaseButton;
        private var _countTxt:TextField;
        private var _stripe:Stripe;
        private var _info:PropInfo;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _count:int;
        private var _countTimeId:int;
        private var _timeOutId:int;
        private var _addOper:int;
        private var _orginValue:int;
        private var _preTime:int;

        public function ItemSpiltPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            _peaceBox = ["*"];
            loadDisplay("res/itemspiltpanel.swf");
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            if (this._countTxt)
            {
                this._countTxt.text = param1.toString();
            }
            if (this._oneIcon && this._oneIcon.info)
            {
                (this._oneIcon.info as PropInfo).num = param1;
                this._oneIcon.count = param1;
            }
            if (this._otherIcon && this._otherIcon.info)
            {
                (this._otherIcon.info as PropInfo).num = this._info.num - param1;
                this._otherIcon.count = this._info.num - param1;
            }
            this._stripe.setValue(this.count, this._info.num);
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("itemspiltpanel");
            this.initUI();
            this.addlisteners();
            this.update();
            super.displayReady();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._totalIcon = new IconItem(getDisplayChildByName("total"));
            this._totalIcon.setImageXY(7, 7);
            var _loc_1:* = 45;
            var _loc_2:* = 36;
            this._totalIcon.setCountTxtXY(_loc_1, _loc_2);
            addChild(this._totalIcon);
            this._oneIcon = new IconItem(getDisplayChildByName("one"));
            this._oneIcon.setImageXY(7, 7);
            this._oneIcon.setCountTxtXY(_loc_1, _loc_2);
            addChild(this._oneIcon);
            this._otherIcon = new IconItem(getDisplayChildByName("other"));
            this._otherIcon.setImageXY(7, 7);
            this._otherIcon.setCountTxtXY(_loc_1, _loc_2);
            addChild(this._otherIcon);
            this._countTxt = getDisplayChildByName("txt_count");
            this._countTxt.maxChars = 4;
            this._countTxt.restrict = "0-9";
            this._addBtn = new BaseButton(getDisplayChildByName("btn_add"));
            this._subBtn = new BaseButton(getDisplayChildByName("btn_sub"));
            this._stripe = new Stripe(getDisplayChildByName("stripe"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._closebtn = new BaseButton(getDisplayChildByName("close_btn1"));
            return;
        }// end function

        private function addlisteners() : void
        {
            this._addBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._subBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._addBtn.addEvtListener(MouseEvent.CLICK, this.__addClick);
            this._subBtn.addEvtListener(MouseEvent.CLICK, this.__subClick);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._closebtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._countTxt.addEventListener(Event.CHANGE, this.__countChange, false, 0, true);
            return;
        }// end function

        private function __countChange(event:Event) : void
        {
            clearTimeout(this._countTimeId);
            this._countTimeId = setTimeout(this.checkCount, 200);
            return;
        }// end function

        private function checkCount() : void
        {
            var _loc_1:* = int(this._countTxt.text);
            if (_loc_1 < 1)
            {
                _loc_1 = 1;
            }
            this.count = _loc_1 > (this._info.num - 1) ? ((this._info.num - 1)) : (_loc_1);
            return;
        }// end function

        private function update() : void
        {
            this._totalIcon.setInfo(this._info);
            var _loc_1:* = PropUtil.createItemByCfg(this._info.itemModelId);
            this._oneIcon.setInfo(_loc_1);
            var _loc_2:* = PropUtil.createItemByCfg(this._info.itemModelId);
            this._otherIcon.setInfo(_loc_2);
            this.count = 1;
            return;
        }// end function

        private function __addClick(event:MouseEvent) : void
        {
            if (this._orginValue == int(this._countTxt.text))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._count + 1;
                _loc_2._count = _loc_3;
                if (this._count > (this._info.num - 1))
                {
                    this._count = this._info.num - 1;
                }
                this.count = this._count;
            }
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
            if (this._addOper == 1 && _loc_1 < (this._info.num - 1))
            {
                addEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            }
            if (this._addOper == -1 && _loc_1 > 1)
            {
                addEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            }
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
                if (_loc_3 >= (this._info.num - 1) - this._orginValue)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                    this._addOper = 0;
                    _loc_3 = (this._info.num - 1) - this._orginValue;
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
            this.count = _loc_2;
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
                this.count = this._count;
            }
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            if (!BackpackObj.getInstance().isFull())
            {
                BackPackControl.getInstance().spilt(this._info.itemId, this.count);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10367"));
            }
            close();
            return;
        }// end function

        private function __cancelClick(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
