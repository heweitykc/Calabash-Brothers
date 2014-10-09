package com.game.cloudbuy.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.model.*;
    import com.game.map.control.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class CloudBuyTips extends BaseBox
    {
        private var btn_sub:BaseButton;
        private var btn_add:BaseButton;
        private var btn_max:BaseButton;
        private var txt_count:TextField;
        private var txt_totalprice:TextField;
        private var close_btn:BaseButton;
        private var btn_buy:BaseButton;
        private var btn_cancel:BaseButton;
        private var _maxNum:int = 1;
        private var _curNum:int = 1;

        public function CloudBuyTips()
        {
            loadDisplay("res/cloudbuytips.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("CloudBuyTips");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_sub = new BaseButton(getDisplayChildByName("btn_sub"));
            this.btn_add = new BaseButton(getDisplayChildByName("btn_add"));
            this.btn_max = new BaseButton(getDisplayChildByName("btn_max"));
            this.txt_count = getDisplayChildByName("txt_count");
            this.txt_count.addEventListener(Event.CHANGE, this.__textInputNum, false, 0, true);
            this.txt_totalprice = getDisplayChildByName("txt_totalprice");
            this.btn_buy = new BaseButton(getDisplayChildByName("btn_buy"));
            this.btn_buy.setText(LanguageCfgObj.getInstance().getByIndex("12378"));
            this.btn_cancel = new BaseButton(getDisplayChildByName("btn_cancel"));
            this.btn_cancel.setText(LanguageCfgObj.getInstance().getByIndex("11548"));
            this.btn_sub.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_add.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_max.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_buy.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_cancel.addEvtListener(MouseEvent.CLICK, this.__click);
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.close_btn)
            {
                this.close_btn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.close_btn, Layout.RIGHT, 5, 5);
            this.update();
            return;
        }// end function

        private function __textInputNum(event:Event) : void
        {
            var _loc_2:* = int(this.txt_count.text);
            if (_loc_2 > this.maxNum)
            {
                _loc_2 = this.maxNum;
            }
            this._curNum = _loc_2;
            this.txt_count.text = _loc_2.toString();
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn_sub:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._curNum - 1;
                    _loc_2._curNum = _loc_3;
                    if (this._curNum < 1)
                    {
                        this._curNum = 1;
                    }
                    this.update();
                    break;
                }
                case this.btn_add:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._curNum + 1;
                    _loc_2._curNum = _loc_3;
                    if (this._curNum > this.maxNum)
                    {
                        this._curNum = this.maxNum;
                    }
                    this.update();
                    break;
                }
                case this.btn_max:
                {
                    this._curNum = this.maxNum;
                    this.update();
                    break;
                }
                case this.btn_buy:
                {
                    if (UserObj.getInstance().playerInfo.gold < int(this.txt_totalprice.text))
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    else
                    {
                        CloudBuyControl.getInstance().reqCloudBuy(this._curNum);
                    }
                    break;
                }
                case this.btn_cancel:
                {
                    this.__close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (UILoaded)
            {
                this.txt_count.text = this._curNum.toString();
                _loc_1 = CloudBuyData.getInstance().cloudBuyID;
                _loc_2 = CloudBuyCfgObj.getInstance().getCloudBuyInfoById(_loc_1);
                this.txt_totalprice.text = "" + _loc_2.q_price * int(this.txt_count.text);
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        public function get maxNum() : int
        {
            return this._maxNum;
        }// end function

        public function set maxNum(param1:int) : void
        {
            this._maxNum = param1;
            this._curNum = 1;
            return;
        }// end function

    }
}
