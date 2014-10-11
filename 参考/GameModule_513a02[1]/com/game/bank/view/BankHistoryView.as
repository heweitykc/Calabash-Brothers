package com.game.bank.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.bank.control.*;
    import com.game.bank.events.*;
    import com.game.bank.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BankHistoryView extends Component
    {
        private var mc_List:MovieClip;
        private var check_btn1:BaseButton;
        private var check_btn2:BaseButton;
        private var check_btn3:BaseButton;
        private var checkBtnArray:Array;
        private var funArray:Array;
        private var _list:List;
        private var _bankHistoryItem:BankHistoryItem;
        private var btn_page:MovieClip;
        private var btn_pre:BaseButton;
        private var btn_next:BaseButton;
        private var txt_page:TextField;
        private var curPage:int = 1;
        private var maxPage:int = 1;

        public function BankHistoryView()
        {
            this.checkBtnArray = [];
            this.funArray = [];
            initComponentUI("bankHistory");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List") as MovieClip;
            this.check_btn1 = new BaseButton(getDisplayChildByName("check_btn1"), true);
            this.check_btn1.selected = false;
            this.check_btn1.setText(LanguageCfgObj.getInstance().getByIndex("10378"));
            this.check_btn2 = new BaseButton(getDisplayChildByName("check_btn2"), true);
            this.check_btn2.selected = false;
            this.check_btn2.setText(LanguageCfgObj.getInstance().getByIndex("10379"));
            this.check_btn3 = new BaseButton(getDisplayChildByName("check_btn3"), true);
            this.check_btn3.selected = false;
            this.check_btn3.setText(LanguageCfgObj.getInstance().getByIndex("10380"));
            this.checkBtnArray.push(this.check_btn1, this.check_btn2, this.check_btn3);
            this.funArray.push(this.sendTotal, this.sendIn, this.sendOut);
            this._list = new List(454, 350);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn_pre = new BaseButton(this.btn_page.getChildByName("btn_pre"));
            this.btn_next = new BaseButton(this.btn_page.getChildByName("btn_next"));
            this.txt_page = this.btn_page.getChildByName("txt_page") as TextField;
            this.txt_page.text = "1/100";
            return;
        }// end function

        private function addEvents() : void
        {
            this.check_btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_pre.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_next.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            BankData.getInstance().addEvtListener(BankEvent.BANK_HISTORY_CHANGE, this.updateHistory);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.checkBtnArray.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.checkBtnArray.length)
            {
                
                if (this.checkBtnArray[_loc_3] == event.target)
                {
                    this.checkBtnArray[_loc_3].selected = true;
                    this.curPage = 1;
                    this._list.reset();
                    this.txt_page.text = "1/1";
                    this.funArray[_loc_3].call();
                }
                else
                {
                    this.checkBtnArray[_loc_3].selected = false;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn_pre:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage - 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage < 1)
                    {
                        this.curPage = 1;
                    }
                    break;
                }
                case this.btn_next:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage + 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage > this.maxPage)
                    {
                        this.curPage = this.maxPage;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.check_btn1.selected)
            {
                BankControl.getInstance().reqQueryBankLog(0, (this.curPage - 1) * 12, this.curPage * 12 > (BankData.getInstance().count - 1) ? ((BankData.getInstance().count - 1)) : (this.curPage * 12));
            }
            else if (this.check_btn2.selected)
            {
                BankControl.getInstance().reqQueryBankLog(2, (this.curPage - 1) * 12, this.curPage * 12 > (BankData.getInstance().count - 1) ? ((BankData.getInstance().count - 1)) : (this.curPage * 12));
            }
            else if (this.check_btn3.selected)
            {
                BankControl.getInstance().reqQueryBankLog(1, (this.curPage - 1) * 12, this.curPage * 12 > (BankData.getInstance().count - 1) ? ((BankData.getInstance().count - 1)) : (this.curPage * 12));
            }
            return;
        }// end function

        public function sendTotal() : void
        {
            BankControl.getInstance().reqQueryBankLog(0, (this.curPage - 1) * 12, this.curPage * 12);
            return;
        }// end function

        public function sendIn() : void
        {
            BankControl.getInstance().reqQueryBankLog(2, (this.curPage - 1) * 12, this.curPage * 12);
            return;
        }// end function

        public function sendOut() : void
        {
            BankControl.getInstance().reqQueryBankLog(1, (this.curPage - 1) * 12, this.curPage * 12);
            return;
        }// end function

        public function update() : void
        {
            this.curPage = 1;
            this.check_btn1.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function updateHistory(event:BankEvent = null) : void
        {
            var _loc_4:* = 0;
            this._list.reset();
            var _loc_2:* = BankData.getInstance().bankLogs;
            var _loc_3:* = BankData.getInstance().count;
            this.maxPage = Math.ceil(_loc_3 / 12);
            this.txt_page.text = this.curPage + "/" + this.maxPage;
            if (_loc_2)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_2.length)
                {
                    
                    this._bankHistoryItem = new BankHistoryItem();
                    this._bankHistoryItem.obj = _loc_2[_loc_4];
                    this._list.add(this._bankHistoryItem);
                    _loc_4++;
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
