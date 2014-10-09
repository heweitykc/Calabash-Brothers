package com.game.redfortress.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.player.model.*;
    import com.game.redfortress.message.*;
    import com.game.redfortress.model.*;
    import com.game.redfortress.protocol.*;
    import com.game.redfortress.view.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.view.bosshome.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class ZonesRedFortressControl extends Object
    {
        private var _model:ZonesRedfortressModel;
        private var _protocol:ZonesRedFortressProtocol;
        private var _viewRedFortressPanel:ZonesRedFortressPanel;
        private var _viewTopList:ZonesRedFortressTopListPanel;
        private var _viewTrace:ZonesRedFortressTraceView;
        private var _viewWelcome:ZonesRedFortressWelcome;
        private var _viewGiftEffect:ZonesRedfortressGiftEffect;
        private var _viewReliveDown:ZonesRedfortressPlayerDieRelive;
        private static var _instance:ZonesRedFortressControl;

        public function ZonesRedFortressControl()
        {
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this._model = ZonesRedfortressModel.getInstance();
            this._protocol = new ZonesRedFortressProtocol();
            return;
        }// end function

        public function openOrCloseRedFortressPanel() : void
        {
            if (ZonesControl.getInstance().inBossHome())
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10011", BossHomeConsts.LANG_VER), null, null, null, null, 1);
                return;
            }
            if (!this._viewRedFortressPanel)
            {
                this._viewRedFortressPanel = new ZonesRedFortressPanel();
                Global.popManager.addPop(this._viewRedFortressPanel);
            }
            this._viewRedFortressPanel.openOrClose();
            this.closeRedFortressTraceView();
            if (this._viewWelcome)
            {
                this._viewWelcome.close();
            }
            return;
        }// end function

        public function openRedFortressTopListPanel() : void
        {
            if (!this._viewTopList)
            {
                this._viewTopList = new ZonesRedFortressTopListPanel();
                Global.popManager.addPop(this._viewTopList);
            }
            this._viewTopList.open();
            return;
        }// end function

        public function openRedFortressTraceView() : void
        {
            if (!this._viewTrace)
            {
                this._viewTrace = new ZonesRedFortressTraceView();
            }
            this._viewTrace.open();
            return;
        }// end function

        public function closeRedFortressTraceView() : void
        {
            if (this._viewTrace)
            {
                this._viewTrace.close();
            }
            return;
        }// end function

        public function openRedFortressWelcome() : void
        {
            if (!this._viewWelcome)
            {
                this._viewWelcome = new ZonesRedFortressWelcome();
            }
            this._viewWelcome.open();
            return;
        }// end function

        public function openRedDortressRelive(param1:int) : void
        {
            if (!this._viewReliveDown)
            {
                this._viewReliveDown = new ZonesRedfortressPlayerDieRelive();
                Global.popManager.addPop(this._viewReliveDown, true, true, false);
            }
            this._viewReliveDown.startDelayRelive(param1);
            return;
        }// end function

        public function closeRedDortressRelive() : void
        {
            if (this._viewReliveDown && this._viewReliveDown.parent)
            {
                this._viewReliveDown.startDelayRelive(0);
            }
            return;
        }// end function

        public function resChangeIntegralHandler(param1:ResChangeIntegralMessage) : void
        {
            if (param1.changeType == 3)
            {
                if (!this._viewGiftEffect)
                {
                    this._viewGiftEffect = new ZonesRedfortressGiftEffect(ZonesRedfortressGiftEffect.ZONES_REDFORTRESS_GIFT_COUNT);
                }
                this._viewGiftEffect.setCount(param1.Integral);
            }
            else
            {
                RoleList.getInstance().player.showZonesIntegral(param1.addedIntegral + param1.Integral);
            }
            if (param1.addedIntegral > 0)
            {
                Global.popManager.addedToFight(LanguageCfgObj.getInstance().getByIndex("12175") + param1.addedIntegral);
            }
            return;
        }// end function

        public function resCsysTopListHandler(param1:ResCsysTopListMessage) : void
        {
            this._model.zonesRankInfo = param1.infos;
            if (this._viewTrace)
            {
                this._viewTrace.updateView();
            }
            return;
        }// end function

        public function resZonesPassShow(param1:ResCsysEndMessage) : void
        {
            this.openRedFortressTopListPanel();
            this._viewTopList.topListInfo = param1;
            return;
        }// end function

        public function reqCsysTopList() : void
        {
            this._protocol.reqCsysTopList();
            return;
        }// end function

        public function zonesEnter() : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(0, 6001);
            return;
        }// end function

        public function zonesQuit() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            return;
        }// end function

        public function setInspireBuf(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function resetPlayerInfo() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = EquipsObj.getInstance().info;
            var _loc_2:* = _loc_1.items.length;
            for each (_loc_3 in _loc_1.items)
            {
                
                switch(_loc_3.pos)
                {
                    case Params.LEFT_WEAPON:
                    {
                        if (_loc_3.itemId && _loc_3.itemId.toNumber() > 0)
                        {
                            UserObj.getInstance().playerInfo.weapon = _loc_3;
                        }
                        else
                        {
                            UserObj.getInstance().playerInfo.weapon = null;
                        }
                        break;
                    }
                    case Params.RIGHT_WEAPON:
                    {
                        if (_loc_3.itemId && _loc_3.itemId.toNumber() > 0)
                        {
                            UserObj.getInstance().playerInfo.weapon_other = _loc_3;
                        }
                        else
                        {
                            UserObj.getInstance().playerInfo.weapon_other = null;
                        }
                        break;
                    }
                    case Params.BODY:
                    {
                        if (_loc_3.itemId && _loc_3.itemId.toNumber() > 0)
                        {
                            UserObj.getInstance().playerInfo.armor = _loc_3;
                        }
                        else
                        {
                            UserObj.getInstance().playerInfo.armor = null;
                        }
                        break;
                    }
                    case Params.WING:
                    {
                        if (_loc_3.itemId && _loc_3.itemId.toNumber() > 0)
                        {
                            UserObj.getInstance().playerInfo.wingInfo = _loc_3;
                        }
                        else
                        {
                            UserObj.getInstance().playerInfo.wingInfo = null;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            _loc_4 = RoleList.getInstance().player;
            if (_loc_4)
            {
                _loc_4.isZonesMorph = false;
                _loc_4.updateAct();
                _loc_4.info.csysKills = 0;
            }
            return;
        }// end function

        public function resPlayerKill(param1:ResPlayerKillMessage) : void
        {
            var _loc_2:* = null;
            if (param1.playerId.equal(UserObj.getInstance().playerInfo.personId))
            {
                UserObj.getInstance().playerInfo.csysKills = param1.count;
                _loc_2 = RoleList.getInstance().player;
                if (_loc_2)
                {
                    _loc_2.info.csysKills = param1.count;
                }
            }
            else
            {
                _loc_2 = RoleList.getInstance().getRole(param1.playerId);
                if (_loc_2)
                {
                    _loc_2.info.csysKills = param1.count;
                }
            }
            return;
        }// end function

        public function resEnterActivate(param1:ResEnterActivitieMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            switch(param1.type)
            {
                case -1:
                {
                    MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_RED_FORTRESS);
                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_RED_FORTRESS, true);
                    break;
                }
                case 0:
                case 3:
                {
                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_RED_FORTRESS, false);
                    MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_RED_FORTRESS);
                    break;
                }
                case 1:
                {
                    _loc_2 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                    _loc_3 = ZonesCloneCfg.getInstance().getZonesInfoFromId(ZonesRedfortressModel.ZONES_ID);
                    _loc_4 = UserObj.getInstance().playerInfo.level;
                    if (_loc_2 && _loc_2.zones_type != ZoneType.ZONES_RED_FORTRESS && _loc_4 >= _loc_3.min_lv)
                    {
                        this.openRedFortressWelcome();
                    }
                    break;
                }
                case 2:
                {
                    MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_RED_FORTRESS);
                    MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_RED_FORTRESS, true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function resZoneLifeTime(param1:ResZoneLifeTimeMessage) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones > 0)
            {
                switch(_loc_2.zones_type)
                {
                    case ZoneType.ZONES_RED_FORTRESS:
                    {
                        _loc_3 = param1.phase == 1 ? (param1.surplustime + 10 * 60) : (param1.surplustime);
                        if (this._viewTrace)
                        {
                            this._viewTrace.setCDTime(_loc_3, param1.phase);
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

        public static function getInstance() : ZonesRedFortressControl
        {
            if (!_instance)
            {
                _instance = new ZonesRedFortressControl;
            }
            return _instance;
        }// end function

    }
}
