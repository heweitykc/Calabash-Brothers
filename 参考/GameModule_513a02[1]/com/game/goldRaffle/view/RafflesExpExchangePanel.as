package com.game.goldRaffle.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.view.component.*;
    import com.game.prompt.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class RafflesExpExchangePanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var _continueRaffleBtn:BaseButton;
        private var _raffleExpTxt:TextField;
        private var _scrollpanel:ScrollPanel;
        private var _bagContainer:HBox;
        private var _grc:GoldRaffleControl;
        private var _expNum:NumberMc;

        public function RafflesExpExchangePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this._grc = GoldRaffleControl.getInstance();
            this._expNum = new NumberMc();
            super(param1, param2, param3, param4);
            loadDisplay(GoldRafflesPanel.SWF);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("goldRaffles_rafflesExpExchange");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._continueRaffleBtn = new BaseButton(getDisplayChildByName("continueRaffleBtn"));
            this._continueRaffleBtn.setText(LanguageCfgObj.getInstance().getByIndex("10711"));
            this._raffleExpTxt = getDisplayChildByName("raffleExpTxt");
            this._expNum.move(82, 60);
            addChild(this._expNum);
            this._bagContainer = new HBox();
            this._bagContainer.intervalX = 1;
            this._bagContainer.intervalY = 3;
            this._bagContainer.oneRow = 4;
            this._bagContainer.move(5, 5);
            this._scrollpanel = new ScrollPanel(355, 386);
            this._scrollpanel.move(10, 87);
            addChild(this._scrollpanel);
            this.initContent();
            this.updateInfo();
            return;
        }// end function

        private function initContent() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = FractionCfgObj.getInstance().getFractionList();
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = 0;
            while (_loc_3 < 12 || _loc_3 < _loc_2 || _loc_3 % 4 != 0)
            {
                
                _loc_5 = new FractionBoxItem();
                if (_loc_3 < _loc_2)
                {
                    _loc_5.setInfo(_loc_1[_loc_3]);
                }
                this._bagContainer.add(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new Sprite();
            _loc_4.addChild(this._bagContainer);
            _loc_4.height = _loc_4.height + 7;
            this._scrollpanel.content = _loc_4;
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this._continueRaffleBtn:
                {
                    this._grc.continueRaffle();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this.updateInfo();
            return;
        }// end function

        public function updateInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (UILoaded)
            {
                _loc_1 = this._grc.rafflesExp;
                _loc_2 = this._bagContainer.length;
                this._expNum.setNumber(this._grc.rafflesExp);
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    (this._bagContainer.getChildAt(_loc_3) as FractionBoxItem).isCanExchange(_loc_1);
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function itemFlayToBack(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = FractionCfgObj.getInstance().getFractionList();
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4].fraction_id == param1)
                {
                    _loc_5 = this._bagContainer.getContent((_loc_4 - 1));
                    ItemGetAnim.doFlyToBackPack(_loc_2[_loc_4].fraction_item_id, _loc_5.globalToLocal(new Point(0, 0)));
                    return;
                }
                _loc_4++;
            }
            return;
        }// end function

    }
}
