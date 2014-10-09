package com.game.country.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.country.bean.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import com.game.guild.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryOverRankPanel extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;
        private var txt_guildName:TextField;
        private var txt_kill1:TextField;
        private var txt_kill2:TextField;
        private var txt_kill3:TextField;
        private var txt_kill4:TextField;
        private var btn_page:MovieClip;
        private var btn_pre:BaseButton;
        private var btn_next:BaseButton;
        private var txt_page:TextField;
        private var btn_jump:BaseButton;
        private var txt_jump:TextField;
        private var curPage:int = 1;
        private var totalPage:int = 1;
        private var mc1:DisplayObject;
        private var mc2:DisplayObject;
        private var mc_success:MovieClip;
        private var mc_List:MovieClip;
        private var _list:List;
        private var _countryRankItem:CountryOverRankItem;
        private var array:Array;

        public function CountryOverRankPanel()
        {
            this.array = [576, 144];
            loadDisplay("res/countryCopyOverPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("countryCopyOverPanel");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_success = getDisplayChildByName("mc_success");
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(465, 332);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn6 = new BaseButton(getDisplayChildByName("btn6"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10575"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10576"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10577"));
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("10578"));
            this.btn5.setText(LanguageCfgObj.getInstance().getByIndex("10579"));
            this.txt_guildName = getDisplayChildByName("txt_guildName");
            this.txt_kill1 = getDisplayChildByName("txt_kill1");
            this.txt_kill2 = getDisplayChildByName("txt_kill2");
            this.txt_kill3 = getDisplayChildByName("txt_kill3");
            this.txt_kill4 = getDisplayChildByName("txt_kill4");
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn_pre = new BaseButton(this.btn_page.getChildByName("btn_pre"));
            this.btn_next = new BaseButton(this.btn_page.getChildByName("btn_next"));
            this.txt_page = this.btn_page.getChildByName("txt_page") as TextField;
            this.txt_page.text = "1/1";
            this.btn_jump = new BaseButton(getDisplayChildByName("btn_jump"));
            this.btn_jump.setText(LanguageCfgObj.getInstance().getByIndex("10580"));
            this.txt_jump = getDisplayChildByName("txt_jump");
            this.txt_jump.text = "1";
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.update();
            return;
        }// end function

        private function showAward(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 2)
            {
                
                _loc_3 = new PropInfo();
                _loc_3 = new PropInfo();
                _loc_3.q_name = LanguageCfgObj.getInstance().getByIndex("10581");
                _loc_3.url = Params.ITEM_PATH + "i50001.png";
                _loc_3.itemModelId = SpecialItemType.EXP;
                _loc_4 = LevelExpCfgObj.getInstance().getQ_rexp(UserObj.getInstance().playerInfo.job, UserObj.getInstance().playerInfo.level);
                _loc_5 = CountryData.getInstance().overExp;
                _loc_6 = CountryData.getInstance().overKill;
                _loc_7 = 0;
                switch(_loc_2)
                {
                    case 0:
                    {
                        _loc_7 = _loc_4 * (2880 + _loc_6 * 4);
                        break;
                    }
                    case 1:
                    {
                        _loc_7 = _loc_4 * (720 + _loc_6 * 4);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3.num = _loc_7;
                _loc_8 = new IconItem("commonRewardBox2_40");
                _loc_8.setWH(40, 40);
                _loc_8.image.move(3, 3);
                _loc_8.setInfo(_loc_3);
                ToolKit.clearMcChild(this["mc" + (_loc_2 + 1)]);
                (this["mc" + (_loc_2 + 1)] as DisplayObjectContainer).addChild(_loc_8);
                _loc_2++;
            }
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

        override public function open() : void
        {
            super.open();
            this.curPage = 1;
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
                
                this._countryRankItem = new CountryOverRankItem();
                this._countryRankItem.index = _loc_3;
                this._countryRankItem.obj = _loc_2[_loc_3];
                this._list.add(this._countryRankItem);
                _loc_3++;
            }
            var _loc_4:* = CountryData.getInstance().myCountryTopInfo;
            if (CountryData.getInstance().myCountryTopInfo)
            {
                this.txt_kill1.text = "" + _loc_4.kill;
                this.txt_kill2.text = "" + _loc_4.ranking;
                this.txt_kill3.text = "" + _loc_4.maxConKill;
                this.txt_kill4.text = "" + _loc_4.conKill;
            }
            else
            {
                this.txt_kill1.text = "";
                this.txt_kill2.text = "";
                this.txt_kill3.text = "";
                this.txt_kill4.text = "";
            }
            var _loc_5:* = CountryData.getInstance().curentCaptureID;
            var _loc_6:* = UserObj.getInstance().playerInfo.guildId;
            var _loc_7:* = false;
            if (_loc_5)
            {
                this.txt_guildName.text = "" + GuildData.getInstance().getGuildNameById(_loc_5);
                if (_loc_5.equal(_loc_6))
                {
                    this.mc_success.gotoAndStop(1);
                    _loc_7 = true;
                }
                else
                {
                    this.mc_success.gotoAndStop(2);
                    _loc_7 = false;
                }
            }
            else
            {
                this.txt_guildName.text = "";
                this.mc_success.gotoAndStop(2);
                _loc_7 = false;
            }
            this.showAward(_loc_7);
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

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
