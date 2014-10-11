package com.game.bank.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.bank.control.*;
    import com.game.bank.events.*;
    import com.game.bank.model.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.prompt.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MonthBankView extends Component
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var img:MovieClip;
        private var _img:Image;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn_txt1:MovieClip;
        private var btn_txt2:MovieClip;
        private var mc_List:MovieClip;
        private var list:List;
        private var url:String = "";
        public static var MONTH_DAYS:int = 31;

        public function MonthBankView()
        {
            UILoaded = false;
            initComponentUI("monthBankPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.txt3 = getDisplayChildByName("txt3");
            this.txt1.selectable = false;
            this.txt1.mouseWheelEnabled = false;
            this.txt2.selectable = false;
            this.txt2.mouseWheelEnabled = false;
            this.txt3.selectable = false;
            var _loc_1:* = PromptModel.getInstance().getItemFromMark("lfc_bank_001").system_message;
            var _loc_2:* = /<\/br>/g;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            this.txt1.htmlText = _loc_1;
            _loc_1 = PromptModel.getInstance().getItemFromMark("lfc_bank_002").system_message;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            _loc_2 = /\\n/g;
            _loc_1 = _loc_1.replace(_loc_2, "\n");
            this.txt2.htmlText = _loc_1;
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10384"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn_txt1 = getDisplayChildByName("btn_txt1");
            this.btn_txt2 = getDisplayChildByName("btn_txt2");
            var _loc_3:* = false;
            this.btn_txt1.mouseChildren = false;
            this.btn_txt1.mouseEnabled = _loc_3;
            var _loc_3:* = false;
            this.btn_txt2.mouseChildren = false;
            this.btn_txt2.mouseEnabled = _loc_3;
            this.btn_txt1.mouseChildren = false;
            this.btn_txt2.mouseChildren = false;
            this.mc_List = getDisplayChildByName("mc_List");
            this.list = new List(462, 178);
            this.mc_List.addChild(this.list);
            this.img = getDisplayChildByName("img");
            this._img = new Image();
            this._img.smoothing = true;
            this.img.addChild(this._img);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            BankData.getInstance().addEvtListener(BankEvent.MONTH_BANK_CHANGE, this.update);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    MallControl.getInstance().openMall(MallModel.BINDDIAMOND);
                    break;
                }
                case this.btn2:
                {
                    if (BankData.getInstance().buyLv == -1)
                    {
                        BankControl.getInstance().reqBuyBank(0);
                    }
                    else
                    {
                        BankControl.getInstance().bankBox.btnUpBank.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function update(event:BankEvent = null) : void
        {
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this.list.reset();
            var _loc_2:* = BankData.getInstance().buyLv;
            var _loc_3:* = BankData.getInstance().getSign;
            _loc_6 = false;
            _loc_7 = 0;
            _loc_8 = 0;
            while (_loc_8 < MONTH_DAYS)
            {
                
                _loc_9 = 0;
                if (_loc_2 == 0)
                {
                    if (_loc_3[_loc_8] != -1)
                    {
                        _loc_9 = 1;
                    }
                    else if (_loc_8 == BankData.getInstance().curryday || _loc_8 == 0)
                    {
                        _loc_9 = 2;
                    }
                    else if (_loc_8 < BankData.getInstance().curryday)
                    {
                        _loc_9 = 3;
                    }
                    else if (_loc_8 > BankData.getInstance().curryday)
                    {
                        _loc_9 = 4;
                    }
                }
                else
                {
                    _loc_9 = 4;
                }
                _loc_10 = new Object();
                _loc_10.state = _loc_9;
                _loc_11 = new MonthBankItem();
                _loc_11.index = _loc_8;
                _loc_11.obj = _loc_10;
                this.list.add(_loc_11);
                if (_loc_10.state == 2 && !_loc_6)
                {
                    _loc_6 = true;
                    _loc_7 = _loc_8;
                }
                _loc_8++;
            }
            this.list.scrollToByContent(_loc_7 * _loc_11.height);
            var _loc_4:* = MONTH_DAYS - BankData.getInstance().curryday - 1;
            var _loc_5:* = (MONTH_DAYS - BankData.getInstance().curryday - 1) * 100;
            if (_loc_3[0] == -1)
            {
                _loc_5 = _loc_5 + 1000;
            }
            if (_loc_2 != -1 && _loc_3[BankData.getInstance().curryday] == -1)
            {
                _loc_5 = _loc_5 + 100;
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_4 >= 0)
            {
                this.txt3.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11931"), [_loc_4, _loc_5]);
            }
            else
            {
                this.txt3.htmlText = LanguageCfgObj.getInstance().getByIndex("11932");
            }
            if (UILoaded)
            {
                if (_loc_2 == -1)
                {
                    this.btn_txt1.visible = true;
                    this.btn_txt2.visible = false;
                }
                else if (_loc_2 == 0)
                {
                    this.btn_txt1.visible = false;
                    this.btn_txt2.visible = true;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
