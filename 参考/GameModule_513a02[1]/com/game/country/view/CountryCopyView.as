package com.game.country.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.country.bean.*;
    import com.game.country.control.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import com.game.guild.model.*;
    import com.game.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryCopyView extends Component
    {
        private const HIT_QUIT_INSTANCE:String;
        private var mc_info:MovieClip;
        private var mc_captureTime:MovieClip;
        private var maskWidth:Number;
        private var _btnQuit:BaseButton;
        private var txtcapturetime:TextField;
        private var txtlefttime:TextField;
        private var txt_winLeftTime:TextField;
        private var txtGuildName:TextField;
        private var txt_kill1:TextField;
        private var txt_kill2:TextField;
        private var txt_kill3:TextField;
        private var txt_kill4:TextField;
        private var btn_look:BaseButton;
        private var btnRank:BaseButton;
        private var btn_down:BaseButton;
        private var btn_up:BaseButton;
        private var _holderid:long;
        private var _holderGuildId:long;
        private var _capturetime:int = 0;
        private var _lefttime:int = 0;
        private var mc_List:MovieClip;
        private var _list:List;
        private var _countryRankItem:CountryListRankItem;
        private const LAST_TIME:int = 900;

        public function CountryCopyView(param1 = null, param2:String = null)
        {
            this.HIT_QUIT_INSTANCE = LanguageCfgObj.getInstance().getByIndex("11685");
            super(param1, param2);
            loadDisplay("res/countryCopy.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("countryCopyPanel");
            this.initUI();
            this.addEvents();
            this.updateTime();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_info = getDisplayChildByName("mc_info");
            this.mc_captureTime = this.mc_info.getChildByName("mc_captureTime") as MovieClip;
            this.maskWidth = this.mc_captureTime.width;
            this._btnQuit = new BaseButton(this.mc_info.getChildByName("btnquit"));
            this.txtcapturetime = this.mc_info.getChildByName("txtcapturetime") as TextField;
            this.txtlefttime = this.mc_info.getChildByName("txtlefttime") as TextField;
            this.txt_winLeftTime = this.mc_info.getChildByName("txt_winLeftTime") as TextField;
            this.txt_winLeftTime.visible = false;
            this.txtGuildName = this.mc_info.getChildByName("txtGuildName") as TextField;
            this.txt_kill1 = this.mc_info.getChildByName("txt_kill1") as TextField;
            this.txt_kill2 = this.mc_info.getChildByName("txt_kill2") as TextField;
            this.txt_kill3 = this.mc_info.getChildByName("txt_kill3") as TextField;
            this.txt_kill4 = this.mc_info.getChildByName("txt_kill4") as TextField;
            this.btn_look = new BaseButton(this.mc_info.getChildByName("btn_look"));
            this.btnRank = new BaseButton(this.mc_info.getChildByName("btnRank"));
            this.btnRank.setText(LanguageCfgObj.getInstance().getByIndex("10569"));
            this.btnRank.visible = false;
            this.btn_down = new BaseButton(getDisplayChildByName("btn_down"));
            this.btn_up = new BaseButton(getDisplayChildByName("btn_up"));
            this.btn_down.visible = false;
            this.mc_List = this.mc_info.getChildByName("mc_List") as MovieClip;
            this._list = new List(250, 115);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(TextEvent.LINK, this.linkHandler);
            this.btn_down.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.btn_up.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_WAR_INFO_CHANGE, this.updateTime);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_WAR_OVER, this.countryOver);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_TOP_INFO_CHANGE, this.update);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnQuit:
                {
                    this.clickQuit();
                    break;
                }
                case this.btn_look:
                {
                    CountryControl.getInstance().openCountryRankPanel();
                    break;
                }
                case this.btn_down:
                {
                    this.btn_down.visible = false;
                    this.btn_up.visible = true;
                    this.mc_info.visible = true;
                    break;
                }
                case this.btn_up:
                {
                    this.btn_down.visible = true;
                    this.btn_up.visible = false;
                    this.mc_info.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickQuit() : void
        {
            var _loc_1:* = this.HIT_QUIT_INSTANCE;
            Global.popManager.cue(_loc_1, "", null, this.callClickYes);
            return;
        }// end function

        private function callClickYes() : void
        {
            CountryControl.getInstance().resCountrySiegeSelect(2);
            return;
        }// end function

        protected function linkHandler(event:Event) : void
        {
            return;
        }// end function

        private function updateTime(event:CountryEvent = null) : void
        {
            var _loc_2:* = CountryData.getInstance().countrywarinfo;
            if (!_loc_2)
            {
                return;
            }
            this._holderid = _loc_2.holderid;
            this._holderGuildId = _loc_2.holderguildid;
            this._capturetime = _loc_2.holdertime;
            this._lefttime = _loc_2.warendtime;
            if (this._capturetime > 0 || !this._holderid.equal(new long(0, 0)))
            {
            }
            this.txtGuildName.text = GuildData.getInstance().getGuildNameById(this._holderGuildId);
            Ticker.killTimer(this.timeHandler);
            this.timeHandler();
            Ticker.registerTimer(1, this.timeHandler);
            return;
        }// end function

        private function timeHandler() : void
        {
            if (this._capturetime > 0 || !this._holderid.equal(new long(0, 0)))
            {
                var _loc_1:* = this;
                var _loc_2:* = this._capturetime + 1;
                _loc_1._capturetime = _loc_2;
                this.txt_winLeftTime.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11970"), [int((this.LAST_TIME - this._capturetime) / 60), int((this.LAST_TIME - this._capturetime) % 60)]);
            }
            else
            {
                this.txt_winLeftTime.visible = false;
            }
            if (this._lefttime > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._lefttime - 1;
                _loc_1._lefttime = _loc_2;
            }
            this.txtcapturetime.text = "" + ToolKit.getTimeBySecond(this._capturetime);
            if (this._capturetime >= 15 * 60)
            {
                this.txtcapturetime.textColor = 16711680;
            }
            else
            {
                this.txtcapturetime.textColor = 16766079;
            }
            this.txtlefttime.text = "" + ToolKit.getTimeBySecond(this._lefttime);
            if (this._lefttime <= 5 * 60)
            {
                this.txtlefttime.textColor = 16711680;
            }
            else
            {
                this.txtlefttime.textColor = 52224;
            }
            this.mc_captureTime.mc_mask.width = this._capturetime / this.LAST_TIME * this.maskWidth;
            return;
        }// end function

        private function countryOver(event:CountryEvent) : void
        {
            Ticker.killTimer(this.timeHandler);
            this._capturetime = 0;
            this._lefttime = 0;
            if (this.txtcapturetime)
            {
                this.txtcapturetime.text = "00:00:00";
            }
            if (this.txtlefttime)
            {
                this.txtlefttime.text = "00:00:00";
            }
            if (this.txt_winLeftTime)
            {
                this.txt_winLeftTime.text = LanguageCfgObj.getInstance().getByIndex("10570");
            }
            this._list.reset();
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (!this.parent)
            {
                return;
            }
            if (UILoaded)
            {
                this._list.reset();
                _loc_2 = CountryData.getInstance().countryTopInfolist;
                _loc_3 = 0;
                while (_loc_2 && _loc_3 < _loc_2.length)
                {
                    
                    this._countryRankItem = new CountryListRankItem();
                    this._countryRankItem.index = _loc_3 + 1;
                    this._countryRankItem.obj = _loc_2[_loc_3];
                    this._list.add(this._countryRankItem);
                    _loc_3++;
                }
                _loc_4 = CountryData.getInstance().myCountryTopInfo;
                if (_loc_4)
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
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 5, 170));
            this.update();
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

    }
}
