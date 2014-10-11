package com.game.zones.view.clean
{
    import __AS3__.vec.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.backpack.bean.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesCleanAwards extends BaseBox
    {
        private var _btnClose:BaseButton;
        private var _btnSure:BaseButton;
        private var _txtExp:TextField;
        private var _txtMoney:TextField;

        public function ZonesCleanAwards(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            _combinedBox = ["com.game.zones.view.dekaron::ZonesDekaronPanel"];
            loadDisplay("res/zonescleanawards.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zones_clean_award");
            this.initUI();
            this.initEvent();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnSure = new BaseButton(getDisplayChildByName("btn_sure"));
            this._txtExp = TextField(getDisplayChildByName("txt_exp"));
            this._txtMoney = TextField(getDisplayChildByName("txt_money"));
            this.updatePanel();
            return;
        }// end function

        private function initEvent() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnSure:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function updatePanel() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (UILoaded)
            {
                _loc_1 = ZonesModel.getInstance().zonesAwardsInfo;
                _loc_4 = _loc_1.itemlist.length;
                _loc_5 = _loc_1.itemlist;
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_7 = _loc_5[_loc_6];
                    if (_loc_7.itemModelId == -1)
                    {
                        _loc_3 = _loc_7.num.toNumber();
                    }
                    else if (_loc_7.itemModelId == -2)
                    {
                    }
                    else if (_loc_7.itemModelId == -3)
                    {
                    }
                    else if (_loc_7.itemModelId == -4)
                    {
                        _loc_2 = _loc_7.num.toNumber();
                    }
                    this._txtExp.text = _loc_2.toString();
                    this._txtMoney.text = _loc_3.toString();
                    _loc_6++;
                }
            }
            return;
        }// end function

    }
}
