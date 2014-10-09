package com.game.zones.view.base
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.role.util.*;
    import com.game.team.bean.*;
    import com.game.team.event.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.zones.bean.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.game.zones.view.belialworld.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesBasePanel extends BaseBox
    {
        protected var TIPS_WORD:String;
        protected var _btnEnter:BaseButton;
        protected var _btnTeamEnter:BaseButton;
        protected var _btnClean:BaseButton;
        protected var _txtCleanBtn:TextField;
        protected var _btnClose:BaseButton;
        protected var vecTeamMemberList:Vector.<ZonesBelialWorldItem>;
        protected var _teamHbox:HBox;
        protected var _txtZonesCD:TextField;
        protected var _txtCount:TextField;
        protected var _txtCountTitle:TextField;
        protected var _txtTile:MovieClip;
        protected var _txtZoneRule:TextField;
        protected var _txtZoneLevel:MovieClip;
        protected var _txtCloseDownTime:TextField;
        protected var _txtFight:TextField;
        protected var _txtFightTitle:TextField;
        protected var _txtFightImg:Sprite;
        private var awardsHbox:HBox;
        protected var _txtZonesCDtitle:TextField;
        protected var _enterItemImg:Sprite;
        protected var _enterItemTxt:TextField;
        protected var _txtAwardTitle:TextField;
        protected var _txtAward:TextField;
        protected var _txtAwardImg:Sprite;
        protected var _cdEnter:DownTimer;
        protected var _isCD:Boolean = false;
        protected var _zoneServerInfo:ZoneTeamInfo;
        protected var _zoneTableInfo:ZonesTableVo;
        protected var _toolIcon:IconItem;
        protected var _vipTxt:TextField;
        protected var _propaganda:MovieClip;

        public function ZonesBasePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.TIPS_WORD = LanguageCfgObj.getInstance().getByIndex("11489");
            this._cdEnter = new DownTimer();
            super(param1, param2, param3, param4);
            loadDisplay("res/zonebelialworld.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zonebelialworld");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        protected function initUI() : void
        {
            this._txtTile = MovieClip(getDisplayChildByName("txt_tile"));
            this._txtZoneRule = TextField(getDisplayChildByName("txt_level_rule"));
            this._txtZoneLevel = MovieClip(getDisplayChildByName("txt_zone_level"));
            this._txtFight = TextField(getDisplayChildByName("txt_fight"));
            this._txtFightTitle = TextField(getDisplayChildByName("txt_fight_title"));
            this._txtFightImg = Sprite(getDisplayChildByName("txt_fight_img"));
            this._txtAward = TextField(getDisplayChildByName("txt_award"));
            this._txtAwardTitle = TextField(getDisplayChildByName("txt_award_title"));
            this._txtAwardImg = Sprite(getDisplayChildByName("txt_award_img"));
            this._btnEnter = new BaseButton(getDisplayChildByName("btn_enter"));
            this._btnEnter.setText(LanguageCfgObj.getInstance().getByIndex("11490"));
            this._btnTeamEnter = new BaseButton(getDisplayChildByName("btn_team_enter"));
            this._btnTeamEnter.setText(LanguageCfgObj.getInstance().getByIndex("11491"));
            this._btnClean = new BaseButton(getDisplayChildByName("btn_clean"));
            this._btnClean.setText(LanguageCfgObj.getInstance().getByIndex("11492"));
            this._txtCleanBtn = TextField(getDisplayChildByName("txt_clean_btn"));
            this._txtCleanBtn.mouseEnabled = false;
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._txtZonesCD = getDisplayChildByName("txt_zones_cd") as TextField;
            this._txtZonesCDtitle = getDisplayChildByName("txt_zones_cd_title") as TextField;
            this._txtCount = getDisplayChildByName("txt_enter_count") as TextField;
            this._txtCountTitle = getDisplayChildByName("txt_enter_count_title") as TextField;
            this._toolIcon = new IconItem("zones_tool_back_30");
            this._vipTxt = getDisplayChildByName("txt_vip");
            this._vipTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11493");
            this._toolIcon.move(422, 310);
            this._propaganda = getDisplayChildByName("propaganda") as MovieClip;
            this._txtCloseDownTime = TextField(getDisplayChildByName("txt_close_down_time"));
            this._enterItemTxt = getDisplayChildByName("enter_req_item_title");
            this._enterItemImg = getDisplayChildByName("enter_req_item_img");
            this._cdEnter.callBack = this.callCDback;
            this.initTeamBox();
            this.setBaseInfo();
            this.initAwardsList();
            return;
        }// end function

        private function initAwardsList() : void
        {
            this.awardsHbox = new HBox();
            this.awardsHbox.oneRow = 7;
            this.awardsHbox.intervalX = 9;
            this.awardsHbox.intervalY = 4;
            this.awardsHbox.horizontal = true;
            this.addChild(this.awardsHbox);
            this.awardsHbox.move(91, 366);
            return;
        }// end function

        private function initTeamBox() : void
        {
            this._teamHbox = new HBox();
            this._teamHbox.horizontal = true;
            this._teamHbox.oneRow = 2;
            this._teamHbox.intervalX = 0;
            this._teamHbox.intervalY = 5;
            this._teamHbox.move(507, 110);
            this.addChild(this._teamHbox);
            this.creatItem();
            return;
        }// end function

        private function creatItem() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!this.vecTeamMemberList)
            {
                this.vecTeamMemberList = new Vector.<ZonesBelialWorldItem>(4, true);
                _loc_1 = 0;
                while (_loc_1 < 4)
                {
                    
                    _loc_2 = new ZonesBelialWorldItem();
                    _loc_2.mouseEnabled = false;
                    _loc_2.mouseChildren = true;
                    _loc_2.index = _loc_1;
                    this.vecTeamMemberList[_loc_1] = _loc_2;
                    this._teamHbox.add(_loc_2);
                    _loc_1++;
                }
            }
            return;
        }// end function

        protected function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            TeamModel.getInstance().addEventListener(TeamEvent.TEAM_MEMBER_UPDATE, this.onTeamMemberUpdate);
            return;
        }// end function

        protected function onTeamMemberUpdate(event:Event) : void
        {
            if (this.parent)
            {
                this.freshMember();
            }
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClean:
                {
                    this.cleanZonesCD();
                    break;
                }
                case this._btnEnter:
                {
                    this.enterZones();
                    break;
                }
                case this._btnTeamEnter:
                {
                    this.enterTeamZones();
                    break;
                }
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._vipTxt:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function cleanZonesCD() : void
        {
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.freshMember();
            this.freshPanel();
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.cleanInfo();
            return;
        }// end function

        protected function enterZones() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._isCD)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11494"));
                return;
            }
            if (this._zoneTableInfo)
            {
                if (this._zoneTableInfo.type == ZoneType.ZONES_XS)
                {
                    ClickStream.add(ClickStreamId.CLICK_XueSeChengBao_DanRenJinRu);
                }
                _loc_1 = this._zoneTableInfo.need_item;
                _loc_2 = _loc_1.split(";");
                BackPackControl.getInstance().checkItemenough(_loc_2[0], _loc_2[1], this.enterZone);
            }
            return;
        }// end function

        private function enterZone(... args) : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(0, this._zoneTableInfo.id);
            return;
        }// end function

        protected function enterTeamZones() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._isCD)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11494"));
                return;
            }
            if (this._zoneTableInfo)
            {
                if (this._zoneTableInfo.type == ZoneType.ZONES_XS)
                {
                    ClickStream.add(ClickStreamId.CLICK_XueSeChengBao_ZuDuiJinRu);
                }
                _loc_1 = this._zoneTableInfo.need_item;
                _loc_2 = _loc_1.split(";");
                BackPackControl.getInstance().checkItemenough(_loc_2[0], _loc_2[1], this.enterTeamZone);
            }
            return;
        }// end function

        private function enterTeamZone() : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(1, this._zoneTableInfo.id);
            return;
        }// end function

        public function setTeamStates() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = TeamModel.getInstance().captainId;
            if (_loc_1 && _loc_1.toNumber() > 0 && UserObj.getInstance().playerInfo.personId.equal(_loc_1))
            {
                _loc_2 = TeamModel.getInstance().vecTeamInfo.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this.vecTeamMemberList[_loc_3].state = 0;
                    _loc_3++;
                }
                this.vecTeamMemberList[0].state = 2;
            }
            return;
        }// end function

        protected function checkToolEnough() : Boolean
        {
            var _loc_1:* = this._zoneTableInfo.need_item;
            var _loc_2:* = _loc_1.split(";");
            if (BackpackObj.getInstance().getItemCount(int(_loc_2[0])) >= int(_loc_2[1]))
            {
                return true;
            }
            return false;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        private function hasTeam() : Boolean
        {
            var _loc_1:* = TeamModel.getInstance().teamId;
            if (_loc_1 && !_loc_1.equal(new long(0, 0)))
            {
                return true;
            }
            return false;
        }// end function

        private function captainIsMe() : Boolean
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.personId;
            var _loc_2:* = TeamModel.getInstance().captainId;
            if (_loc_2 && _loc_1.equal(_loc_2))
            {
                return true;
            }
            return false;
        }// end function

        public function updateTeamStates() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!UILoaded)
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.vecTeamMemberList.length)
            {
                
                _loc_2 = this.vecTeamMemberList[_loc_1].info;
                if (_loc_2)
                {
                    _loc_3 = this.getTeamMemberSelectInfo(_loc_2.memberid);
                    this.vecTeamMemberList[_loc_1].state = _loc_3 != null ? (_loc_3.select) : (-1);
                }
                _loc_1++;
            }
            this.vecTeamMemberList[0].state = 2;
            return;
        }// end function

        private function freshMember() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this.UILoaded)
            {
                return;
            }
            var _loc_1:* = TeamModel.getInstance().vecTeamInfo;
            if (!_loc_1 || _loc_1.length <= 0)
            {
                this.cleanInfo();
                _loc_3 = new TeamMemberInfo();
                _loc_3.memberid = UserObj.getInstance().playerInfo.personId;
                _loc_3.memberJob = UserObj.getInstance().playerInfo.job;
                _loc_3.memberlevel = UserObj.getInstance().playerInfo.level;
                _loc_3.membername = UserObj.getInstance().playerInfo.name;
                this.vecTeamMemberList[0].info = _loc_3;
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                if (_loc_2 < _loc_1.length)
                {
                    _loc_4 = _loc_1[_loc_2];
                    _loc_5 = this.getTeamMemberSelectInfo(_loc_4.memberid);
                    this.vecTeamMemberList[_loc_2].info = _loc_4;
                    this.vecTeamMemberList[_loc_2].state = 1;
                }
                else
                {
                    this.vecTeamMemberList[_loc_2].info = null;
                    this.vecTeamMemberList[_loc_2].state = -1;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function getTeamMemberSelectInfo(param1:long) : ResZoneTeamNoticeSelectToClientMessage
        {
            var _loc_2:* = ZonesModel.getInstance().zoneTeamSelectInfo;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].memberid.equal(param1))
                {
                    return _loc_2[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function get zoneServerInfo() : ZoneTeamInfo
        {
            return this._zoneServerInfo;
        }// end function

        public function set zoneServerInfo(param1:ZoneTeamInfo) : void
        {
            this._zoneServerInfo = param1;
            this.setBaseInfo();
            if (UILoaded)
            {
                this.freshPanel();
            }
            return;
        }// end function

        private function callCDback(param1:int, param2:String) : void
        {
            this._txtZonesCD.text = param2.substr(3, param2.length);
            if (param1 <= 0)
            {
                this._txtZonesCD.text = "";
                this._isCD = false;
                this._btnEnter.filters = [];
                this._btnEnter.mouseEnabled = true;
                this._btnTeamEnter.filters = [];
                this._btnTeamEnter.mouseEnabled = true;
                this._btnClean.visible = false;
                this._txtCleanBtn.visible = false;
            }
            return;
        }// end function

        protected function setBaseInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (UILoaded && this._zoneServerInfo)
            {
                this._txtCount.text = (this.zoneServerInfo.enterMaxnum - this.zoneServerInfo.enternum).toString();
                if (this._zoneTableInfo)
                {
                    _loc_2 = this.TIPS_WORD;
                    _loc_3 = this.getNestUpVip();
                    _loc_4 = VipCfgObj.getInstance().dungeonAdd(_loc_3);
                    _loc_2 = _loc_2.replace("X1", _loc_3.toString());
                    _loc_2 = _loc_2.replace("X2", this._zoneTableInfo.duplicate_name);
                    _loc_2 = _loc_2.replace("X3", _loc_4.toString());
                    StringTip.create(this._vipTxt, _loc_2);
                    _loc_5 = this._zoneTableInfo.need_item;
                    if (this._zoneTableInfo.need_item && this._zoneTableInfo.need_item != "" && this._zoneTableInfo.need_item != "0")
                    {
                        _loc_6 = _loc_5.split(";");
                        _loc_7 = PropUtil.createItemByCfg(int(_loc_6[0]));
                        _loc_7.num = int(_loc_6[1]);
                        if (!this._toolIcon.parent)
                        {
                            this.addChild(this._toolIcon);
                        }
                        this._toolIcon.setImageSize(40, 40);
                        this._toolIcon.setInfo(_loc_7);
                    }
                }
                _loc_1 = int(this._zoneServerInfo.wait_time.toNumber() - (ToolKit.getServerTime() - this._zoneServerInfo.last_time.toNumber()));
                if (_loc_1 > 0 && this._zoneServerInfo.isopen == 3)
                {
                    this._cdEnter.count = _loc_1;
                    this._isCD = true;
                    this._btnEnter.filters = [ColorFilter.getGrayFilter()];
                    this._btnEnter.mouseEnabled = false;
                    this._btnTeamEnter.filters = [ColorFilter.getGrayFilter()];
                    this._btnTeamEnter.mouseEnabled = false;
                    this._btnClean.visible = true;
                    this._txtCleanBtn.visible = true;
                }
                else
                {
                    this._cdEnter.count = 0;
                    this._btnClean.visible = false;
                    this._txtCleanBtn.visible = false;
                }
            }
            return;
        }// end function

        protected function getNestUpVip() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.vipid;
            var _loc_2:* = VipCfgObj.getInstance().dungeonAdd(_loc_1);
            var _loc_3:* = _loc_1 + 1;
            while (_loc_3 <= VipConst.VIP_MAX_LEVEL)
            {
                
                if (VipCfgObj.getInstance().dungeonAdd(_loc_3) > _loc_2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function clearCD() : void
        {
            this._cdEnter.count = 0;
            return;
        }// end function

        private function cleanInfo() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.vecTeamMemberList.length)
            {
                
                this.vecTeamMemberList[_loc_1].state = -1;
                this.vecTeamMemberList[_loc_1].info = null;
                _loc_1++;
            }
            return;
        }// end function

        public function get zoneTableInfo() : ZonesTableVo
        {
            return this._zoneTableInfo;
        }// end function

        public function set zoneTableInfo(param1:ZonesTableVo) : void
        {
            this._zoneTableInfo = param1;
            return;
        }// end function

        private function freshPanel() : void
        {
            if (!this._zoneTableInfo)
            {
                return;
            }
            this._txtZoneLevel.gotoAndStop(this._zoneTableInfo.level);
            this._txtFight.text = this._zoneTableInfo.fighting_value.toString();
            var _loc_1:* = RoleLevelUtil.getMasterLevel(this._zoneTableInfo.min_lv);
            var _loc_2:* = RoleLevelUtil.getMasterLevel(this._zoneTableInfo.max_lv);
            this._txtZoneRule.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12337"), [_loc_1, _loc_2]);
            var _loc_3:* = this._zoneTableInfo.reward;
            this.setAwards(_loc_3);
            this.setTips();
            return;
        }// end function

        private function setAwards(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            while (this.awardsHbox.contents.length)
            {
                
                this.awardsHbox.removeByIndex(0);
            }
            var _loc_2:* = param1.split(";");
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new IconItem("commonRewardBox2_40");
                _loc_6 = PropUtil.createItemByCfg(_loc_2[_loc_4]);
                _loc_5.image.move(4, 3);
                _loc_5.setWH(46, 46);
                _loc_5.setInfo(_loc_6);
                this.awardsHbox.add(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        protected function setTips() : void
        {
            return;
        }// end function

    }
}
