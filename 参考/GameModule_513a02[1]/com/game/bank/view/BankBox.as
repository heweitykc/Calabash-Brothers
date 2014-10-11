package com.game.bank.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.bank.control.*;
    import com.game.bank.events.*;
    import com.game.bank.model.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class BankBox extends BaseBox
    {
        private var _monthBankView:MonthBankView;
        private var _upBankView:UpBankView;
        private var _bankHistoryView:BankHistoryView;
        private var closeBtn:BaseButton;
        private var btn_monthBank:BaseButton;
        private var btn_upBank:BaseButton;
        private var btn_history:BaseButton;
        private var mc_horn:MovieClip;
        private var _type:int = 1;
        private var btnAry:Array;
        private var viewAry:Array;

        public function BankBox()
        {
            this.btnAry = [];
            this.viewAry = [];
            loadDisplay("res/bankbox.swf");
            return;
        }// end function

        public function get btnUpBank() : BaseButton
        {
            return this.btn_upBank;
        }// end function

        public function get monthBankView() : MonthBankView
        {
            if (!this._monthBankView)
            {
                this._monthBankView = new MonthBankView();
                addChild(this._monthBankView);
                this.viewAry[0] = this._monthBankView;
            }
            return this._monthBankView;
        }// end function

        public function get upBankView() : UpBankView
        {
            if (!this._upBankView)
            {
                this._upBankView = new UpBankView();
                addChild(this._upBankView);
                this.viewAry[1] = this._upBankView;
            }
            return this._upBankView;
        }// end function

        public function get bankHistoryView() : BankHistoryView
        {
            if (!this._bankHistoryView)
            {
                this._bankHistoryView = new BankHistoryView();
                addChild(this._bankHistoryView);
                this.viewAry[2] = this._bankHistoryView;
            }
            return this._bankHistoryView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("bankBox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_monthBank = new BaseButton(getDisplayChildByName("btn_monthBank"));
            this.btn_upBank = new BaseButton(getDisplayChildByName("btn_upBank"));
            this.btn_history = new BaseButton(getDisplayChildByName("btn_history"));
            this.btn_monthBank.setText(LanguageCfgObj.getInstance().getByIndex("10375"));
            this.btn_upBank.setText(LanguageCfgObj.getInstance().getByIndex("10376"));
            this.btn_history.setText(LanguageCfgObj.getInstance().getByIndex("10377"));
            this.btnAry.push(this.btn_monthBank);
            this.btnAry.push(this.btn_upBank);
            this.btnAry.push(this.btn_history);
            this.btnAry[0].selected = true;
            this.mc_horn = getDisplayChildByName("mc_horn");
            this.choose(this._type);
            this.setAnimmation();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_monthBank.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_upBank.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_history.addEvtListener(MouseEvent.CLICK, this.__click);
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            BankData.getInstance().addEvtListener(BankEvent.BANK_HISTORY_CHANGE, this.setAnimmation);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            if (this._type == (_loc_2 + 1))
            {
                return;
            }
            this._type = _loc_2 + 1;
            this.choose(this._type);
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            Ticker.killTimer(this.changeTxt);
            super.close();
            return;
        }// end function

        override public function close() : void
        {
            Ticker.killTimer(this.changeTxt);
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.choose(this._type);
            }
            return;
        }// end function

        private function setAnimmation(event:BankEvent = null) : void
        {
            Ticker.killTimer(this.changeTxt);
            Ticker.registerTimer(5, this.changeTxt);
            return;
        }// end function

        private function changeTxt() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = BankData.getInstance().bankLogs;
            if (_loc_1 && _loc_1.length)
            {
                _loc_2 = Math.floor(Math.random() * _loc_1.length);
                if (_loc_1[_loc_2].option <= 1)
                {
                    if (_loc_1[_loc_2].option == 0 || _loc_1[_loc_2].option == 2)
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11926");
                    }
                    else
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11927");
                    }
                }
                else if (_loc_1[_loc_2].option == 0 || _loc_1[_loc_2].option == 2)
                {
                    _loc_3 = LanguageCfgObj.getInstance().getByIndex("11928");
                }
                else
                {
                    _loc_3 = LanguageCfgObj.getInstance().getByIndex("11929");
                }
                this.mc_horn.txt1.htmlText = StringUtil.languageReplace(_loc_3, ["<font color=\'#00ff00\'>" + _loc_1[_loc_2].playerName + "</font>", _loc_1[_loc_2].count]);
                _loc_2 = Math.floor(Math.random() * _loc_1.length);
                if (_loc_1[_loc_2].option <= 1)
                {
                    if (_loc_1[_loc_2].option == 0 || _loc_1[_loc_2].option == 2)
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11926");
                    }
                    else
                    {
                        _loc_3 = LanguageCfgObj.getInstance().getByIndex("11927");
                    }
                }
                else if (_loc_1[_loc_2].option == 0 || _loc_1[_loc_2].option == 2)
                {
                    _loc_3 = LanguageCfgObj.getInstance().getByIndex("11928");
                }
                else
                {
                    _loc_3 = LanguageCfgObj.getInstance().getByIndex("11929");
                }
                this.mc_horn.txt2.htmlText = StringUtil.languageReplace(_loc_3, ["<font color=\'#00ff00\'>" + _loc_1[_loc_2].playerName + "</font>", _loc_1[_loc_2].count]);
                this.mc_horn.txt1.alpha = 1;
                this.mc_horn.txt1.y = 7;
                TweenLite.to(this.mc_horn.txt1, 0.5, {y:this.mc_horn.txt1.y - 10, alpha:0});
                this.mc_horn.txt2.alpha = 0;
                this.mc_horn.txt2.y = 7 + 10;
                TweenLite.to(this.mc_horn.txt2, 0.5, {y:this.mc_horn.txt2.y - 10, alpha:1});
            }
            return;
        }// end function

        private function choose(param1:int = 1) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.btnAry.length)
            {
                
                if (param1 == (_loc_2 + 1))
                {
                    if (this.btnAry[_loc_2])
                    {
                        this.btnAry[_loc_2].selected = true;
                    }
                    if (this.viewAry[_loc_2])
                    {
                        this.viewAry[_loc_2].visible = true;
                    }
                }
                else
                {
                    if (this.btnAry[_loc_2])
                    {
                        this.btnAry[_loc_2].selected = false;
                    }
                    if (this.viewAry[_loc_2])
                    {
                        this.viewAry[_loc_2].visible = false;
                    }
                }
                _loc_2++;
            }
            switch(param1)
            {
                case 1:
                {
                    BankControl.getInstance().reqQueryBankLog(0, 0, 30);
                    BankControl.getInstance().reqQueryBank(0);
                    this.monthBankView.update();
                    break;
                }
                case 2:
                {
                    BankControl.getInstance().reqQueryBank(1);
                    this.upBankView.update();
                    break;
                }
                case 3:
                {
                    this.bankHistoryView.update();
                    break;
                }
                default:
                {
                    break;
                }
            }
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

    }
}
