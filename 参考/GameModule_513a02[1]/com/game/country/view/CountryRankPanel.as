package com.game.country.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.country.bean.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryRankPanel extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var mc_List:MovieClip;
        private var _list:List;
        private var _countryRankItem:CountryRankItem;
        private var txt_kill1:TextField;
        private var txt_kill2:TextField;
        private var txt_kill3:TextField;
        private var txt_kill4:TextField;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn_page:MovieClip;
        private var btn_pre:BaseButton;
        private var btn_next:BaseButton;
        private var txt_page:TextField;
        private var btn_jump:BaseButton;
        private var txt_jump:TextField;
        private var curPage:int = 1;
        private var totalPage:int = 1;

        public function CountryRankPanel()
        {
            loadDisplay("res/guildrank.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildRank");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(468, 333);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            this.txt_kill1 = getDisplayChildByName("txt_kill1");
            this.txt_kill2 = getDisplayChildByName("txt_kill2");
            this.txt_kill3 = getDisplayChildByName("txt_kill3");
            this.txt_kill4 = getDisplayChildByName("txt_kill4");
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10582"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10583"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10584"));
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("10585"));
            this.btn5.setText(LanguageCfgObj.getInstance().getByIndex("10586"));
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn_pre = new BaseButton(this.btn_page.getChildByName("btn_pre"));
            this.btn_next = new BaseButton(this.btn_page.getChildByName("btn_next"));
            this.txt_page = this.btn_page.getChildByName("txt_page") as TextField;
            this.txt_page.text = "1/1";
            this.btn_jump = new BaseButton(getDisplayChildByName("btn_jump"));
            this.btn_jump.setText(LanguageCfgObj.getInstance().getByIndex("10587"));
            this.txt_jump = getDisplayChildByName("txt_jump");
            this.txt_jump.text = "1";
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
            this.btn_pre.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_next.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_jump.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_TOP_INFO_CHANGE, this.update);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            switch(event.target)
            {
                case this.btn_pre:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.curPage - 1;
                    _loc_3.curPage = _loc_4;
                    if (this.curPage < 1)
                    {
                        this.curPage = 1;
                    }
                    this.txt_page.text = this.curPage + "/" + this.totalPage;
                    this.update();
                    break;
                }
                case this.btn_next:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.curPage + 1;
                    _loc_3.curPage = _loc_4;
                    if (this.curPage > this.totalPage)
                    {
                        this.curPage = this.totalPage;
                    }
                    this.txt_page.text = this.curPage + "/" + this.totalPage;
                    this.update();
                    break;
                }
                case this.btn_jump:
                {
                    _loc_2 = int(this.txt_jump.text);
                    if (_loc_2)
                    {
                        this.curPage = _loc_2;
                        this.update();
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

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            if (!UILoaded)
            {
                return;
            }
            this._list.reset();
            var _loc_2:* = CountryData.getInstance().countryTopInfolist;
            if (_loc_2)
            {
                this.totalPage = Math.ceil(_loc_2.length / 12);
                this.txt_page.text = this.curPage + "/" + this.totalPage;
                _loc_2 = _loc_2.slice((this.curPage - 1) * 12, this.curPage * 12);
            }
            else
            {
                this.curPage = 1;
                this.totalPage = 1;
                this.txt_page.text = this.curPage + "/" + this.totalPage;
            }
            this.txt_jump.maxChars = this.totalPage.toString().length;
            this.txt_jump.restrict = "1-" + this.totalPage;
            var _loc_3:* = 0;
            while (_loc_2 && _loc_3 < _loc_2.length)
            {
                
                this._countryRankItem = new CountryRankItem();
                this._countryRankItem.index = _loc_3;
                this._countryRankItem.obj = _loc_2[_loc_3];
                this._list.add(this._countryRankItem);
                _loc_3++;
            }
            var _loc_4:* = CountryData.getInstance().myCountryTopInfo;
            if (CountryData.getInstance().myCountryTopInfo)
            {
                this.txt_kill1.text = "" + _loc_4.kill;
                this.txt_kill2.text = "" + _loc_4.conKill;
                this.txt_kill3.text = "" + _loc_4.ranking;
                this.txt_kill4.text = "" + _loc_4.maxConKill;
            }
            else
            {
                this.txt_kill1.text = "";
                this.txt_kill2.text = "";
                this.txt_kill3.text = "";
                this.txt_kill4.text = "";
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
