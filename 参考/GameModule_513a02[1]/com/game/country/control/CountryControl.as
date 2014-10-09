package com.game.country.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.backpack.bean.*;
    import com.game.batter.control.*;
    import com.game.buff.bean.*;
    import com.game.country.bean.*;
    import com.game.country.events.*;
    import com.game.country.message.*;
    import com.game.country.model.*;
    import com.game.country.protocol.*;
    import com.game.country.view.*;
    import com.game.gather.control.*;
    import com.game.gather.model.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.prompt.control.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.view.bosshome.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import interfaces.role.*;

    public class CountryControl extends Object
    {
        private var _countryBox:CountryBox;
        private var _countryRankPanel:CountryRankPanel;
        private var _countryOverRankPanel:CountryOverRankPanel;
        private var _countryConCapturePanel:CountryConCapturePanel;
        private var _bannerBox:BannerBox;
        private var _countryTools:CountryTools;
        private var _countryCopyView:CountryCopyView;
        private var _isCountryGather:Boolean = false;
        private var _hasTips:Boolean = false;
        private var _scene:CountryGameScene;
        private var _clientMonst:Role;
        private var _start:Boolean;
        private var _model:CountryData;
        private var _protocol:CountryProtocol;
        public var _fakeBuffList:Array;
        private var lowId:int;
        private var _timeCount:int;
        private var _timeId:String;
        private static var _instance:CountryControl;
        public static const SAFE_TIME:int = 60;
        public static const MONSTID:int = 888;

        public function CountryControl()
        {
            this._protocol = new CountryProtocol();
            this._model = CountryData.getInstance();
            FrameworkGlobal.addMsgListen("gatherEnd", this.gatherEnd);
            GuildData.getInstance().addEvtListener(GuildEvent.MY_MEMBER_INFO_CHANGE, this.checkOpenCountryBox);
            return;
        }// end function

        public function get countryBox() : CountryBox
        {
            return this._countryBox;
        }// end function

        public function get countryTools() : CountryTools
        {
            return this._countryTools;
        }// end function

        public function openCountryBox(param1:int = 1) : void
        {
            if (ZonesControl.getInstance().inBossHome())
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10011", BossHomeConsts.LANG_VER), null, null, null, null, 1);
                return;
            }
            if (!this._countryBox)
            {
                this._countryBox = new CountryBox();
                Global.popManager.addPop(this._countryBox);
            }
            this._countryBox.type = param1;
            this._countryBox.openOrClose();
            return;
        }// end function

        public function openCountryRankPanel() : void
        {
            if (!this._countryRankPanel)
            {
                this._countryRankPanel = new CountryRankPanel();
                Global.popManager.addPop(this._countryRankPanel, false, false, true, true, false, true);
            }
            this._countryRankPanel.openOrClose();
            return;
        }// end function

        public function openCountryOverRankPanel() : void
        {
            if (!this._countryOverRankPanel)
            {
                this._countryOverRankPanel = new CountryOverRankPanel();
                Global.popManager.addPop(this._countryOverRankPanel, false, false, true, true, false, true);
            }
            this._countryOverRankPanel.open();
            return;
        }// end function

        public function openCountryConCapturePanel() : void
        {
            if (!this._countryConCapturePanel)
            {
                this._countryConCapturePanel = new CountryConCapturePanel();
                Global.popManager.addPop(this._countryConCapturePanel, false, false, true, true, false, false);
            }
            this._countryConCapturePanel.openOrClose();
            return;
        }// end function

        public function openBannerBox() : void
        {
            if (!this._bannerBox)
            {
                this._bannerBox = new BannerBox();
                Global.popManager.addPop(this._bannerBox);
            }
            this._bannerBox.openOrClose();
            return;
        }// end function

        public function openCountryTools() : void
        {
            if (!this._countryTools)
            {
                this._countryTools = new CountryTools();
                Global.popManager.addPop(this._countryTools);
            }
            this._countryTools.openOrClose();
            return;
        }// end function

        public function get countryCopyView() : CountryCopyView
        {
            if (!this._countryCopyView)
            {
                this._countryCopyView = new CountryCopyView();
            }
            return this._countryCopyView;
        }// end function

        public function get copyView() : CountryCopyView
        {
            return this._countryCopyView;
        }// end function

        public function startGather(param1:int) : void
        {
            GatherController.getInstance().costtime = param1;
            GatherModel.getInstance().num = 0;
            GatherModel.getInstance().total = param1 / 1000;
            GatherController.getInstance().start();
            this._isCountryGather = true;
            return;
        }// end function

        public function stopGather() : void
        {
            if (GatherController.getInstance().isGathering)
            {
                GatherController.getInstance().stop();
                this._isCountryGather = false;
            }
            return;
        }// end function

        private function gatherEnd(event:Event) : void
        {
            if (this._isCountryGather)
            {
                this._isCountryGather = false;
            }
            return;
        }// end function

        public function checkOpenCountryBox(event:Event) : void
        {
            if (!this._hasTips && CountryData.getInstance().state == 1)
            {
                if (UserObj.getInstance().playerInfo.guildId && !MapObj.getInstance().isZonesMap())
                {
                    this.openCountryBox();
                }
                this._hasTips = true;
            }
            return;
        }// end function

        public function resCountrySiegeSelect(param1:int) : void
        {
            this._protocol.resCountrySiegeSelect(param1);
            return;
        }// end function

        public function reqCountrySiegeSelectHandler(param1:ReqCountrySiegeSelectToClientMessage) : void
        {
            var _loc_2:* = param1.guildString;
            var _loc_3:* = _loc_2.split(",");
            var _loc_4:* = UserObj.getInstance().playerInfo.guildId;
            var _loc_5:* = UserObj.getInstance().playerInfo.level;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                if (_loc_5 >= 100 && _loc_4 && _loc_4.equal(long.parselong(_loc_3[_loc_6])) && !MapObj.getInstance().isZonesMap())
                {
                    this.openCountryBox();
                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_COUNTRY, true);
                    return;
                }
                _loc_6++;
            }
            return;
        }// end function

        public function reqCountryOpenTop() : void
        {
            this._protocol.reqCountryOpenTop();
            return;
        }// end function

        public function reqCountrysalary() : void
        {
            this._protocol.reqCountrysalary();
            return;
        }// end function

        public function reqCountryCaptureSalary(param1:int) : void
        {
            this._protocol.reqCountryCaptureSalary(param1);
            return;
        }// end function

        public function reqCJinYan(param1:String) : void
        {
            this._protocol.reqCJinYan(param1);
            return;
        }// end function

        public function reqCountryStructureInfo() : void
        {
            this._protocol.reqCountryStructureInfo();
            return;
        }// end function

        public function reqSiegeMoveMap() : void
        {
            this._protocol.reqSiegeMoveMap();
            return;
        }// end function

        public function reqAddCountryBuff() : void
        {
            this._protocol.reqAddCountryBuff();
            return;
        }// end function

        public function resCountryStructureInfoHandler(param1:ResCountryStructureInfoToClientMessage) : void
        {
            var _loc_2:* = param1.countrystructureInfo;
            CountryData.getInstance().countrystructureInfo = _loc_2;
            return;
        }// end function

        public function reqKingCityChestSelect(param1:int) : void
        {
            this._protocol.reqKingCityChestSelect(param1);
            return;
        }// end function

        public function resCountryJobAwardInfoHandler(param1:ResCountryJobAwardInfoToClientMessage) : void
        {
            var _loc_2:* = param1.damageinfo;
            CountryData.getInstance().jobAwardInfo = _loc_2;
            return;
        }// end function

        public function resCountrySiegeWarStateHandler(param1:ResCountrySiegeWarStateToClientMessage) : void
        {
            var _loc_2:* = param1.state;
            CountryData.getInstance().state = _loc_2;
            if (UserObj.getInstance().playerInfo.guildId && !MapObj.getInstance().isZonesMap() && _loc_2 == 1)
            {
                this.openCountryBox();
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_COUNTRY, true);
            }
            if (_loc_2 == 0)
            {
                if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
                {
                    this.openCountryOverRankPanel();
                }
                CountryCopyState.lastStep = -1;
                CountryData.getInstance().dispatchEvt(new CountryEvent(CountryEvent.COUNTRY_WAR_OVER, null));
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_COUNTRY, false);
            }
            return;
        }// end function

        public function resCountrySiegeUpYuxiHandler(param1:ResCountrySiegeUpYuxiToClientMessage) : void
        {
            var _loc_2:* = param1.playerid;
            var _loc_3:* = param1.playername;
            PromptControl.getInstance().addedToBroadcastMarquee(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11965"), [_loc_3]));
            return;
        }// end function

        public function resCountrySiegeYuXiImmediateHandler(param1:ResCountrySiegeYuXiImmediateToClientMessage) : void
        {
            var _loc_2:* = param1.countrywarinfo;
            CountryData.getInstance().countrywarinfo = _loc_2;
            CountryData.getInstance().curentCaptureID = _loc_2.holderguildid;
            this.setPhase(_loc_2.process);
            return;
        }// end function

        public function resCountryTopInfoHandler(param1:ResCountryTopInfoToClientMessage) : void
        {
            var _loc_2:* = param1.countryTopInfolist;
            CountryData.getInstance().countryTopInfolist = _loc_2;
            return;
        }// end function

        public function resCountryOverTopInfoHandler(param1:ResCountryOverTopInfoToClientMessage) : void
        {
            var _loc_2:* = param1.countryOverTopInfolist;
            CountryData.getInstance().countryOverTopInfolist = _loc_2;
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                this.openCountryOverRankPanel();
            }
            return;
        }// end function

        public function resKingCityChestPanelShowHandler(param1:ResKingCityChestPanelShowToClientMessage) : void
        {
            var _loc_2:* = param1.itemlist;
            return;
        }// end function

        public function resKingCityChestSelectHandler(param1:ResKingCityChestSelectToClientMessage) : void
        {
            var _loc_2:* = param1.iteminfo;
            var _loc_3:* = param1.num;
            return;
        }// end function

        public function resKingCityTimeRewardHandler(param1:ResKingCityTimeRewardToClientMessage) : void
        {
            var _loc_2:* = param1.warrewardinfo;
            return;
        }// end function

        public function resCountryRewardNumHandler(param1:ResAwardInfoToClientMessage) : void
        {
            var _loc_2:* = param1.damageinfo;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            CountryData.getInstance().canGetAward = false;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (_loc_2[_loc_5].type == 1 || _loc_2[_loc_5].type == 2)
                {
                    _loc_3 = _loc_3 + _loc_2[_loc_5].count;
                }
                else if (_loc_2[_loc_5].type == 3 || _loc_2[_loc_5].type == 4)
                {
                    _loc_4 = _loc_4 + _loc_2[_loc_5].count;
                }
                if (_loc_2[_loc_5].type == 1)
                {
                    CountryData.getInstance().canGetAward = Boolean(_loc_2[_loc_5].count);
                }
                _loc_5++;
            }
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_COUNTRY, "" + _loc_3);
            if (_loc_3 > 0)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_COUNTRY, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_COUNTRY, false);
            }
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_BANK, "" + _loc_4);
            if (_loc_4 > 0)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_BANK, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_BANK, false);
            }
            return;
        }// end function

        public function removeBuff() : void
        {
            var _loc_1:* = RoleList.getInstance().player as Player;
            while (this._fakeBuffList && this._fakeBuffList.length > 0)
            {
                
                _loc_1.info.removeBuff(this._fakeBuffList.shift());
            }
            return;
        }// end function

        public function createBuff(param1:int) : void
        {
            var _loc_2:* = RoleList.getInstance().player as Player;
            if (!this._fakeBuffList)
            {
                this._fakeBuffList = [];
            }
            var _loc_3:* = new CSBuffInfo();
            _loc_3.modelId = param1;
            _loc_3.buffId = this.getClientId();
            this._fakeBuffList.push(_loc_3.buffId);
            _loc_3.buffparas = new Vector.<BuffPara>;
            var _loc_4:* = _loc_2.info.addBuff(_loc_3);
            _loc_2.addBuffView(_loc_4);
            return;
        }// end function

        public function createBuffCast() : void
        {
            var _loc_1:* = 1185;
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.info.removeBuffByModelId(_loc_1);
            var _loc_3:* = new CSBuffInfo();
            _loc_3.modelId = _loc_1;
            _loc_3.buffId = this.getClientId();
            _loc_3.buffparas = new Vector.<BuffPara>;
            var _loc_4:* = _loc_2.info.addBuff(_loc_3);
            _loc_2.addBuffView(_loc_4);
            return;
        }// end function

        public function removeBufCast() : void
        {
            var _loc_1:* = 1185;
            var _loc_2:* = RoleList.getInstance().player as Player;
            _loc_2.info.removeBuffByModelId(_loc_1);
            return;
        }// end function

        public function getClientId() : long
        {
            var _loc_1:* = this;
            var _loc_2:* = this.lowId + 1;
            _loc_1.lowId = _loc_2;
            return new long(0, this.lowId);
        }// end function

        public function out() : void
        {
            BatterControl.getInstance().closeViewBatterKill();
            return;
        }// end function

        public function setSystemCue(param1:int) : void
        {
            ZonesControl.getInstance().zonesDownTime.updateDownTime(1, 0, param1);
            return;
        }// end function

        public function reset() : void
        {
            if (this._model)
            {
                this._model.curPhase = 0;
            }
            return;
        }// end function

        public function setPhase(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1.split(",");
            this._model.curPhase = 1;
            if (this._model.curPhase == 0 && this._start == false)
            {
                this.start();
            }
            if (this._scene)
            {
                this._scene.updateBlock(_loc_2);
            }
            if (this._model.curPhase == 100)
            {
                if (this._clientMonst == null)
                {
                    this._clientMonst = new Role();
                    _loc_3 = MapUtils.tile2Coo([188, 230]);
                    _loc_4 = new RoleInfo();
                    _loc_4.personId = long.fromNumber(MONSTID);
                    _loc_4.cfgId = 11111111;
                    _loc_5 = RoleList.getInstance().player as IRole;
                    var _loc_6:* = _loc_3[0];
                    _loc_4.x = _loc_3[0];
                    this._clientMonst.x = _loc_6;
                    var _loc_6:* = _loc_3[1];
                    _loc_4.y = _loc_3[1];
                    this._clientMonst.y = _loc_6;
                    _loc_4.speed = 0;
                    _loc_4.url = Params.ROLE_RES_PATH + "ms130";
                    this._clientMonst.direct = MapUtils.mapDirect2RoleDir(2);
                    this._clientMonst.info = _loc_4;
                    this._clientMonst.visible = true;
                    MapControl.getInstance().addSpeciaRole(this._clientMonst);
                }
            }
            else if (this._clientMonst != null)
            {
                MapControl.getInstance().removeRoleFromMap(this._clientMonst);
                this._clientMonst.finalize();
                this._clientMonst = null;
            }
            return;
        }// end function

        public function start() : void
        {
            if (this._model.curPhase == 0)
            {
                this._timeId = TimerManager.registerTimer(1, SAFE_TIME, this.updateTime, this.complete);
                this.setSystemCue(SAFE_TIME);
                this._timeCount = SAFE_TIME;
                this._start = true;
            }
            return;
        }// end function

        public function updateTime(event:TimerManagerEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._timeCount - 1;
            _loc_2._timeCount = _loc_3;
            if (this._scene)
            {
                if (this._timeCount != 0)
                {
                    this.setSystemCue(this._timeCount);
                }
                else
                {
                    this.setSystemCue(0);
                }
            }
            return;
        }// end function

        public function complete(event:TimerManagerEvent) : void
        {
            this._model.curPhase = 1;
            this._start = false;
            this._timeId = null;
            return;
        }// end function

        public function get isCountryGather() : Boolean
        {
            return this._isCountryGather;
        }// end function

        public function set isCountryGather(param1:Boolean) : void
        {
            this._isCountryGather = param1;
            return;
        }// end function

        public function get scene() : CountryGameScene
        {
            return this._scene;
        }// end function

        public function set scene(param1:CountryGameScene) : void
        {
            this._scene = param1;
            return;
        }// end function

        public static function getInstance() : CountryControl
        {
            if (_instance == null)
            {
                _instance = new CountryControl;
            }
            return _instance;
        }// end function

    }
}
