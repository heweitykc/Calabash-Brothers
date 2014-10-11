package com.game.zones.view.wolfsoul
{
    import com.f1.*;
    import com.game.goldRaffle.control.*;
    import com.game.zones.control.*;
    import com.game.zones.view.belialworld.*;
    import flash.events.*;

    public class ZoneWolfSoulTraceView extends ZonesBeliaworldTraceView
    {
        private var TXT_WORD_GOLD_GET_GIFT:String;
        private var _curPhase:int;

        public function ZoneWolfSoulTraceView()
        {
            this.TXT_WORD_GOLD_GET_GIFT = LanguageCfgObj.getInstance().getByIndex("11528");
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            _btnAwait.visible = false;
            _txtAwait.visible = false;
            _txtTarget.text = LanguageCfgObj.getInstance().getByIndex("11529");
            _txtTitle.text = LanguageCfgObj.getInstance().getByIndex("11530");
            _bgView.height = _bgView.height - 40;
            _txtdowntimeTitle.y = _txtdowntimeTitle.y - 40;
            _txtDownTime.y = _txtDownTime.y - 40;
            _txtGoldGetGift.htmlText = "<u>" + this.TXT_WORD_GOLD_GET_GIFT + "</u>";
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.setPhase(this._curPhase);
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._txtGoldGetGift:
                {
                    this._txtGoldGetGift.htmlText = "<u>" + this.TXT_WORD_GOLD_GET_GIFT + "</u>";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._txtGoldGetGift:
                {
                    this._txtGoldGetGift.htmlText = this.TXT_WORD_GOLD_GET_GIFT;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnAwait:
                {
                    break;
                }
                case this._btnGlod:
                {
                    ZonesControl.getInstance().reqAddInspireBuff(1);
                    break;
                }
                case this._btnMoney:
                {
                    ZonesControl.getInstance().reqAddInspireBuff(0);
                    break;
                }
                case this._txtGoldGetGift:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function setZoneLife(param1:int, param2:int) : void
        {
            if (param2 > 0)
            {
                this._downTime.count = param1 * 1000;
                if (UILoaded)
                {
                    this._txtdowntimeTitle.visible = true;
                    this._txtDownTime.visible = true;
                }
            }
            else if (UILoaded)
            {
                this._txtdowntimeTitle.visible = false;
                this._txtDownTime.visible = false;
            }
            this.setPhase(param2);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._curPhase = param1;
            if (UILoaded)
            {
                this._txtPhase.text = "(" + param1 + "/6)";
            }
            return;
        }// end function

    }
}
