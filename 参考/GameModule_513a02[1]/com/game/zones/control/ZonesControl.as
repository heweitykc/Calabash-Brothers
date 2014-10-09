package com.game.zones.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.adobe.serialization.json.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.autopk.controller.*;
    import com.game.batter.control.*;
    import com.game.bosshome.message.*;
    import com.game.clickstream.*;
    import com.game.country.control.*;
    import com.game.country.view.*;
    import com.game.gather.control.*;
    import com.game.greedisland.control.*;
    import com.game.greedisland.model.*;
    import com.game.greedisland.view.*;
    import com.game.guard.message.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.hotkeyguide.control.*;
    import com.game.hotkeyguide.view.*;
    import com.game.map.control.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.player.message.*;
    import com.game.redfortress.control.*;
    import com.game.redfortress.model.*;
    import com.game.redfortress.view.*;
    import com.game.role.*;
    import com.game.task.view.*;
    import com.game.team.bean.*;
    import com.game.team.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.game.vipcopy.view.*;
    import com.game.xscb.control.*;
    import com.game.xscb.model.*;
    import com.game.xscb.view.*;
    import com.game.zones.bean.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.game.zones.protocol.*;
    import com.game.zones.view.*;
    import com.game.zones.view.awards.*;
    import com.game.zones.view.belialworld.*;
    import com.game.zones.view.bosshome.*;
    import com.game.zones.view.bosshome.cfg.*;
    import com.game.zones.view.clean.*;
    import com.game.zones.view.dekaron.*;
    import com.game.zones.view.wolfsoul.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class ZonesControl extends Object
    {
        private var _viewBelialWordTrace:ZonesBeliaworldTraceView;
        private var _viewDekaronTrace:ZonesDekaronTraceView;
        private var _viewBelialWorld:ZonesBelialWorldPanel;
        private var _viewXS:ZonesScarletHoldPanel;
        private var _viewWS:ZonesWolfSoulPanel;
        private var _wolfSoulWelcome:ZonesWolfSoulWelcome;
        private var _sneakView:ZonesWolfSoulSneakView;
        private var _specialView:ZonesWolfSoulSpecialView;
        private var _wolfHead:ZonesWolfSoulHeadView;
        private var _wolfHintView:ZonesWolfHintView;
        private var _viewDekaron:ZonesDekaronPanel;
        private var _viewVipTrace:VipCopyInfoView;
        private var _countryState:CountryCopyState;
        private var _islandTrace:IslandCopyInfoView;
        private var _islandState:IslandState;
        private var _zonesDownTime:ZonesDownTime;
        private var _viewBelialWorldSelect:ZonesBelialWorldSelectPanel;
        private var _viewAwardsPanel:ZonesAwardsPanel;
        private var _viewDefeatPanel:ZonesDefeatPanel;
        private var _viewCleanPanel:ZonesCleanAwards;
        private var _viewInspire:ZonesInspireView;
        private var _iconZonesQuit:ZonesTopIconPanel;
        private var _zonesRedfortressDownTime:ZonesRedfortressDownTime;
        private var _viewEvaluateView:ZonesBeliaWorldEvaluateView;
        private var _protocol:ZonesProtocol;
        private var _model:ZonesModel;
        private var _scarletholdTrace:ScarletHoldTraceView;
        private var _wolfSoulTrace:ZoneWolfSoulTraceView;
        private var _lightView:VMCView;
        private var _oldMapId:int;
        private var _bossHomeDefeatPanel:BossHomeDefeatPanel;
        private var _viewBossHome:BossHomePanel;
        private var _bossHomeIcon:BossHomeIcon;
        public var intendToBossHome:Boolean;
        private static var _instance:ZonesControl;

        public function ZonesControl()
        {
            this.init();
            return;
        }// end function

        public function addScarletListener() : void
        {
            if (this._scarletholdTrace)
            {
                this._scarletholdTrace.addAutoEventListener();
            }
            return;
        }// end function

        private function init() : void
        {
            this._protocol = new ZonesProtocol();
            this._model = ZonesModel.getInstance();
            this.addEvents();
            return;
        }// end function

        private function addEvents() : void
        {
            FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE, this.onChangeMapHandler);
            ZonesModel.getInstance().addEventListener(ZonesModel.COPY_TIMES_CHANGE, this.__updateTimes);
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
            return;
        }// end function

        protected function guideActive(event:GuideEvent) : void
        {
            var _loc_2:* = String(event.data);
            switch(_loc_2)
            {
                case GuideConfigObj.getInstance().XSCB_ZONE_TEAM:
                case GuideConfigObj.getInstance().BELIA_WORLD_ZONE_TEAM:
                {
                    ZonesControl.getInstance().reqZoneTeamOpenToGame(0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dealBossHomeDie(param1:ResBossHomeDieMessage) : void
        {
            if (param1.type == 1)
            {
                if (this._bossHomeIcon)
                {
                    this._bossHomeIcon.aggregation();
                }
            }
            if (param1.type == 2)
            {
                TweenLite.delayedCall(0.5, this.thunder, [param1.playerId]);
            }
            return;
        }// end function

        public function thunder(param1:long) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1) as Role;
            if (this._lightView == null)
            {
                this._lightView = new VMCView();
            }
            this._lightView.auto = true;
            this._lightView.updatePose("90", false, false, true);
            this._lightView.loadRes("res/effect/thunderfall.png");
            this._lightView.move(_loc_2._x, _loc_2._y);
            MapControl.getInstance().currentGameScene.topLayer.addChild(this._lightView);
            return;
        }// end function

        private function onChangeMapHandler(event:MapEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0)
            {
                ClickStream.enterZone(_loc_2.zones_type);
            }
            if (this.inBossHome())
            {
                BossHomeModel.getInstance().isFirst = false;
            }
            if (!ZonesControl.getInstance().inBossHome())
            {
            }
            if (MapObj.getInstance().mapID != Params.CLIENT_ZONES_DRAGON_KING && MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID && !this.inBossHome())
            {
            }
            if (!this.inBossHome())
            {
                if (this._bossHomeIcon)
                {
                    if (this._bossHomeIcon.parent)
                    {
                    }
                }
            }
            switch(_loc_2.zones_type)
            {
                case ZoneType.ZONES_BELIAL_WORLD:
                {
                    break;
                }
                case ZoneType.ZONES_BOSS_HOME:
                {
                    break;
                }
                case ZoneType.ZONES_XS:
                {
                    break;
                }
                case ZoneType.ZONES_ANGEL:
                {
                    break;
                }
                case ZoneType.ZONES_DELARON:
                {
                    break;
                }
                case ZoneType.ZONES_COUNTRY:
                {
                    break;
                }
                case ZoneType.ZONES_ISLAND:
                {
                    break;
                }
                case ZoneType.ZONES_VIP:
                {
                    break;
                }
                case ZoneType.ZONES_RED_FORTRESS:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._viewBelialWordTrace)
            {
            }
            if (this._viewDekaronTrace)
            {
            }
            if (this._scarletholdTrace)
            {
            }
            if (this._zonesDownTime)
            {
            }
            if (this._bossHomeDefeatPanel)
            {
            }
            if (this._viewAwardsPanel)
            {
            }
            if (this._viewVipTrace)
            {
            }
            if (this._islandTrace)
            {
            }
            if (this._countryState)
            {
            }
            if (this._islandState)
            {
            }
            if (this._bossHomeIcon)
            {
                if (this._bossHomeIcon.parent)
                {
                }
            }
            if (CountryControl.getInstance().copyView)
            {
            }
            if (this._zonesRedfortressDownTime && this._zonesRedfortressDownTime.parent)
            {
            }
            if (this._wolfSoulTrace)
            {
            }
            if (this._wolfHintView)
            {
            }
            if (this._oldMapId > 0)
            {
                _loc_3 = MapCfgObj.getInstance().getMap(this._oldMapId);
                if (_loc_3 && _loc_3.mapZones > 0 && _loc_3.zones_type == ZoneType.ZONES_DELARON)
                {
                    this.openZonesDekaron();
                }
                if (_loc_3 && _loc_3.mapZones > 0 && _loc_3.zones_type != ZoneType.ZONES_ANGEL && ZonesModel.getInstance().isWolfSoulAct)
                {
                    _loc_4 = this.getZoneTeamInfo(ZoneType.ZONES_ANGEL);
                    if (_loc_4 && _loc_4.enternum < _loc_4.enterMaxnum)
                    {
                        this.openWolfWelcome();
                    }
                }
                if (_loc_3 && _loc_3.mapZones > 0 && _loc_3.zones_type == ZoneType.ZONES_RED_FORTRESS)
                {
                    if (HotkeyGuideView.instance)
                    {
                        HotkeyGuideView.instance.stop();
                    }
                }
            }
            this._oldMapId = MapObj.getInstance().mapID;
            if (GatherController.getInstance().isGathering)
            {
                GatherController.getInstance().stop();
            }
            return;
        }// end function

        public function updateScarletWaitBtnStatus() : void
        {
            if (this._scarletholdTrace)
            {
                this._scarletholdTrace.updateBtn();
            }
            return;
        }// end function

        public function get viewBeliaworldTrace() : ZonesBeliaworldTraceView
        {
            if (!this._viewBelialWordTrace)
            {
                this._viewBelialWordTrace = new ZonesBeliaworldTraceView();
            }
            return this._viewBelialWordTrace;
        }// end function

        public function inBossHome() : Boolean
        {
            return MapObj.getInstance().mapID == Params.BOSS_HOME_CITY_MAP;
        }// end function

        public function get scarletholdTrace() : ScarletHoldTraceView
        {
            if (!this._scarletholdTrace)
            {
                this._scarletholdTrace = new ScarletHoldTraceView();
            }
            return this._scarletholdTrace;
        }// end function

        public function get wolfSoulTrace() : ZoneWolfSoulTraceView
        {
            if (!this._wolfSoulTrace)
            {
                this._wolfSoulTrace = new ZoneWolfSoulTraceView();
            }
            return this._wolfSoulTrace;
        }// end function

        public function get viewDekaronTrace() : ZonesDekaronTraceView
        {
            if (!this._viewDekaronTrace)
            {
                this._viewDekaronTrace = new ZonesDekaronTraceView();
            }
            return this._viewDekaronTrace;
        }// end function

        public function get viewVipTrace() : VipCopyInfoView
        {
            if (!this._viewVipTrace)
            {
                this._viewVipTrace = new VipCopyInfoView();
            }
            return this._viewVipTrace;
        }// end function

        public function get countryState() : CountryCopyState
        {
            if (!this._countryState)
            {
                this._countryState = new CountryCopyState();
            }
            return this._countryState;
        }// end function

        public function get islandTrace() : IslandCopyInfoView
        {
            if (!this._islandTrace)
            {
                this._islandTrace = new IslandCopyInfoView();
            }
            return this._islandTrace;
        }// end function

        public function get islandState() : IslandState
        {
            if (!this._islandState)
            {
                this._islandState = new IslandState();
            }
            return this._islandState;
        }// end function

        public function get zonesDownTime() : ZonesDownTime
        {
            if (!this._zonesDownTime)
            {
                this._zonesDownTime = new ZonesDownTime();
            }
            return this._zonesDownTime;
        }// end function

        public function openZonesBeliaWorld() : void
        {
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BELIA_WORLD_ZONE_TEAM)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11456"));
                return;
            }
            if (ZonesControl.getInstance().leaveBossHomeCue())
            {
                return;
            }
            if (!this._viewBelialWorld)
            {
                this._viewBelialWorld = new ZonesBelialWorldPanel();
                Global.popManager.addPop(this._viewBelialWorld);
            }
            this._viewBelialWorld.openOrClose();
            return;
        }// end function

        public function openBossHome() : void
        {
            if (UserObj.getInstance().playerInfo.level < BossHomeConsts.LEVEL)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10012", BossHomeConsts.LANG_VER));
                return;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BOSS_HOME)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10003", BossHomeConsts.LANG_VER));
                return;
            }
            if (!this._viewBossHome)
            {
                this._viewBossHome = new BossHomePanel();
                Global.popManager.addPop(this._viewBossHome);
            }
            this._viewBossHome.openOrClose();
            return;
        }// end function

        public function openZonesDekaron() : void
        {
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().DEKARON_ZONE_TEAM)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11457"));
                return;
            }
            if (ZonesControl.getInstance().leaveBossHomeCue())
            {
                return;
            }
            if (!this._viewDekaron)
            {
                this._viewDekaron = new ZonesDekaronPanel();
                Global.popManager.addPop(this._viewDekaron);
            }
            this._viewDekaron.openOrClose();
            return;
        }// end function

        public function openZonesScarletHold() : void
        {
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().XSCB_ZONE_TEAM)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11458"));
                return;
            }
            if (ZonesControl.getInstance().leaveBossHomeCue())
            {
                return;
            }
            if (!this._viewXS)
            {
                this._viewXS = new ZonesScarletHoldPanel();
                Global.popManager.addPop(this._viewXS);
            }
            this._viewXS.openOrClose();
            return;
        }// end function

        public function leaveBossHomeCue() : Boolean
        {
            if (ZonesControl.getInstance().inBossHome())
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10011", BossHomeConsts.LANG_VER), null, null, null, null, 1);
                return true;
            }
            return false;
        }// end function

        public function openZonesWolfSoul() : void
        {
            if (ZonesControl.getInstance().inBossHome())
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10011", BossHomeConsts.LANG_VER), null, null, null, null, 1);
                return;
            }
            if (!this._viewWS)
            {
                this._viewWS = new ZonesWolfSoulPanel();
                Global.popManager.addPop(this._viewWS);
            }
            this._viewWS.openOrClose();
            return;
        }// end function

        public function closeZonesWolfSoul() : void
        {
            if (this._viewWS)
            {
                this._viewWS.close();
            }
            return;
        }// end function

        public function openOnlyZonesScarletHold() : void
        {
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().XSCB_ZONE_TEAM)) == 0)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11458"));
                return;
            }
            if (!this._viewXS)
            {
                this._viewXS = new ZonesScarletHoldPanel();
                Global.popManager.addPop(this._viewXS);
            }
            this._viewXS.open();
            return;
        }// end function

        public function openZonesBelialWorldSelect() : void
        {
            if (!this._viewBelialWorldSelect)
            {
                this._viewBelialWorldSelect = new ZonesBelialWorldSelectPanel();
                Global.popManager.addPop(this._viewBelialWorldSelect);
            }
            this._viewBelialWorldSelect.open();
            return;
        }// end function

        public function openZonesAwardsPanel() : void
        {
            if (!this._viewAwardsPanel)
            {
                this._viewAwardsPanel = new ZonesAwardsPanel();
                Global.popManager.addPop(this._viewAwardsPanel, true, true, true, true, false, true);
            }
            this._viewAwardsPanel.open();
            return;
        }// end function

        public function openZonesDefeatPanel() : void
        {
            if (!this._viewDefeatPanel)
            {
                this._viewDefeatPanel = new ZonesDefeatPanel();
                Global.popManager.addPop(this._viewDefeatPanel);
            }
            this._viewDefeatPanel.open();
            return;
        }// end function

        public function openBossHomeDefeatPanel() : void
        {
            if (!this._bossHomeDefeatPanel)
            {
                this._bossHomeDefeatPanel = new BossHomeDefeatPanel();
                Global.popManager.addPop(this._bossHomeDefeatPanel);
            }
            this._bossHomeDefeatPanel.open();
            return;
        }// end function

        public function bosshomeShowMonsterDie(param1:RoleInfo) : void
        {
            var icon:Image;
            var path:String;
            var info:* = param1;
            var anger:* = BossHomeCfgObj.getInstance().getAngelByModelId(info.cfgId);
            if (anger >= 0)
            {
                icon = new Image();
                path;
                icon.load(path);
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y - 150, onComplete:function () : void
            {
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y, onComplete:flyIcon, onCompleteParams:[icon]});
                return;
            }// end function
            });
            }
            return;
        }// end function

        public function flyIcon(param1:Image) : void
        {
            return;
        }// end function

        public function openZonesCleanPanel() : void
        {
            if (!this._viewCleanPanel)
            {
                this._viewCleanPanel = new ZonesCleanAwards();
                Global.popManager.addPop(this._viewCleanPanel, false, false, true, true, false, true);
            }
            this._viewCleanPanel.open();
            return;
        }// end function

        public function openZonesInspireView() : void
        {
            if (!this._viewInspire)
            {
                this._viewInspire = new ZonesInspireView();
            }
            this._viewInspire.open();
            return;
        }// end function

        public function closeZonesInspireView() : void
        {
            if (this._viewInspire)
            {
                this._viewInspire.close();
            }
            return;
        }// end function

        public function openEvaluateView() : void
        {
            if (!this._viewEvaluateView)
            {
                this._viewEvaluateView = new ZonesBeliaWorldEvaluateView();
            }
            this._viewEvaluateView.open();
            return;
        }// end function

        public function closeEvaluateView() : void
        {
            if (this._viewEvaluateView)
            {
                this._viewEvaluateView.close();
            }
            return;
        }// end function

        public function showZonesIconQuit(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this._iconZonesQuit)
                {
                    this._iconZonesQuit = new ZonesTopIconPanel();
                }
                this._iconZonesQuit.open();
            }
            else if (this._iconZonesQuit)
            {
                this._iconZonesQuit.close();
            }
            return;
        }// end function

        public function addFilterZonesIconQuit(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._iconZonesQuit)
                {
                    this._iconZonesQuit.addFilter();
                }
            }
            else if (this._iconZonesQuit)
            {
                this._iconZonesQuit.removeFilter();
            }
            return;
        }// end function

        public function zoneVirtualPassShow(param1:ResZonePassShowMessage) : void
        {
            this._model.zonesAwardsInfo = param1;
            this.openZonesAwardsPanel();
            return;
        }// end function

        public function killMonsterCount(param1:ResScriptCommonPlayerToClientMessage) : void
        {
            var _loc_2:* = null;
            if (param1.type == 1)
            {
                switch(param1.scriptid)
                {
                    case 55001:
                    {
                        _loc_2 = JSON.decode(param1.messageData);
                        if (this._model.isInstance)
                        {
                            this._model.killMonsterCount = _loc_2.kill;
                            this._model.killMonsterGetExp = _loc_2.exp;
                            if (this._viewBelialWordTrace)
                            {
                                this._viewBelialWordTrace.setKillMonsterCount();
                            }
                        }
                        if (this._viewEvaluateView)
                        {
                            this._viewEvaluateView.updateViewRate(_loc_2.kill, _loc_2.kill / 4);
                        }
                        break;
                    }
                    case 55002:
                    {
                        _loc_2 = JSON.decode(param1.messageData);
                        if (this._model.isInstance)
                        {
                            this._model.killMonsterCount = _loc_2.kill;
                            ScarletHoldControl.getInstance().setMonstKill(_loc_2.kill);
                        }
                        break;
                    }
                    case 15004:
                    {
                        _loc_2 = JSON.decode(param1.messageData);
                        this._model.killMonsterCount = _loc_2.kill;
                        this._model.killMonsterGetExp = _loc_2.exp;
                        if (this._wolfSoulTrace)
                        {
                            this._wolfSoulTrace.setKillMonsterCount();
                        }
                        break;
                    }
                    case 55017:
                    {
                        _loc_2 = JSON.decode(param1.messageData);
                        this._model.killMonsterCount = _loc_2.zoneprocesskill;
                        if (this._islandTrace)
                        {
                            this._islandTrace.setKillMonsterCount(_loc_2.zoneprocess);
                        }
                        if (this._islandState)
                        {
                            this._islandState.setKillMonsterCount(_loc_2.zoneprocess, _loc_2.time, _loc_2.zoneprocesskill);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function resAllRaidZoneInfo(param1:ResAllRaidZoneInfoMessage) : void
        {
            this._model.setRaidZoneInfo(param1.raidzoneinfolist);
            return;
        }// end function

        public function resAutoRaidInfo(param1:ResAutoRaidInfoMessage) : void
        {
            return;
        }// end function

        public function resZoneApplyDataInfo(param1:ResZoneApplyDataInfoToClientMessage) : void
        {
            return;
        }// end function

        public function ResZoneBossAppear(param1:ResZoneBossAppearMessage) : void
        {
            return;
        }// end function

        public function resZoneClearance(param1:ResZoneClearanceMessage) : void
        {
            this.openZonesDefeatPanel();
            return;
        }// end function

        public function resZoneContinuousRaidsEnd(param1:ResZoneContinuousRaidsEndMessage) : void
        {
            return;
        }// end function

        public function resZoneContinuousRaids(param1:ResZoneContinuousRaidsMessage) : void
        {
            return;
        }// end function

        public function resZoneKillProgressRate(param1:ResZoneKillProgressRateMessage) : void
        {
            return;
        }// end function

        public function resZoneLifeTime(param1:ResZoneLifeTimeMessage) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0)
            {
                this._model.isInstance = true;
                this._model.zoneid = param1.zoneid;
                switch(_loc_2.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        if (param1.phase > 0)
                        {
                            this.viewBeliaworldTrace.setZoneLife(param1.surplustime, param1.phase);
                        }
                        if (param1.phase == 0)
                        {
                            this.zonesDownTime.updateDownTime(param1.surplustime, param1.phase, ZoneType.ZONES_BELIAL_START_GAP);
                        }
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        ScarletHoldControl.getInstance().setPhase(param1.phase, param1.zoneid, param1.playercount);
                        this.scarletholdTrace.setZoneLife(param1.surplustime);
                        if (param1.phase == 0)
                        {
                            this.zonesDownTime.updateDownTime(param1.surplustime, param1.phase, ZoneType.ZONES_SCARLET_START_GAP);
                        }
                        if (this._viewEvaluateView)
                        {
                            this._viewEvaluateView.updateXSView(param1.surplustime);
                        }
                        break;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        this.zonesDownTime.updateDownTime(param1.surplustime, param1.phase, 5);
                        break;
                    }
                    case ZoneType.ZONES_RED_FORTRESS:
                    {
                        if (param1.phase == 1)
                        {
                            if (!this._zonesRedfortressDownTime)
                            {
                                this._zonesRedfortressDownTime = ZonesRedfortressDownTime.getinstance();
                            }
                            this._zonesRedfortressDownTime.updateDownTime(param1.surplustime);
                        }
                        break;
                    }
                    case ZoneType.ZONES_VIP:
                    {
                        if (this._viewVipTrace)
                        {
                            this._viewVipTrace.updateDownTime(param1.surplustime);
                        }
                        break;
                    }
                    case ZoneType.ZONES_ANGEL:
                    {
                        if (this._wolfSoulTrace)
                        {
                            this._wolfSoulTrace.setZoneLife(param1.surplustime, param1.phase);
                        }
                        if (param1.phase == 0)
                        {
                            this.zonesDownTime.updateDownTime(param1.surplustime, param1.phase, 5);
                        }
                        if (this._viewEvaluateView)
                        {
                            this._viewEvaluateView.updateWS(param1.surplustime);
                        }
                        break;
                    }
                    case ZoneType.ZONES_ISLAND:
                    {
                        if (this.islandTrace)
                        {
                            this.islandTrace.updateDownTime(param1.surplustime, param1.phase);
                        }
                        if (param1.surplustime > IslandData.COPY_TIME - ZoneType.ZONES_ISLAND_START_GAP)
                        {
                            _loc_3 = param1.surplustime - (IslandData.COPY_TIME - ZoneType.ZONES_ISLAND_START_GAP);
                            IslandControl.getInstance().setStartCue(_loc_3);
                            if (this.islandTrace)
                            {
                                this.islandTrace.playEffect(_loc_3);
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function resZoneNoticeRewardHandler(param1:ResZoneNoticeRewardMessage) : void
        {
            return;
        }// end function

        public function resZonePassShow(param1:ResZonePassShowMessage) : void
        {
            AutoFightController.getInstance().closeAutoFight();
            if (param1.zoneid == ZonesRedfortressModel.ZONES_ID)
            {
                return;
            }
            if (param1.zoneid == Params.ISLAND_COPY_ID)
            {
                IslandControl.getInstance().openIslandOverPanel();
                return;
            }
            this._model.zonesAwardsInfo = param1;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.zoneid);
            if (param1.type == 0)
            {
                if (this._model.isInstance)
                {
                    if (this._zonesDownTime)
                    {
                        this._zonesDownTime.close();
                    }
                    this.openZonesAwardsPanel();
                    if (param1.isPass == 1)
                    {
                        ClickStream.exitZone(_loc_2.type);
                    }
                }
            }
            else if (param1.type == 1)
            {
                this.openZonesCleanPanel();
                this._viewCleanPanel.updatePanel();
            }
            return;
        }// end function

        public function resZoneSelectAward(param1:ResZoneSelectAwardMessage) : void
        {
            return;
        }// end function

        public function resZoneSurplusSum(param1:ResZoneSurplusSumMessage) : void
        {
            return;
        }// end function

        public function ResZoneTeamNoticeSelectToClient(param1:ResZoneTeamNoticeSelectToClientMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.zoneid);
            if (!_loc_2)
            {
                return;
            }
            ZonesModel.getInstance().zoneid = param1.zoneid;
            switch(_loc_2.type)
            {
                case ZoneType.ZONES_BELIAL_WORLD:
                {
                    if (param1.select == 1)
                    {
                        if (this._viewBelialWorld)
                        {
                            this._viewBelialWorld.close();
                        }
                        this._model.cleanTeamSelectInfo();
                        if (this._viewBelialWorld)
                        {
                            this._viewBelialWorld.updateTeamStates();
                        }
                    }
                    else
                    {
                        if (UserObj.getInstance().playerInfo.personId.equal(param1.memberid))
                        {
                            this.openZonesBeliaWorld();
                        }
                        this._model.zoneTeamSelectInfo.push(param1);
                        if (this._viewBelialWorld)
                        {
                            this._viewBelialWorld.updateTeamStates();
                        }
                    }
                    break;
                }
                case ZoneType.ZONES_XS:
                {
                    if (param1.select == 1)
                    {
                        if (this._viewXS)
                        {
                            this._viewXS.close();
                        }
                        this._model.cleanTeamSelectInfo();
                        if (this._viewXS)
                        {
                            this._viewXS.updateTeamStates();
                        }
                    }
                    else
                    {
                        if (UserObj.getInstance().playerInfo.personId.equal(param1.memberid))
                        {
                            this.openZonesScarletHold();
                        }
                        this._model.zoneTeamSelectInfo.push(param1);
                        if (this._viewXS)
                        {
                            this._viewXS.updateTeamStates();
                        }
                    }
                    break;
                }
                case ZoneType.ZONES_ANGEL:
                {
                    if (param1.select == 1)
                    {
                        if (this._viewWS)
                        {
                            this._viewWS.close();
                        }
                        this._model.cleanTeamSelectInfo();
                        if (this._viewWS)
                        {
                            this._viewWS.updateTeamStates();
                        }
                    }
                    else
                    {
                        if (UserObj.getInstance().playerInfo.personId.equal(param1.memberid))
                        {
                            this.openZonesWolfSoul();
                        }
                        this._model.zoneTeamSelectInfo.push(param1);
                        if (this._viewWS)
                        {
                            this._viewWS.updateTeamStates();
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1.select == 1)
            {
                _loc_3 = param1.memberid;
                _loc_4 = TeamModel.getInstance().isTeamMember(param1.memberid);
                if (_loc_4)
                {
                    Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12332"), [_loc_4.membername]));
                }
                if (this._viewBelialWorldSelect)
                {
                    this._viewBelialWorldSelect.enterDownClose();
                }
                while (this._model.zoneTeamSelectInfo.length > 0)
                {
                    
                    this._model.zoneTeamSelectInfo.pop();
                }
            }
            return;
        }// end function

        public function ResZoneTeamNoticeToClient(param1:ResZoneTeamNoticeToClientMessage) : void
        {
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.zoneid);
            if (_loc_2)
            {
                switch(_loc_2.type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        if (!param1.leaderid.equal(UserObj.getInstance().playerInfo.personId))
                        {
                            this.openZonesBelialWorldSelect();
                            this._viewBelialWorldSelect.info = param1;
                        }
                        else
                        {
                            if (this._viewBelialWorld)
                            {
                                this._viewBelialWorld.setTeamStates();
                            }
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11460"));
                        }
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        if (!param1.leaderid.equal(UserObj.getInstance().playerInfo.personId))
                        {
                            this.openZonesBelialWorldSelect();
                            this._viewBelialWorldSelect.info = param1;
                        }
                        else
                        {
                            if (this._viewXS)
                            {
                                this._viewXS.setTeamStates();
                            }
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11461"));
                        }
                        break;
                    }
                    case ZoneType.ZONES_ANGEL:
                    {
                        if (!param1.leaderid.equal(UserObj.getInstance().playerInfo.personId))
                        {
                            this.openZonesBelialWorldSelect();
                            this._viewBelialWorldSelect.info = param1;
                        }
                        else
                        {
                            if (this._viewWS)
                            {
                                this._viewWS.setTeamStates();
                            }
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11462"));
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function ResZoneTeamOpenBullToClient(param1:ResZoneTeamOpenBullToClientMessage) : void
        {
            return;
        }// end function

        public function cancelPath() : void
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_1.mapZones > 0)
            {
                switch(_loc_1.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        if (ScarletHoldControl.getInstance().isHangUp)
                        {
                            ScarletHoldControl.getInstance().isHangUp = false;
                            ScarletHoldControl.getInstance().cancelPath();
                            if (this._scarletholdTrace)
                            {
                                this._scarletholdTrace.updateBtn();
                            }
                        }
                        break;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function cancelAutoFight() : void
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_1.mapZones > 0)
            {
                switch(_loc_1.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        ScarletHoldControl.getInstance().isHangUp = false;
                        if (this._scarletholdTrace)
                        {
                            this._scarletholdTrace.updateBtn();
                        }
                        break;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function resZoneTeamShowToClient(param1:ResZoneTeamShowToClientMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param1.type == 0)
            {
                this._model.zoneTeamAllInfo = param1.zoneteaminfo;
                _loc_3 = param1.zoneteaminfo.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_4 = param1.zoneteaminfo[_loc_5];
                    _loc_2 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_4.zoneid);
                    _loc_4.zoneType = _loc_2.type;
                    if (_loc_2)
                    {
                        _loc_6 = _loc_4.enterMaxnum;
                        _loc_7 = _loc_4.enternum;
                        _loc_8 = _loc_6 - _loc_7;
                        _loc_9 = int(_loc_4.wait_time.toNumber() - (ToolKit.getServerTime() - _loc_4.last_time.toNumber()));
                        switch(_loc_2.type)
                        {
                            case ZoneType.ZONES_BELIAL_WORLD:
                            {
                                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BELIA_WORLD_ZONE_TEAM)) == 1)
                                {
                                    MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_BELIAL_WORLD);
                                }
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_BELIAL_WORLD, _loc_8.toString());
                                if (_loc_9 > 0 && _loc_4.isopen == 3)
                                {
                                    MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_BELIAL_WORLD, _loc_9 / 1000);
                                }
                                if (_loc_8 <= 0)
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_BELIAL_WORLD, false);
                                }
                                else if (!(_loc_9 > 0 && _loc_4.isopen == 3))
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_BELIAL_WORLD, true);
                                }
                                break;
                            }
                            case ZoneType.ZONES_XS:
                            {
                                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().XSCB_ZONE_TEAM)) == 1)
                                {
                                    MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_SCARLET_HOLD);
                                }
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_SCARLET_HOLD, _loc_8.toString());
                                if (_loc_9 > 0 && _loc_4.isopen == 3)
                                {
                                    MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_SCARLET_HOLD, _loc_9 / 1000);
                                }
                                if (_loc_8 <= 0)
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_SCARLET_HOLD, false);
                                }
                                else if (!(_loc_9 > 0 && _loc_4.isopen == 3))
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_SCARLET_HOLD, true);
                                }
                                break;
                            }
                            case ZoneType.ZONES_ANGEL:
                            {
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_WOLF_SOUL, _loc_8.toString());
                                break;
                            }
                            case ZoneType.ZONES_BOSS_HOME:
                            {
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_BOSS_HOME, _loc_8.toString());
                                break;
                            }
                            case ZoneType.ZONES_ISLAND:
                            {
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_ISLAND, _loc_8.toString());
                                if (_loc_9 > 0 && _loc_4.isopen == 3)
                                {
                                    MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_ISLAND, _loc_9 / 1000);
                                }
                                if (_loc_8 <= 0)
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_ISLAND, false);
                                }
                                else if (!(_loc_9 > 0 && _loc_4.isopen == 3))
                                {
                                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_ISLAND, true);
                                }
                                IslandData.getInstance().hasEnterTime = _loc_4.enternum;
                                IslandData.getInstance().maxEnterTime = _loc_4.enterMaxnum;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    _loc_5++;
                }
            }
            if (param1.type > 0)
            {
                _loc_2 = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.type);
                if (_loc_2)
                {
                    switch(_loc_2.type)
                    {
                        case 1:
                        {
                            if (this._viewBelialWorld)
                            {
                                this._viewBelialWorld.zoneServerInfo = param1.zoneteaminfo[0];
                            }
                            break;
                        }
                        case 2:
                        {
                            if (this._viewXS)
                            {
                                this._viewXS.zoneServerInfo = param1.zoneteaminfo[0];
                            }
                            break;
                        }
                        case 3:
                        {
                            if (this._viewWS)
                            {
                                this._viewWS.zoneServerInfo = param1.zoneteaminfo[0];
                            }
                            break;
                        }
                        case ZoneType.ZONES_BOSS_HOME:
                        {
                            if (this._viewBossHome)
                            {
                                this._viewBossHome.zoneServerInfo = param1.zoneteaminfo[0];
                                _loc_6 = param1.zoneteaminfo[0].enterMaxnum;
                                _loc_7 = param1.zoneteaminfo[0].enternum;
                                _loc_8 = _loc_6 - _loc_7;
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_BOSS_HOME, _loc_8.toString());
                            }
                            break;
                        }
                        case ZoneType.ZONES_ISLAND:
                        {
                            if (param1.zoneteaminfo.length)
                            {
                                IslandData.getInstance().hasEnterTime = param1.zoneteaminfo[0].enternum;
                                IslandData.getInstance().maxEnterTime = param1.zoneteaminfo[0].enterMaxnum;
                                _loc_6 = param1.zoneteaminfo[0].enterMaxnum;
                                _loc_7 = param1.zoneteaminfo[0].enternum;
                                _loc_8 = _loc_6 - _loc_7;
                                MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_ISLAND, _loc_8.toString());
                                if (IslandControl.getInstance().islandBox)
                                {
                                    IslandControl.getInstance().islandBox.zoneServerInfo = param1.zoneteaminfo[0];
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            FrameworkGlobal.sendMsg(new ZoneEvent(ZoneEvent.ZONE_INFO_UPDATE, param1.type));
            return;
        }// end function

        public function resZoneTeamOpenBullToClient(param1:ResZoneTeamOpenBullToClientMessage) : void
        {
            return;
        }// end function

        public function dealBossHomeAnger(param1:ResBossHomePlayerNumMessage) : void
        {
            BossHomeModel.getInstance().anger = param1.afternum;
            BossHomeModel.getInstance().orginAnger = param1.beforenum;
            if (this._bossHomeIcon == null)
            {
                this._bossHomeIcon = new BossHomeIcon();
            }
            if (!ZonesControl.getInstance().inBossHome())
            {
                ToolKit.disappear(this._bossHomeIcon);
            }
            if ((ZonesControl.getInstance().inBossHome() || this.intendToBossHome) && this._bossHomeIcon.parent == null)
            {
                Global.mainUIManager.addUI(this._bossHomeIcon);
                this._bossHomeIcon.parent.setChildIndex(this._bossHomeIcon, 0);
                this._bossHomeIcon.x = BossHomeConsts.DROP_ICON_X;
                this._bossHomeIcon.y = BossHomeConsts.DROP_ICON_Y;
            }
            this._bossHomeIcon.update();
            if (param1.beforenum < 100 && param1.afternum >= 100)
            {
                BossHomeModel.getInstance()._startend = getTimer();
            }
            return;
        }// end function

        public function resZoneTimeRecordNotice(param1:ResZoneTimeRecordNoticeMessage) : void
        {
            return;
        }// end function

        public function resZoneTimer(param1:ResZoneTimerMessage) : void
        {
            ZonesModel.getInstance().zoneid = param1.zoneid;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(param1.zoneid);
            switch(_loc_2.type)
            {
                case ZoneType.ZONES_BELIAL_WORLD:
                {
                    this.viewBeliaworldTrace.zoneInfo = param1;
                    break;
                }
                case ZoneType.ZONES_XS:
                {
                    this.scarletholdTrace.zoneInfo = param1;
                    break;
                }
                case ZoneType.ZONES_DELARON:
                {
                    this.viewDekaronTrace.open();
                    this.viewDekaronTrace.updateInfo();
                    this.zonesDownTime.updateDownTime(param1.surplustime, 0);
                    break;
                }
                case ZoneType.ZONES_ISLAND:
                {
                    this.islandState.zoneInfo = param1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function resBuffInspireAdd(param1:ResBuffAddMessage) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0)
            {
                if (this._viewInspire)
                {
                    this._viewInspire.setInspireBuf(param1.buffId, param1.num);
                }
                switch(_loc_2.zones_type)
                {
                    case ZoneType.ZONES_XS:
                    {
                        break;
                    }
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        this.viewBeliaworldTrace.setInspireBuf(param1.buffId, param1.num);
                        break;
                    }
                    case ZoneType.ZONES_RED_FORTRESS:
                    {
                        ZonesRedFortressControl.getInstance().setInspireBuf(param1.buffId, param1.num);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function resClearZoneCDBack(param1:ResClearZoneCDMessage) : void
        {
            var _loc_2:* = param1.zoneid;
            var _loc_3:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
            if (_loc_3)
            {
                switch(_loc_3.type)
                {
                    case 1:
                    {
                        if (this._viewBelialWorld)
                        {
                            this._viewBelialWorld.clearCD();
                        }
                        MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_BELIAL_WORLD, 0);
                        break;
                    }
                    case 2:
                    {
                        if (this._viewXS)
                        {
                            this._viewXS.clearCD();
                        }
                        MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_SCARLET_HOLD, 0);
                        break;
                    }
                    case ZoneType.ZONES_ISLAND:
                    {
                        if (IslandControl.getInstance().islandBox)
                        {
                            IslandControl.getInstance().islandBox.clearCD();
                        }
                        MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_ISLAND, 0);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function getZonesInfoForZoneId(param1:int) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.level;
            var _loc_3:* = ZonesCloneCfg.getInstance().getCurZones(_loc_2, param1);
            if (_loc_3)
            {
                this.reqZoneTeamOpenToGame(_loc_3.id);
            }
            return;
        }// end function

        public function reqSelectAward(param1:int, param2:int) : void
        {
            this._protocol.reqSelectAward(param1, param2);
            return;
        }// end function

        public function reqZoneAutoAwardToGame() : void
        {
            this._protocol.reqZoneAutoAwardToGame();
            return;
        }// end function

        private function reqZoneCancelSignupToGame(param1:int, param2:int) : void
        {
            this._protocol.reqZoneCancelSignupToGame(param1, param2);
            return;
        }// end function

        private function reqZoneContinuousRaids() : void
        {
            this._protocol.reqZoneContinuousRaids();
            return;
        }// end function

        private function reqZoneContinuousRaidsStop() : void
        {
            this._protocol.reqZoneContinuousRaidsStop();
            return;
        }// end function

        private function reqZoneContinuousRaidsYB() : void
        {
            this._protocol.reqZoneContinuousRaidsYB();
            return;
        }// end function

        private function reqZoneImmediately(param1:int) : void
        {
            this._protocol.reqZoneImmediately(param1);
            return;
        }// end function

        private function reqZoneImmediatelyByCost(param1:int) : void
        {
            this._protocol.reqZoneImmediatelyByCost(param1);
            return;
        }// end function

        public function reqZoneInto(param1:int, param2:int) : void
        {
            var _loc_3:* = RoleList.getInstance().player;
            if (_loc_3 && _loc_3.alive())
            {
                this._protocol.reqZoneInto(param1, param2);
            }
            return;
        }// end function

        private function reqZoneOpenPanel() : void
        {
            this._protocol.reqZoneOpenPanel();
            return;
        }// end function

        public function reqZoneOut() : void
        {
            this._protocol.reqZoneOut();
            return;
        }// end function

        public function reqZoneReceiveawards(param1:int, param2:int) : void
        {
            this._protocol.reqZoneReceiveawards(param1, param2);
            return;
        }// end function

        public function reqZoneTeamEnterToGame(param1:int, param2:int) : void
        {
            if (this.inBossHome())
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10011", BossHomeConsts.LANG_VER), null, null, null, null, 1);
                return;
            }
            var _loc_3:* = RoleList.getInstance().player;
            if (_loc_3 && _loc_3.alive())
            {
                this._protocol.reqZoneTeamEnterToGame(param1, param2);
            }
            return;
        }// end function

        public function reqZoneTeamOpenToGame(param1:int = 0) : void
        {
            this._protocol.reqZoneTeamOpenToGame(param1);
            return;
        }// end function

        public function reqZoneTeamSelectToGame(param1:int, param2:int) : void
        {
            this._protocol.reqZoneTeamSelectToGame(param1, param2);
            return;
        }// end function

        public function reqAddInspireBuff(param1:int) : void
        {
            this._protocol.reqAddInspireBuff(param1);
            return;
        }// end function

        public function reqclearZoneCD(param1:int) : void
        {
            this._protocol.reqClearZoneCD(param1);
            return;
        }// end function

        public function reqChangeClientZone(param1:int, param2:int, param3:int) : void
        {
            this._protocol.reqChangeClientZone(param1, param2, param3);
            return;
        }// end function

        public function reqTowerIndex() : void
        {
            this._protocol.reqTowerIndex();
            return;
        }// end function

        public function autoFight() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0)
            {
                switch(_loc_2.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        _loc_1 = true;
                        ScarletHoldControl.getInstance().isHangUp = !ScarletHoldControl.getInstance().isHangUp;
                        if (this._scarletholdTrace)
                        {
                            this._scarletholdTrace.updateBtn();
                        }
                        break;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_1;
        }// end function

        public function getMonst() : IRole
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_1.mapZones > 0)
            {
                switch(_loc_1.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        break;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        return ScarletHoldControl.getInstance().getMonst();
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return null;
        }// end function

        public function isZonesNeedSelectMonst() : Boolean
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_1.mapZones > 0)
            {
                switch(_loc_1.zones_type)
                {
                    case ZoneType.ZONES_BELIAL_WORLD:
                    {
                        return false;
                    }
                    case ZoneType.ZONES_XS:
                    {
                        return ScarletHoldModel.getInstance().curPhase > 0;
                    }
                    case ZoneType.ZONES_DELARON:
                    {
                        return false;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return false;
        }// end function

        public function resZoneTeamError(param1:ResZoneTeamErroMessage) : void
        {
            var msg:* = param1;
            var code:* = ZonesDefault.getInstance().getErrorCode(msg.type);
            code = code.replace("{1}", msg.name);
            Global.popManager.cue(code, LanguageCfgObj.getInstance().getByIndex("11463"), null, function () : void
            {
                TeamControl.getInstance().reqToLeaveGame(msg.memberid, 0);
                return;
            }// end function
            );
            return;
        }// end function

        public function resTowerNextLv(param1:ResTowerNextLvMessage) : void
        {
            if (this._viewDekaron)
            {
                this._viewDekaron.towerNestLv();
            }
            return;
        }// end function

        public function resTowerRewardSurplus(param1:ResTowerRewardSurplusMessage) : void
        {
            ZonesModel.getInstance().dekaronGiftInfo = param1;
            if (this._viewDekaron)
            {
                this._viewDekaron.setGiftInfo();
            }
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_DEKARON, param1.surplus.toString());
            return;
        }// end function

        public function resTowerReward(param1:ResTowerRewardMessage) : void
        {
            if (this._viewDekaron)
            {
                this._viewDekaron.towerReward();
            }
            return;
        }// end function

        public function getZoneLastTimes(param1:int) : int
        {
            var _loc_2:* = this.getZoneTeamInfo(param1);
            if (_loc_2)
            {
                return _loc_2.enterMaxnum - _loc_2.enternum;
            }
            return 0;
        }// end function

        public function getZoneTeamInfo(param1:int) : ZoneTeamInfo
        {
            var _loc_2:* = ZonesModel.getInstance().zoneTeamAllInfo;
            var _loc_3:* = _loc_2 ? (_loc_2.length) : (0);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4].zoneType == param1)
                {
                    return _loc_2[_loc_4];
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function resTowerIndex(param1:ResTowerIndexMessage) : void
        {
            this._model.dekaronInfo = param1;
            if (this._viewDekaron)
            {
                this._viewDekaron.zonesDekaronInfo = param1;
            }
            if (this._viewDekaronTrace && this._viewDekaronTrace.parent)
            {
                this._viewDekaronTrace.updateInfo();
            }
            return;
        }// end function

        public function reqTowerNextLv() : void
        {
            this._protocol.reqTowerNextLv();
            return;
        }// end function

        public function reqTowerReward() : void
        {
            this._protocol.reqTowerReward();
            return;
        }// end function

        public function openZonesIcon(param1:ResOpenIconMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            ZonesModel.getInstance().isWolfSoulAct = true;
            MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_WOLF_SOUL);
            MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_WOLF_SOUL, param1.residue);
            if (ZonesModel.getInstance().isWolfSoulAct)
            {
                _loc_2 = this.getZoneTeamInfo(ZoneType.ZONES_ANGEL);
                if (_loc_2 && _loc_2.enternum < _loc_2.enterMaxnum)
                {
                    this.openWolfWelcome();
                }
                if (_loc_2)
                {
                    _loc_3 = _loc_2.enterMaxnum - _loc_2.enternum;
                    MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_WOLF_SOUL, _loc_3.toString());
                }
            }
            return;
        }// end function

        public function openWolfWelcome() : void
        {
            var _loc_1:* = MapObj.getInstance().mapID;
            var _loc_2:* = MapCfgObj.getInstance().getMap(_loc_1);
            if (_loc_2.zones_type != 0)
            {
                return;
            }
            if (!this._wolfSoulWelcome)
            {
                this._wolfSoulWelcome = new ZonesWolfSoulWelcome();
            }
            if (UserObj.getInstance().playerInfo.level < 160)
            {
                return;
            }
            this._wolfSoulWelcome.open();
            return;
        }// end function

        public function closeWolfWelcome() : void
        {
            if (this._wolfSoulWelcome)
            {
                this._wolfSoulWelcome.close();
            }
            return;
        }// end function

        public function openWolfSoulSneakCount(param1:ResSneakMessage) : void
        {
            if (!this._sneakView)
            {
                this._sneakView = new ZonesWolfSoulSneakView();
            }
            this._sneakView.open();
            this._sneakView.setCountDown(param1.residue - Math.ceil(ToolKit.getServerTime() * 0.001));
            this.wolfHintView.showSneak();
            return;
        }// end function

        public function closeWolfSoulSneakCount() : void
        {
            if (this._sneakView)
            {
                this._sneakView.close();
            }
            return;
        }// end function

        public function updateSpecialView(param1:ResSpecialMessage) : void
        {
            if (!this._specialView)
            {
                this._specialView = new ZonesWolfSoulSpecialView();
            }
            this._specialView.open();
            this._specialView.setCountDown(param1.residue);
            this._specialView.setBuff(param1.buffId);
            return;
        }// end function

        public function closeSpecialView() : void
        {
            if (this._specialView)
            {
                this._specialView.close();
            }
            return;
        }// end function

        public function closeZonesIcon(param1:ResHideIconMessage) : void
        {
            ZonesModel.getInstance().isWolfSoulAct = false;
            MapControl.getInstance().setTopIconCD(TopActivateName.TOP_ICON_WOLF_SOUL, 0);
            MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_WOLF_SOUL);
            this.closeWolfWelcome();
            this.closeZonesWolfSoul();
            return;
        }// end function

        public function closeWolfBossHead() : void
        {
            if (this._wolfHead)
            {
                this._wolfHead.finalize();
                Global.mainUIManager.removeUI(this._wolfHead);
                this._wolfHead = null;
            }
            return;
        }// end function

        public function updateWolfBossHead(param1:ResNpcBloodMessage) : void
        {
            if (!this._viewEvaluateView)
            {
                this._viewEvaluateView = new ZonesBeliaWorldEvaluateView();
            }
            this._viewEvaluateView.updateBlood(param1.hp / param1.maxhp * 100);
            if (param1.hp != param1.maxhp)
            {
                this.wolfHintView.showHit();
            }
            return;
        }// end function

        public function updateWolfSoulStep(param1:int) : void
        {
            this.wolfHintView.showRound(param1);
            return;
        }// end function

        public function wolfSoulNpcBuffAct() : void
        {
            this.wolfHintView.showWudi();
            return;
        }// end function

        private function get wolfHintView() : ZonesWolfHintView
        {
            if (!this._wolfHintView)
            {
                this._wolfHintView = new ZonesWolfHintView();
            }
            return this._wolfHintView;
        }// end function

        private function __updateTimes(event:Event) : void
        {
            var _loc_2:* = this.getZoneTeamInfo(ZoneType.ZONES_ANGEL);
            var _loc_3:* = false;
            if (_loc_2 && _loc_2.enternum < _loc_2.enterMaxnum)
            {
                _loc_3 = true;
            }
            if (!ZonesModel.getInstance().isWolfSoulAct || !_loc_3)
            {
                this.closeWolfWelcome();
            }
            if (ZonesModel.getInstance().isWolfSoulAct && _loc_3)
            {
                this.openWolfWelcome();
            }
            return;
        }// end function

        public static function getInstance() : ZonesControl
        {
            if (!_instance)
            {
                _instance = new ZonesControl;
            }
            return _instance;
        }// end function

    }
}
