package com.game.country.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.clickstream.*;
    import com.game.country.bean.*;
    import com.game.country.control.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import com.game.guide.control.*;
    import com.game.map.bean.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryView extends Component
    {
        private var txt_time:TextField;
        private var txt_guildName:TextField;
        private var txt_captureDays:TextField;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var img_award:MovieClip;
        private var mc_awardBox:MovieClip;
        private var btn_getAward:BaseButton;
        private var btnFightCityBuff:BaseButton;
        private var btn_bannel:BaseButton;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var mc_rule:MovieClip;
        private var btn_goto:BaseButton;
        private var btn_close:BaseButton;
        private var _countrystructureInfo:CountryStructureInfo;
        private var awardID:int = 700153;
        private var npcArray:Array;
        private var effect:VMCView;

        public function CountryView()
        {
            this.npcArray = [0, 500001, 500002, 500003, 500004, 500005, 500006, 500007, 500008, 500009];
            initComponentUI("cityPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_time = getDisplayChildByName("txt_time");
            this.txt_time.selectable = false;
            this.txt_time.mouseWheelEnabled = false;
            this.txt_guildName = getDisplayChildByName("txt_guildName");
            this.txt_guildName.selectable = false;
            this.txt_captureDays = getDisplayChildByName("txt_captureDays");
            this.txt_captureDays.selectable = false;
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10593"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10594"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10595"));
            this.img_award = getDisplayChildByName("img_award");
            this.img_award.mouseEnabled = false;
            this.mc_awardBox = getDisplayChildByName("mc_awardBox");
            this.btn_getAward = new BaseButton(getDisplayChildByName("btn_getAward"));
            this.btnFightCityBuff = new BaseButton(getDisplayChildByName("btn_fight_city_buff"));
            this.btn_bannel = new BaseButton(getDisplayChildByName("btn_bannel"));
            this.btn_bannel.setText(LanguageCfgObj.getInstance().getByIndex("10596"));
            var _loc_1:* = new Object();
            ItemTips.create(this.btn_bannel, _loc_1, CountryGainAwardTips);
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            this.mc5 = getDisplayChildByName("mc5");
            this.mc6 = getDisplayChildByName("mc6");
            this.mc_rule = getDisplayChildByName("mc_rule");
            this.mc_rule.visible = false;
            this.btn_goto = new BaseButton(this.mc_rule.getChildByName("btn_goto"));
            this.btn_close = new BaseButton(this.mc_rule.getChildByName("btn_close"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_getAward.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_bannel.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_goto.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_close.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_INFO_CHANGE, this.update);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    this.mc_rule.visible = !this.mc_rule.visible;
                    break;
                }
                case this.btn_goto:
                case this.btn2:
                {
                    CountryControl.getInstance().resCountrySiegeSelect(1);
                    ClickStream.add(ClickStreamId.CLICK_GongChengZhan_ChuanSongJinRuZhanChang);
                    break;
                }
                case this.btn3:
                {
                    CountryControl.getInstance().reqCountrysalary();
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn3);
                    break;
                }
                case this.btn_getAward:
                {
                    CountryControl.getInstance().openCountryConCapturePanel();
                    break;
                }
                case this.btn_bannel:
                {
                    if (CountryData.getInstance().countryLeaderMemberInfo && UserObj.getInstance().playerInfo.personId.equal(CountryData.getInstance().countryLeaderMemberInfo.playerid))
                    {
                        CountryControl.getInstance().openBannerBox();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10597"));
                    }
                    break;
                }
                case this.btn_close:
                {
                    this.mc_rule.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            if (!this.parent)
            {
                return;
            }
            this.getData();
            this.refreshMC();
            this.showBtn();
            this.showAward();
            return;
        }// end function

        private function getData() : void
        {
            this._countrystructureInfo = CountryData.getInstance().countrystructureInfo;
            return;
        }// end function

        private function refreshMC() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            if (this._countrystructureInfo)
            {
                _loc_1 = 0;
                while (_loc_1 < 5)
                {
                    
                    while (this["mc" + (_loc_1 + 1)].img.numChildren)
                    {
                        
                        this["mc" + (_loc_1 + 1)].img.removeChildAt(0);
                    }
                    this["mc" + (_loc_1 + 1)].txt_name.text = LanguageCfgObj.getInstance().getByIndex("10598");
                    _loc_1++;
                }
                _loc_2 = this._countrystructureInfo.countrymemberInfolist.length;
                _loc_3 = -1;
                _loc_1 = 0;
                while (_loc_1 < _loc_2)
                {
                    
                    _loc_9 = this._countrystructureInfo.countrymemberInfolist[_loc_1];
                    if (_loc_9.post == 3)
                    {
                        _loc_3++;
                        this["mc" + (_loc_9.post + _loc_3)].txt_name.text = _loc_9.playername;
                    }
                    else
                    {
                        this["mc" + _loc_9.post].txt_name.text = _loc_9.playername;
                    }
                    _loc_10 = 0;
                    switch(_loc_9.job)
                    {
                        case 1:
                        case 4:
                        case 7:
                        {
                            _loc_10 = 1 + (_loc_9.post - 1) * 3;
                            break;
                        }
                        case 2:
                        case 5:
                        case 8:
                        {
                            _loc_10 = 2 + (_loc_9.post - 1) * 3;
                            break;
                        }
                        default:
                        {
                            _loc_10 = 3 + (_loc_9.post - 1) * 3;
                            break;
                        }
                    }
                    _loc_11 = NpcCfgObj.getInstance().getNpcByID("" + this.npcArray[_loc_10]);
                    _loc_12 = new NpcInfo();
                    _loc_12.npcModelId = this.npcArray[_loc_10];
                    _loc_12.npcId = long.fromNumber(1000);
                    _loc_13 = new NpcShowInfo();
                    _loc_13.npcInfo = _loc_12;
                    _loc_13.showID = _loc_11._npcRes;
                    _loc_13.name = "";
                    _loc_14 = new NPC();
                    _loc_14.info = _loc_13;
                    _loc_14.auto = true;
                    if (_loc_9.post == 3)
                    {
                        this["mc" + (_loc_9.post + _loc_3)].img.addChild(_loc_14);
                    }
                    else
                    {
                        this["mc" + _loc_9.post].img.addChild(_loc_14);
                    }
                    _loc_1++;
                }
                _loc_4 = this._countrystructureInfo.Siegetime;
                _loc_4 = _loc_4.replace("\n", "");
                _loc_5 = _loc_4.indexOf("：");
                _loc_6 = _loc_4.slice(0, (_loc_5 + 1));
                _loc_7 = _loc_4.slice((_loc_5 + 1));
                if (_loc_5 != -1)
                {
                    this.txt_time.htmlText = "<font size=\'14\' color=\'#ffd47f\'>" + _loc_6 + "</font>" + "\n<font size=\'12\' color=\'#ffcc00\'>" + _loc_7 + "</font>";
                }
                else
                {
                    this.txt_time.htmlText = "<font size=\'14\' color=\'#ffcc00\'>" + _loc_4 + "</font>";
                }
                if (this._countrystructureInfo.guildname)
                {
                    this.txt_guildName.text = this._countrystructureInfo.guildname;
                }
                else
                {
                    this.txt_guildName.text = LanguageCfgObj.getInstance().getByIndex("10598");
                }
                this.txt_captureDays.text = "" + this._countrystructureInfo.holdDay;
                _loc_8 = this.getFightCityBuffTips(this._countrystructureInfo.holdDay);
                if (_loc_8)
                {
                    _loc_8 = _loc_8.replace("{time}", LanguageCfgObj.getInstance().getByIndex("11972"));
                    StringTip.create(this.btnFightCityBuff, _loc_8);
                    this.btnFightCityBuff.visible = true;
                }
                else
                {
                    this.btnFightCityBuff.visible = false;
                }
            }
            this.mc_rule.visible = false;
            return;
        }// end function

        private function getFightCityBuffTips(param1:int) : String
        {
            var _loc_2:* = 0;
            if (param1 >= 10)
            {
                _loc_2 = 1164;
            }
            else if (param1 >= 9)
            {
                _loc_2 = 1163;
            }
            else if (param1 >= 8)
            {
                _loc_2 = 1162;
            }
            else if (param1 >= 7)
            {
                _loc_2 = 1161;
            }
            else if (param1 >= 6)
            {
                _loc_2 = 1160;
            }
            else if (param1 >= 5)
            {
                _loc_2 = 1159;
            }
            else if (param1 >= 4)
            {
                _loc_2 = 1158;
            }
            else if (param1 >= 3)
            {
                _loc_2 = 1157;
            }
            else if (param1 >= 2)
            {
                _loc_2 = 1156;
            }
            else if (param1 >= 1)
            {
                _loc_2 = 1155;
            }
            var _loc_3:* = BuffCfgObj.getInstance().getBuffInfo(_loc_2);
            if (_loc_3)
            {
                return _loc_3.getBuffTips();
            }
            return null;
        }// end function

        private function showBtn() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_1:* = ToolKit.getServerDate();
            var _loc_2:* = _loc_1.day;
            if (CountryData.getInstance().state == 1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this.btn2);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn2);
            }
            var _loc_3:* = false;
            var _loc_4:* = false;
            if (CountryData.getInstance().countrystructureInfo)
            {
                _loc_5 = CountryData.getInstance().jobAwardInfo;
                _loc_6 = CountryData.getInstance().countrystructureInfo.countrymemberInfolist;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    if (_loc_6[_loc_7].playerid.equal(UserObj.getInstance().playerInfo.personId))
                    {
                        _loc_8 = 0;
                        while (_loc_5 && _loc_8 < _loc_5.length)
                        {
                            
                            if (_loc_6[_loc_7].post == _loc_5[_loc_8].level && _loc_5[_loc_8].status == 1)
                            {
                                _loc_4 = true;
                            }
                            _loc_8++;
                        }
                        if (_loc_6[_loc_7].post == 1)
                        {
                            _loc_3 = true;
                        }
                    }
                    _loc_7++;
                }
                if (CountryData.getInstance().canGetAward)
                {
                    ButtonFlickerControl.getInstance().addButtonFlicker(this.btn3);
                }
                else
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn3);
                }
            }
            return;
        }// end function

        private function showAward() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (this._countrystructureInfo)
            {
                _loc_2 = 0;
                while (_loc_2 < this._countrystructureInfo.countrymemberInfolist.length)
                {
                    
                    if (this._countrystructureInfo.countrymemberInfolist[_loc_2].post == 1)
                    {
                        _loc_1 = this._countrystructureInfo.countrymemberInfolist[_loc_2].playerid;
                    }
                    _loc_2++;
                }
                _loc_3 = this._countrystructureInfo.holdDay;
                _loc_4 = 21;
                _loc_5 = CountryCaptureCfgObj.getInstance().getCaptureInfo();
                for each (_loc_6 in _loc_5)
                {
                    
                    if (int(_loc_6.q_day) >= _loc_3)
                    {
                        _loc_4 = int(_loc_6.q_day);
                        break;
                    }
                }
                _loc_7 = this._countrystructureInfo.holdReward;
                _loc_8 = _loc_7.split(",");
                _loc_9 = false;
                for each (_loc_10 in _loc_5)
                {
                    
                    if (_loc_8.indexOf(_loc_10.q_day) == -1 && _loc_3 >= int(_loc_10.q_day))
                    {
                        _loc_9 = true;
                        break;
                    }
                }
                if (_loc_9 && UserObj.getInstance().playerInfo.personId.equal(_loc_1))
                {
                    this.playEffect(true);
                }
                else
                {
                    this.playEffect(false);
                }
                _loc_7 = LanguageCfgObj.getInstance().getByIndex("10599");
                StringTip.create(this.btn_getAward, _loc_7);
                ToolKit.clearMcChild(this.mc_awardBox);
                _loc_11 = PropUtil.createItemByCfg(700160);
                _loc_12 = new IconItem("");
                _loc_12.setWH(40, 40);
                _loc_12.setImageSize(40, 40);
                _loc_12.setInfo(_loc_11);
                this.mc_awardBox.addChild(_loc_12);
            }
            return;
        }// end function

        private function playEffect(param1:Boolean = true) : void
        {
            ToolKit.clearMcChild(this.img_award);
            if (!param1)
            {
                if (this.effect)
                {
                    this.effect.stop();
                }
                return;
            }
            if (this.effect == null)
            {
                this.effect = new VMCView();
                this.effect.auto = true;
            }
            this.effect.loadRes("res/effect/topact_red.png");
            this.effect.updatePose("90", true);
            this.effect.replay();
            this.img_award.addChild(this.effect);
            return;
        }// end function

        public function reqCountryStructureInfo() : void
        {
            CountryControl.getInstance().reqCountryStructureInfo();
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
