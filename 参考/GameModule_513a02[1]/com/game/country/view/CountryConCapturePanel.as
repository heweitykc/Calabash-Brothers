package com.game.country.view
{
    import com.cfg.obj.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.country.bean.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryConCapturePanel extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var mc_List:MovieClip;
        private var _list:List;
        private var _countryConCaptureItem:CountryConCaptureItem;
        private var txt_con:TextField;

        public function CountryConCapturePanel()
        {
            _peaceBox = ["*"];
            loadDisplay("res/conCapture.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("ConCapture");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(424, 310);
            this.mc_List.addChild(this._list);
            this.txt_con = getDisplayChildByName("txt_con");
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_INFO_CHANGE, this.update);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            if (!UILoaded)
            {
                return;
            }
            this._list.reset();
            var _loc_2:* = CountryData.getInstance().countrystructureInfo;
            if (_loc_2)
            {
                _loc_5 = _loc_2.holdDay;
            }
            else
            {
                _loc_5 = 0;
            }
            this.txt_con.text = "" + _loc_5;
            var _loc_3:* = CountryCaptureCfgObj.getInstance().getCaptureInfo();
            for each (_loc_4 in _loc_3)
            {
                
                this._countryConCaptureItem = new CountryConCaptureItem();
                if (int(_loc_4.q_day) > _loc_5)
                {
                    _loc_4.enable = false;
                }
                else
                {
                    _loc_4.enable = true;
                }
                this._countryConCaptureItem.obj = _loc_4;
                this._list.add(this._countryConCaptureItem);
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
