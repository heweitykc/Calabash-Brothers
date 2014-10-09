package com.game.map.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.f1.vmc.gpu.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import com.game.card.control.*;
    import com.game.chat.view.*;
    import com.game.clickstream.*;
    import com.game.cloudbuy.control.*;
    import com.game.country.control.*;
    import com.game.country.view.*;
    import com.game.elementHeart.model.*;
    import com.game.equip.message.*;
    import com.game.equipstreng.control.*;
    import com.game.fight.control.*;
    import com.game.greedisland.model.*;
    import com.game.guide.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.magicbook.model.*;
    import com.game.mail.control.*;
    import com.game.map.bean.*;
    import com.game.map.message.*;
    import com.game.map.model.*;
    import com.game.map.protocol.*;
    import com.game.map.view.*;
    import com.game.map.view.scrollcue.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.operationpanel.control.*;
    import com.game.operationpanel.view.*;
    import com.game.player.control.*;
    import com.game.player.message.*;
    import com.game.player.model.*;
    import com.game.primaryrole.cfg.*;
    import com.game.primaryrole.control.*;
    import com.game.primaryrole.util.*;
    import com.game.prompt.utils.*;
    import com.game.prompt.view.*;
    import com.game.redfortress.control.*;
    import com.game.redfortress.view.*;
    import com.game.role.*;
    import com.game.skill.message.*;
    import com.game.sound.control.*;
    import com.game.structs.*;
    import com.game.summonpet.bean.*;
    import com.game.summonpet.message.*;
    import com.game.summonpet.view.*;
    import com.game.task.model.*;
    import com.game.task.view.*;
    import com.game.team.message.*;
    import com.game.transactions.control.*;
    import com.game.utils.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import com.game.xscb.control.*;
    import com.game.xscb.view.*;
    import com.game.zones.control.*;
    import com.game.zones.model.*;
    import com.game.zones.view.bosshome.*;
    import com.game.zones.view.bosshome.cfg.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.model.*;
    import com.model.vo.*;
    import com.platform.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class MapControl extends Object implements IGuide
    {
        private var _currentGameScene:GameScene;
        private var _userInfo:PlayerInfo;
        private var _user:IRole;
        public var isClientMove:Boolean = false;
        public var isClientPick:Boolean = false;
        public var isCanOpenBigMap:Boolean = true;
        public var isChangingMap:Boolean = false;
        private var _protocol:MapProtocol;
        private var _bigMapPanel:BigMapPanel;
        private var _topActivateIconsPanel:TopActivatePanel;
        private var _minimap:MiniMap;
        private var _bottomBar:OperationBottomBar;
        private var _chat:ChatComponent;
        private var _messagestipsView:MessagesTipsView;
        private var _scrollCue:ScrollCue;
        private var isListeningLoadingBoxClose:Boolean = false;
        private var _summonPetPanel:SummonPetPanel;
        private var copyIdArray:Array;
        private var adultBtn:BaseButton;
        private var _bosshomeDic:Dictionary;
        private const WS_BLOCK:Array;
        private var _loadingComponent:ChangeSceneLoadingComponent;
        private static var instance:MapControl;
        public static const STEP_LIMIT:int = 50;
        public static const coordFrom:Point = new Point();
        public static const coordTo:Point = new Point();
        public static var coordArr:Array;

        public function MapControl()
        {
            this.copyIdArray = [3007, 3008, 3009];
            this.WS_BLOCK = [[70, 151], [89, 160]];
            this._protocol = new MapProtocol();
            this._userInfo = UserObj.getInstance().playerInfo;
            this._userInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.__userLevelUpdate);
            this._userInfo.addEvtListener(RoleEvent.UPDATE_UNALLOCALTEDTALENT, this.__updateunlocateTalent);
            this._userInfo.addEvtListener(RoleEvent.UPDATE_VIP_LEVEL, this.__updateVipCopy);
            this._topActivateIconsPanel = new TopActivatePanel();
            Global.mainUIManager.addUI(this._topActivateIconsPanel, new LayoutInfo(Layout.RIGHT, 260, 10), GroupPanelType.GROUP_ACTIVATE, true);
            this.initTopBtn();
            this.initMainUI();
            ItemTips.equipcompareControl = new EquipCompareControl();
            FrameworkGlobal.stageAddEvtListener(SysCueEvent.LINK, this.__sysCue);
            return;
        }// end function

        public function get currentGameScene() : GameScene
        {
            return this._currentGameScene;
        }// end function

        public function get chat() : ChatComponent
        {
            return this._chat;
        }// end function

        public function get scrollCue() : ScrollCue
        {
            return this._scrollCue;
        }// end function

        public function get minimap() : MiniMap
        {
            return this._minimap;
        }// end function

        public function get bottomBar() : OperationBottomBar
        {
            return this._bottomBar;
        }// end function

        public function get topActivateIconsPanel() : TopActivatePanel
        {
            return this._topActivateIconsPanel;
        }// end function

        public function addedToTopIcon(param1:String) : void
        {
            this.topActivateAddedBtn(param1);
            return;
        }// end function

        public function hasTopBtn(param1:String) : Boolean
        {
            if (this._topActivateIconsPanel && this._topActivateIconsPanel.hasTopBtn(param1))
            {
                return true;
            }
            return false;
        }// end function

        public function showNormalEffect(param1:String, param2:Boolean) : void
        {
            if (this._topActivateIconsPanel)
            {
                this._topActivateIconsPanel.showNormalEffect(param1, param2);
            }
            return;
        }// end function

        public function showFuncEffect(param1:String) : void
        {
            if (this._topActivateIconsPanel)
            {
                this._topActivateIconsPanel.showFuncEffect(param1);
            }
            return;
        }// end function

        public function setTopIconCD(param1:String, param2:uint) : void
        {
            if (this._topActivateIconsPanel)
            {
                this._topActivateIconsPanel.setTopBtnCd(param1, param2);
            }
            return;
        }// end function

        public function removeFromTopIcon(param1:String) : void
        {
            this.topActivateRemoveBtn(param1);
            return;
        }// end function

        public function topActivateBtnTips(param1:String, param2:String) : void
        {
            this._topActivateIconsPanel.setTopBtnTips(param1, param2);
            return;
        }// end function

        public function topActivateSetCountText(param1:String, param2:String) : void
        {
            this._topActivateIconsPanel.setTopBtnCountText(param1, param2);
            return;
        }// end function

        public function topActivateAddedBtn(param1:String, param2:Boolean = false) : void
        {
            this._topActivateIconsPanel.addTopBtn(param1, param2);
            if (param1 == TopActivateName.TOP_BOSS_HOME)
            {
                ZonesControl.getInstance().reqZoneTeamOpenToGame(6002);
            }
            if (param1 == TopActivateName.TOP_ICON_ISLAND)
            {
                ZonesControl.getInstance().reqZoneTeamOpenToGame(9001);
            }
            Global.mainUIManager.layoutUI(this._topActivateIconsPanel);
            return;
        }// end function

        public function topActivateRemoveBtn(param1:String) : void
        {
            this._topActivateIconsPanel.removeTopBtn(param1);
            Global.mainUIManager.layoutUI(this._topActivateIconsPanel);
            return;
        }// end function

        private function initMainUI() : void
        {
            this._minimap = new MiniMap();
            this._bottomBar = OperationPanelControl.getInstance().panel;
            Global.mainUIManager.addUI(this._minimap, new LayoutInfo(Layout.RIGHT), GroupPanelType.GROUP_LEVEL1);
            Global.mainUIManager.addUI(this._bottomBar, new LayoutInfo(Layout.BOTTOM_CENTER, 0, -1), GroupPanelType.GROUP_LEVEL1);
            this._chat = new ChatComponent();
            this._chat.resize();
            Global.mainUIManager.addUI(this._chat, this._chat.layout, GroupPanelType.GROUP_LOW);
            this._scrollCue = new ScrollCue();
            this._scrollCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH / 2);
            Global.popManager.txtLayer.addChild(this._scrollCue);
            this._messagestipsView = new MessagesTipsView();
            var _loc_1:* = new LayoutInfo(Layout.BOTTOM_RIGHT, -5, -10);
            Global.mainUIManager.addUI(this._messagestipsView, _loc_1, GroupPanelType.IMPORTANT_MSG);
            var _loc_2:* = FastTaskPanel.getInstance();
            Global.mainUIManager.addUI(_loc_2, new LayoutInfo(Layout.RIGHT, 0, 155), GroupPanelType.GROUP_LEVEL1);
            if (MailController.getInstance().newMail)
            {
                this.showCount(MailController.getInstance().newMail);
            }
            return;
        }// end function

        public function addyanhua(param1:String) : void
        {
            var _loc_2:* = new VMCView();
            _loc_2.auto = true;
            _loc_2.updatePose("90", false, false, true, true);
            _loc_2.loadRes("res/effect/" + param1 + ".png");
            _loc_2.move(FrameworkGlobal.stageW >> 1, FrameworkGlobal.stageH >> 1);
            _loc_2.scale = 2;
            FrameworkGlobal.stage.addChild(_loc_2);
            return;
        }// end function

        public function setZoneTime(param1:int) : void
        {
            return;
        }// end function

        public function addChest(param1:PropInfo) : void
        {
            this._scrollCue.addChest(param1);
            return;
        }// end function

        private function __transClick(event:MouseEvent) : void
        {
            TransactionControl.getInstance().openConfirm();
            return;
        }// end function

        public function addImportantMsg(param1:String) : void
        {
            if (this._messagestipsView)
            {
                this._messagestipsView.acceptInfo(param1);
            }
            return;
        }// end function

        public function updateLines(param1:Array, param2:int) : void
        {
            this._minimap.updateDropListLines(param1, param2);
            return;
        }// end function

        public function getScreenShiledSelectState() : Boolean
        {
            if (this._minimap)
            {
                return this._minimap.getScreenShiledSelectState();
            }
            return false;
        }// end function

        private function __sysCue(event:SysCueEvent) : void
        {
            switch(event.data)
            {
                case "vip":
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case "compose_wing":
                {
                    EquipComposeControl.getInstance().openOnlyEquipComposeBox(LanguageCfgObj.getInstance().getByIndex("10926"), true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showsignWageBtnState() : void
        {
            return;
        }// end function

        public function showOrHideCardPhone(param1:Boolean) : void
        {
            if (Params.pvType == PhoneVerifyType.NO_VERIFY)
            {
                return;
            }
            if (param1)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_CARD_PHONE);
                if (Params.pvType == PhoneVerifyType.GO_PANEL)
                {
                    this.topActivateBtnTips(TopActivateName.TOP_ICON_CARD_PHONE, LanguageCfgObj.getInstance().getByIndex("10927"));
                }
            }
            else
            {
                this.topActivateRemoveBtn(TopActivateName.TOP_ICON_CARD_PHONE);
            }
            return;
        }// end function

        private function openCardBox(event:MouseEvent) : void
        {
            CardControl.getInstance().openCardBox();
            return;
        }// end function

        public function initTopBtn() : void
        {
            this.topActivateAddedBtn(TopActivateName.TOP_ICON_VIP_COPY);
            this.topActivateAddedBtn(TopActivateName.TOP_ICON_REWARDS_THOLD);
            this.topActivateAddedBtn(TopActivateName.TOP_ICON_BANK);
            this.topActivateAddedBtn(TopActivateName.TOP_ICON_ISLAND);
            TweenLite.delayedCall(0.2, this.showOrHideChangeJob);
            GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().DESKTOP_ACTIVE_TEAM), Params.loginType == LoginType.WEIDUAN || Params.wdType == WeiDuanType.NO_WEIDUAN ? (1) : (0));
            this.showNormalEffect(TopActivateName.TOP_ICON_LINK_TO_DESKTOP, UserObj.getInstance().playerInfo.firstWeiduan == 1);
            this.guideConfigComplete();
            this.registerGuide();
            if (Params.isadult == AdultType.ADULT_NOT_COMPLET || Params.isadult == AdultType.WEB_COMPLETE)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_PERSONAL_INFORMATION);
            }
            if (MagicBookData.isShowIcon())
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_MAGIC_BOOK);
            }
            ZonesModel.getInstance().addEventListener(ZonesModel.COPY_TIMES_CHANGE, this.__updateVipCopy);
            return;
        }// end function

        private function showOrHideChangeJob() : void
        {
            var _loc_1:* = TaskModel.getInstance().curChangeJobTask();
            if (UserObj.getInstance().playerInfo.level >= Params.CHANGE_JOB_OPEN_LEVEL && _loc_1 != 0)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_CHANGE_JOB);
            }
            return;
        }// end function

        public function showOrHideCloudBuy(param1:Boolean) : void
        {
            if (param1)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_CLOUD_BUY);
                CloudBuyControl.getInstance().reqOpenCloudBuyInfo();
            }
            else
            {
                this.topActivateRemoveBtn(TopActivateName.TOP_ICON_CLOUD_BUY);
            }
            return;
        }// end function

        public function removeDeskTopBtn() : void
        {
            this.topActivateRemoveBtn(TopActivateName.TOP_ICON_LINK_TO_DESKTOP);
            return;
        }// end function

        private function removeTopBtn(param1:BaseButton) : void
        {
            return;
        }// end function

        public function openBigMapPanel() : void
        {
            if (!this.isCanOpenBigMap)
            {
                return;
            }
            if (!this._user)
            {
                this._user = RoleList.getInstance().player;
                this._user.addEvtListener(RoleEvent.UPDATE_DIRECT, this._userDirectUpdate);
                this._user.addEvtListener(RoleEvent.ARRIVE, this._userArrive);
            }
            if (!this._bigMapPanel)
            {
                this._bigMapPanel = new BigMapPanel();
                Global.popManager.addPop(this._bigMapPanel);
            }
            this._bigMapPanel.openOrClose();
            return;
        }// end function

        public function changePositionHandler(param1:ResChangePositionMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            var _loc_3:* = MagicBookRoleList.getInstance().getMagicBookRole(param1.personId);
            if (_loc_2)
            {
                _loc_2.move(param1.position.x, param1.position.y);
                if (_loc_3)
                {
                    _loc_3.moveTo(_loc_2);
                }
            }
            this.currentGameScene.roleMoveHandler();
            return;
        }// end function

        public function resflashMove(param1:ResFlashMoveMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.roleId);
            if (_loc_2)
            {
                _loc_2.move(param1.position.x, param1.position.y);
            }
            this.currentGameScene.roleMoveHandler();
            return;
        }// end function

        public function enterMapHandler(param1:ResEnterMapMessage) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapPreID);
            var _loc_3:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            var _loc_4:* = false;
            if (!_loc_2 || _loc_2.zones_type == 0 && _loc_3.zones_type != 0 || _loc_3.mapId == Params.CLIENT_ZONES_SKE_KING_ID || _loc_3.mapId == Params.CLIENT_ZONES_DRAGON_KING)
            {
                if (_loc_3.zones_type != 5)
                {
                    _loc_4 = true;
                }
            }
            if (!Params.hasEnterMap)
            {
                Params.hasEnterMap = true;
                ClickStream.add(ClickStreamId.ENTER_MAP);
            }
            else
            {
                if (MapObj.getInstance().mapPreID == Params.MAINLAND_MAP_ID && MapObj.getInstance().mapID == Params.UNDER_CITY_1_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_YongZheDaLu_to_DiXiaCheng);
                }
                if (MapObj.getInstance().mapPreID == Params.ICE_WIND_MAP_ID && MapObj.getInstance().mapID == Params.UNDER_CITY_2_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_BingFengGu_to_DiXiaCheng);
                }
            }
            if (_loc_3.zones_type == ZoneType.ZONES_XS)
            {
                ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_XueSeChengBao);
            }
            this.isChangingMap = false;
            UserObj.getInstance().line = param1.line;
            UserObj.getInstance().playerInfo.x = param1.pos.x;
            UserObj.getInstance().playerInfo.y = param1.pos.y;
            var _loc_5:* = RoleList.getInstance().player;
            if (RoleList.getInstance().player)
            {
                _loc_5.updateAct();
            }
            if (this._bigMapPanel)
            {
                this._bigMapPanel.close();
            }
            this.updateWorldMapByMapId(MapObj.getInstance().mapID);
            SoundControl.getInstance().playBGM(_loc_3.q_music);
            AutoFightController.getInstance().closeAutoFight();
            if (_loc_3.mapZones > 0 && _loc_3.zones_type != ZoneType.ZONES_ANGEL && !ZonesControl.getInstance().inBossHome())
            {
                this.isCanOpenBigMap = false;
            }
            else
            {
                this.isCanOpenBigMap = true;
            }
            if (_loc_3.zones_type == ZoneType.ZONES_XS)
            {
                if (this._currentGameScene)
                {
                    this._currentGameScene.finalize();
                    this._currentGameScene = null;
                }
                this._currentGameScene = new ScarletHoldGameScene();
                AutoFightManager.getInstance().fightLogic.nopatrol = true;
                Global.usePointSeek = false;
            }
            else if (_loc_3.zones_type == ZoneType.ZONES_COUNTRY)
            {
                if (this._currentGameScene)
                {
                    this._currentGameScene.finalize();
                    this._currentGameScene = null;
                }
                this._currentGameScene = new CountryGameScene();
            }
            else if (_loc_3.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                if (this._currentGameScene)
                {
                    this._currentGameScene.finalize();
                    this._currentGameScene = null;
                }
                this._currentGameScene = new ZonesRedFortressGameScene();
            }
            else
            {
                if (this._currentGameScene)
                {
                    if (this._currentGameScene is ZonesRedFortressGameScene)
                    {
                        this._currentGameScene.finalize();
                        ZonesRedFortressControl.getInstance().resetPlayerInfo();
                        this._currentGameScene = null;
                    }
                    if (this._currentGameScene is ScarletHoldGameScene)
                    {
                        this._currentGameScene.finalize();
                        ScarletHoldControl.getInstance().reset();
                        ScarletHoldControl.getInstance().closeNpc();
                        AutoFightManager.getInstance().fightLogic.nopatrol = false;
                        this._currentGameScene = null;
                        Global.usePointSeek = true;
                    }
                    if (this._currentGameScene is CountryGameScene)
                    {
                        this._currentGameScene.finalize();
                        CountryControl.getInstance().reset();
                        this._currentGameScene = null;
                    }
                }
                if (!this._currentGameScene)
                {
                    this._currentGameScene = new GameScene();
                }
            }
            this._currentGameScene.changeMap();
            Global.sceneManager.enterScene(this._currentGameScene);
            if (_loc_3.zones_type == ZoneType.ZONES_ANGEL)
            {
            }
            if (this._loadingComponent && _loc_4)
            {
                this._loadingComponent.endShow();
            }
            else if (this._loadingComponent)
            {
                this._loadingComponent.close();
            }
            FightControl.getInstance().currentGameScene = this._currentGameScene;
            this._protocol.reqLines();
            Platform.instance.onEnterMap();
            return;
        }// end function

        public function changeMapHandler(param1:ResChangeMapMessage) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = null;
            this.killDropRoundGoods();
            Log.log("changeMapHandler==================================");
            this.isChangingMap = true;
            Player(RoleList.getInstance().player).stopPathWithoutClearJumper();
            MapObj.getInstance().mapPreID = MapObj.getInstance().mapID;
            MapObj.getInstance().changeMapReason = param1.type;
            UserObj.getInstance().playerInfo.mapId = param1.mapId;
            var _loc_2:* = MapCfgObj.getInstance().getMap(param1.mapId);
            var _loc_3:* = Params.MAP_PATH + _loc_2.url + ".bin";
            var _loc_4:* = Params.MAP_MAPRES_PATH + "ground/" + _loc_2.url + "/small.jpg";
            AutoFightController.getInstance().closeAutoFight();
            if (MapObj.getInstance().mapID != param1.mapId)
            {
                _loc_5 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapPreID);
                _loc_6 = false;
                if (!_loc_5 || _loc_5.zones_type == 0 && _loc_2.zones_type != 0 || _loc_2.mapId == Params.CLIENT_ZONES_SKE_KING_ID || _loc_2.mapId == Params.CLIENT_ZONES_DRAGON_KING)
                {
                    if (_loc_2.zones_type != 5)
                    {
                        this.showLoading(param1.mapId);
                        _loc_6 = true;
                    }
                }
                MapObj.getInstance().mapID = param1.mapId;
                if (!this.isListeningLoadingBoxClose)
                {
                    this.isListeningLoadingBoxClose = true;
                    Global.popManager.loadingBox.addEventListener(BoxEvent.SHOW_HIDE, this.onLoadingBoxShowOrHide);
                }
                if (_loc_6)
                {
                    _loc_7 = this.showZoneLoading();
                    VResManager.loadGroup(["res/enterzoneeffect.swf", _loc_3, _loc_4], null, null, null, _loc_7, this.loadMapComplete, null, true, false, true, 0, FrameworkGlobal.LOAD_PRELOAD_UI);
                }
                else
                {
                    _loc_7 = Global.popManager.showLoadingBox(true, 3, 1);
                    VResManager.loadGroup([_loc_3, _loc_4], null, null, null, _loc_7, this.loadMapComplete, null, true, false, true, 0, FrameworkGlobal.LOAD_PRELOAD_UI);
                }
                VMCGPUManager.clearRes();
                VMCManager.clearRes();
                ObjectPool.clearAll();
                ObjectPool.garbageCollect();
            }
            else
            {
                this.loadMapComplete();
            }
            return;
        }// end function

        private function loadMapComplete() : void
        {
            Global.popManager.closeLoadingBox();
            this._protocol.loadFinishForChangeMap();
            return;
        }// end function

        private function onLoadingBoxShowOrHide(event:BoxEvent) : void
        {
            var _loc_2:* = null;
            if (event.showOrHide == BaseBox.HIDE)
            {
                if (MapObj.getInstance().mapPreID == Params.MAINLAND_MAP_ID && MapObj.getInstance().mapID == Params.UNDER_CITY_1_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_LOADING_YongZheDaLu_to_DiXiaCheng);
                }
                if (MapObj.getInstance().mapPreID == Params.ICE_WIND_MAP_ID && MapObj.getInstance().mapID == Params.UNDER_CITY_2_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_LOADING_BingFengGu_to_DiXiaCheng);
                }
                _loc_2 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                if (_loc_2.zones_type == ZoneType.ZONES_XS)
                {
                    ClickStream.add(ClickStreamId.FINISH_SWITCHMAP_LOADING_XueSeChengBao);
                }
            }
            return;
        }// end function

        public function findPath(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = 0, param6:Boolean = true) : Array
        {
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = 0;
            var _loc_27:* = 0;
            if (this.isChangingMap)
            {
                return null;
            }
            var _loc_7:* = MapObj.getInstance().tilesba;
            if (!MapObj.getInstance().tilesba)
            {
                return null;
            }
            var _loc_8:* = MapUtils.coo2Tile(param1);
            var _loc_9:* = MapUtils.coo2Tile(param2);
            var _loc_10:* = MapUtils.coo2Tile(param3);
            var _loc_11:* = MapUtils.coo2Tile(param4);
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                if (_loc_10 == 188 && _loc_11 == 227)
                {
                    _loc_10 = 187;
                    _loc_11 = 230;
                }
                else if (_loc_10 == 307 && _loc_11 == 168)
                {
                    _loc_10 = 306;
                    _loc_11 = 171;
                }
                else if (_loc_10 == 411 && _loc_11 == 117)
                {
                    _loc_10 = 407;
                    _loc_11 = 119;
                }
            }
            if (MapObj.getInstance().isObstacle(_loc_10, _loc_11))
            {
                _loc_13 = this.getNearRoadGrid(_loc_8, _loc_9, _loc_10, _loc_11);
                if (_loc_13)
                {
                    _loc_10 = _loc_13.x;
                    _loc_11 = _loc_13.y;
                }
                else
                {
                    return null;
                }
            }
            if (Global.usePointSeek)
            {
                _loc_14 = ToolKit.distance(_loc_8, _loc_9, _loc_10, _loc_11);
                if (_loc_14 > 100)
                {
                    _loc_12 = PointSeeker.path(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, param5);
                    if (_loc_12 == null || _loc_12.length == 0)
                    {
                        _loc_12 = MapUtils.findPath(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, param5);
                    }
                }
                else
                {
                    _loc_12 = MapUtils.findPath(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, param5);
                    if (_loc_12 == null || _loc_12.length == 0)
                    {
                        _loc_12 = PointSeeker.path(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, param5);
                    }
                }
                if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
                {
                    _loc_16 = 0;
                    _loc_19 = 0;
                    while (_loc_19 < (_loc_12.length - 1))
                    {
                        
                        _loc_15 = Math.max(Math.abs(_loc_12[_loc_19][0] - _loc_12[(_loc_19 + 1)][0]), Math.abs(_loc_12[_loc_19][1] - _loc_12[(_loc_19 + 1)][1]));
                        _loc_17 = _loc_12[_loc_19][0];
                        _loc_18 = _loc_12[_loc_19][1];
                        _loc_16 = 0;
                        while (_loc_16 < _loc_15)
                        {
                            
                            _loc_17 = _loc_17 == _loc_12[(_loc_19 + 1)][0] ? (_loc_12[(_loc_19 + 1)][0]) : (_loc_12[_loc_19][0] > _loc_12[(_loc_19 + 1)][0] ? ((_loc_17 - 1)) : ((_loc_17 + 1)));
                            _loc_18 = _loc_18 == _loc_12[(_loc_19 + 1)][1] ? (_loc_12[(_loc_19 + 1)][1]) : (_loc_12[_loc_19][1] > _loc_12[(_loc_19 + 1)][1] ? ((_loc_18 - 1)) : ((_loc_18 + 1)));
                            if (MapObj.getInstance().isObstacle(_loc_17, _loc_18))
                            {
                                return null;
                            }
                            _loc_16++;
                        }
                        _loc_19++;
                    }
                }
            }
            else
            {
                _loc_12 = MapUtils.findPath(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, param5);
            }
            if (_loc_12)
            {
                if (_loc_12.length > 1)
                {
                    _loc_20 = _loc_12.length - 1;
                    _loc_22 = [];
                    _loc_24 = [];
                    _loc_25 = new Vector.<int>;
                    _loc_26 = 0;
                    coordFrom.x = _loc_8;
                    coordFrom.y = _loc_9;
                    coordTo.x = _loc_10;
                    coordTo.y = _loc_11;
                    _loc_27 = 0;
                    while (_loc_27 < _loc_20)
                    {
                        
                        _loc_21 = MapUtils.countTileDirection(_loc_12[_loc_27], _loc_12[(_loc_27 + 1)]);
                        _loc_22.push(_loc_21);
                        _loc_24.push(MapUtils.tile2Coo(_loc_12[_loc_27]));
                        _loc_27 = _loc_27 + 1;
                    }
                    _loc_27 = 0;
                    while (_loc_27 < _loc_20)
                    {
                        
                        _loc_21 = _loc_22[_loc_27];
                        _loc_23 = MapUtils.countDistance(_loc_12[_loc_27], _loc_12[(_loc_27 + 1)]);
                        _loc_25.push(_loc_21 << 5 | _loc_23);
                        _loc_26 = _loc_26 + _loc_23;
                        _loc_27 = _loc_27 + 1;
                    }
                    coordArr = _loc_12.slice(_loc_27);
                    _loc_24.shift();
                    _loc_24.push(MapUtils.tile2Coo(_loc_12[_loc_20]));
                    if (!this.isClientMove)
                    {
                        this.running(param1, param2, _loc_25);
                    }
                    this.bigMapUserFindPath(_loc_24.concat());
                    return [_loc_24, _loc_22];
                }
            }
            return null;
        }// end function

        public function cutePetFindPath(param1:Number, param2:Number, param3:Array) : Array
        {
            var _loc_4:* = [];
            var _loc_5:* = 0;
            var _loc_6:* = param3.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_4.push([param3[_loc_5][0], param3[_loc_5][1]]);
                _loc_5++;
            }
            var _loc_7:* = _loc_4[(param3.length - 1)];
            var _loc_8:* = MapUtils.coo2Tile(param1);
            var _loc_9:* = MapUtils.coo2Tile(param2);
            var _loc_10:* = MapUtils.coo2Tile(_loc_7[0]);
            var _loc_11:* = MapUtils.coo2Tile(_loc_7[1]);
            var _loc_12:* = this.getRandomNearRoadGrid(_loc_10, _loc_11, 3);
            if (this.getRandomNearRoadGrid(_loc_10, _loc_11, 3))
            {
                _loc_4[(param3.length - 1)] = MapUtils.tile2Coo([_loc_12.x, _loc_12.y]);
            }
            else
            {
                return null;
            }
            return _loc_4;
        }// end function

        public function getNearRoadGrid(param1:int, param2:int, param3:int, param4:int, param5:int = 8) : Point
        {
            var _loc_12:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_6:* = new Point(param1, param2);
            var _loc_7:* = new Point(param3, param4);
            var _loc_8:* = MapObj.getInstance().tilesba;
            var _loc_9:* = Point.distance(_loc_6, _loc_7);
            var _loc_10:* = 1 / _loc_9;
            var _loc_11:* = 1 / _loc_9;
            while (_loc_11 <= 1)
            {
                
                _loc_12 = Point.interpolate(_loc_6, _loc_7, _loc_11);
                _loc_12.x = int(_loc_12.x);
                _loc_12.y = int(_loc_12.y);
                if (MapObj.getInstance().isObstacle(_loc_12.x, _loc_12.y))
                {
                    _loc_11 = _loc_11 + _loc_10;
                    continue;
                }
                break;
            }
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = Math.abs(param3 - _loc_12.x);
            var _loc_16:* = Math.abs(param4 - _loc_12.y);
            if (_loc_15 < param5)
            {
                _loc_13 = _loc_15 - param5;
                _loc_15 = _loc_15 + param5;
            }
            if (_loc_16 < param5)
            {
                _loc_14 = _loc_16 - param5;
                _loc_16 = _loc_16 + param5;
            }
            var _loc_17:* = new Point(_loc_12.x, _loc_12.y);
            _loc_9 = int.MAX_VALUE;
            var _loc_24:* = _loc_14;
            while (_loc_24 < _loc_16)
            {
                
                _loc_25 = _loc_13;
                while (_loc_25 < _loc_15)
                {
                    
                    _loc_18 = _loc_12.x < param3 ? (param3 - _loc_25) : (param3 + _loc_25);
                    _loc_19 = _loc_12.y < param4 ? (param4 - _loc_24) : (param4 + _loc_24);
                    if (!MapObj.getInstance().isObstacle(_loc_18, _loc_19))
                    {
                        _loc_20 = _loc_18 - param1;
                        _loc_21 = _loc_19 - param2;
                        _loc_22 = _loc_18 - param3;
                        _loc_23 = _loc_19 - param4;
                        _loc_26 = Math.abs(_loc_22) + Math.abs(_loc_23) + Math.abs(_loc_20) + Math.abs(_loc_21);
                        if (_loc_26 < _loc_9)
                        {
                            _loc_17.x = _loc_18;
                            _loc_17.y = _loc_19;
                            _loc_9 = _loc_26;
                        }
                    }
                    _loc_25++;
                }
                _loc_24++;
            }
            return _loc_17;
        }// end function

        public function getRandomNearRoadGrid(param1:int, param2:int, param3:int = 2) : Point
        {
            var _loc_7:* = 0;
            var _loc_4:* = [];
            var _loc_5:* = param3;
            var _loc_6:* = param3;
            while (_loc_6 >= -param3)
            {
                
                while (_loc_5 >= -param3)
                {
                    
                    if (!MapObj.getInstance().isObstacle(param1 + _loc_5, param2 + _loc_6))
                    {
                        _loc_4.push([param1 + _loc_5, param2 + _loc_6]);
                    }
                    _loc_5 = _loc_5 - 1;
                }
                _loc_6 = _loc_6 - 1;
            }
            if (_loc_4.length > 0)
            {
                _loc_7 = Math.floor(Math.random() * _loc_4.length);
                return new Point(_loc_4[_loc_7][0], _loc_4[_loc_7][1]);
            }
            return null;
        }// end function

        public function showCount(param1:int) : void
        {
            if (this._minimap)
            {
                this._minimap.setMailCount(param1);
            }
            return;
        }// end function

        public function running(param1:Number, param2:Number, param3:Vector.<int>) : void
        {
            this._protocol.running(param1, param2, param3);
            return;
        }// end function

        public function isAlpha(param1:Number, param2:Number) : Boolean
        {
            return MapObj.getInstance().isAlpha(param1, param2);
        }// end function

        public function stopPath(param1:ISimpleRole) : void
        {
            this._protocol.stopPath(param1);
            return;
        }// end function

        public function quitToGame() : void
        {
            this._protocol.quitToGame();
            return;
        }// end function

        public function roundEffect(param1:ResRoundEffectMessage) : void
        {
            this._roundEffect(param1.Effect);
            return;
        }// end function

        private function _roundEffects(param1:Vector.<EffectInfo>) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < length)
            {
                
                this._roundEffect(param1[_loc_2], true);
                _loc_2++;
            }
            return;
        }// end function

        private function _roundEffect(param1:EffectInfo, param2:Boolean = false) : void
        {
            FightControl.getInstance().showFireWallSkill(param1, true);
            return;
        }// end function

        public function roundEffectDisappear(param1:ResRoundEffectDisappearMessage) : void
        {
            this._roundEffectDisappear(param1.effectid);
            return;
        }// end function

        private function _roundEffectDisappear(param1:Vector.<long>) : void
        {
            FightControl.getInstance().removeFireWallSkill(param1);
            return;
        }// end function

        public function roundObjectsHandler(param1:ResRoundObjectsMessage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1.playerIds.length > 0)
            {
                this.removeRolesByPersonIDs(param1.playerIds);
            }
            if (param1.player.length > 0)
            {
                for each (_loc_4 in param1.player)
                {
                    
                    _loc_2 = new PlayerInfo();
                    _loc_2.playerInfo = _loc_4;
                    this.addRoleByInfo(_loc_2);
                    if (_loc_4.positions && _loc_4.positions.length > 0)
                    {
                        this._currentGameScene.roleRunPositions(_loc_4.personId, null, _loc_4.positions);
                    }
                }
            }
            if (param1.monstersIds.length > 0)
            {
                this.removeRolesByPersonIDs(param1.monstersIds);
            }
            if (param1.monster.length > 0)
            {
                for each (_loc_5 in param1.monster)
                {
                    
                    this.addMonsterByCSInfo(_loc_5);
                }
            }
            if (param1.npcid.length > 0)
            {
                this.removeNpcsByNpcIDs(param1.npcid);
                this._currentGameScene.removeNPCSound(param1.npcid);
            }
            if (param1.npcs.length > 0)
            {
                this._currentGameScene.addNpcsByCSInfo(param1.npcs);
            }
            if (param1.summonpetIds.length > 0)
            {
                this.removeRolesByPersonIDs(param1.summonpetIds);
            }
            if (param1.summonpets.length > 0)
            {
                for each (_loc_6 in param1.summonpets)
                {
                    
                    this.addSummonPetByCSInfo(_loc_6);
                }
            }
            if (param1.goodsIds.length > 0)
            {
                this._currentGameScene.dropRoundGoodsDisappear(param1.goodsIds);
            }
            if (param1.goods.length > 0)
            {
                this._currentGameScene.showDropForLogin(param1.goods);
            }
            if (param1.Effect.length > 0)
            {
                this._roundEffects(param1.Effect);
            }
            if (param1.effectid.length > 0)
            {
                this._roundEffectDisappear(param1.effectid);
            }
            return;
        }// end function

        public function roundObjectDisappearHandler(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            if (this._currentGameScene)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._currentGameScene.removeRoleByPersonID(_loc_2);
                }
            }
            return;
        }// end function

        public function removeRolesByPersonIDs(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            if (this._currentGameScene)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._currentGameScene.removeRoleByPersonID(_loc_2);
                }
            }
            return;
        }// end function

        public function removeNpcsByNpcIDs(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            if (this._currentGameScene)
            {
                for each (_loc_2 in param1)
                {
                    
                    this._currentGameScene.removeNpcByPersonID(_loc_2);
                }
            }
            return;
        }// end function

        public function removeNpcByNpcID(param1:long) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeNpcByPersonID(param1);
            }
            return;
        }// end function

        public function removeRoleByPersonId(param1:long) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeRoleByPersonID(param1);
            }
            return;
        }// end function

        public function removeRoleFromMap(param1:IRole) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeRole(param1);
            }
            return;
        }// end function

        public function removeRoleFromRoles(param1:IRole) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeRoleFromRoles(param1);
            }
            return;
        }// end function

        public function addRoleByInfo(param1:RoleInfo) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addRoleByInfo(param1);
            }
            return;
        }// end function

        public function addClientRoleByInfo(param1:RoleInfo) : void
        {
            this._currentGameScene.addClientRoleByInfo(param1);
            return;
        }// end function

        public function addCutePet(param1:CutePetInfo) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addCutePetByInfo(param1);
            }
            return;
        }// end function

        public function addPlayerCutePet(param1:CutePetInfo) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addPlayerCutePetByInfo(param1);
            }
            return;
        }// end function

        public function removeCutePetById(param1:long) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeCutePetByParentId(param1);
            }
            return;
        }// end function

        public function removeCutePet(param1:ICutePet) : void
        {
            CutePetList.getInstance().removeCutePet(param1);
            if (this._currentGameScene)
            {
                this._currentGameScene.removeElement(param1);
            }
            return;
        }// end function

        public function addMagicBookRole(param1:MagicBookInfo) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addMagicBookByInfo(param1);
            }
            return;
        }// end function

        public function removeMagicBookRole(param1:long) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.removeMagicBookByParentId(param1);
            }
            return;
        }// end function

        public function addSpeciaRole(param1:IRoleView) : void
        {
            this._currentGameScene.addSpeciaRole(param1);
            return;
        }// end function

        public function addCountryDisplay(param1:DisplayObject) : void
        {
            this._currentGameScene.gameLayer.addChild(param1);
            return;
        }// end function

        public function roundPlayerShowHandler(param1:ResRoundPlayerMessage) : void
        {
            var _loc_2:* = new PlayerInfo();
            _loc_2.playerInfo = param1.player;
            this.addRoleByInfo(_loc_2);
            if (param1.player.positions && param1.player.positions.length > 0)
            {
                this._currentGameScene.roleRunPositions(param1.player.personId, null, param1.player.positions);
            }
            return;
        }// end function

        public function runPositionsHandler(param1:ResRunPositionsMessage) : void
        {
            if (this._currentGameScene)
            {
                if (UserObj.getInstance().playerInfo.isPlayer(param1.personId))
                {
                    return;
                }
                this._currentGameScene.roleRunPositions(param1.personId, param1.position, param1.positions);
            }
            return;
        }// end function

        public function playerRunEndHandler(param1:ResPlayerRunEndMessage) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.roleRunEnd(param1.personId, param1.position);
            }
            return;
        }// end function

        public function roleStopHandler(param1:long, param2:Position, param3:int) : void
        {
            var _loc_4:* = RoleList.getInstance().getRole(param1);
            if (RoleList.getInstance().getRole(param1) && _loc_4.info && _loc_4.info.mapId == param3)
            {
                _loc_4.stopByPosition(param2);
                if (_loc_4.isUser())
                {
                    this._currentGameScene.roleMoveHandler();
                }
            }
            return;
        }// end function

        public function setPositionHandler(param1:ResSetPositionMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info && _loc_2.info.mapId == param1.mapModelId)
            {
                _loc_2.stopByPosition(param1.position);
                if (_loc_2.isUser())
                {
                    this._currentGameScene.roleMoveHandler();
                }
            }
            return;
        }// end function

        public function setSpecialPositionHandler(param1:ResSetSpecialPositionMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(param1.skillID);
                if (_loc_3.q_skill_type == SpecialSkillID.CHONG_FENG_TYPE || _loc_3.q_skill_type == SpecialSkillID.DI_LIE_ZHAN)
                {
                    _loc_4 = ToolKit.distance(_loc_2._x, _loc_2._y, param1.position.x, param1.position.y);
                    if (_loc_4 > 0)
                    {
                        _loc_5 = _loc_4 / _loc_3.q_trajectory_speed;
                        if (UICfg.hideOtherPlayer)
                        {
                            _loc_2.flyByPosition(param1.position, _loc_5, this.stopPositionComplete, [_loc_2], false);
                        }
                        else
                        {
                            _loc_2.flyByPosition(param1.position, _loc_5, this.stopPositionComplete, [_loc_2], _loc_3.q_skill_type == SpecialSkillID.CHONG_FENG_TYPE);
                        }
                    }
                    else
                    {
                        _loc_2.play();
                    }
                }
                else if (_loc_3.q_skill_type == SpecialSkillID.LEI)
                {
                    _loc_2.stopPath();
                    if (_loc_2.isUser())
                    {
                        Player.actState = State.DRAG;
                    }
                    _loc_2.move2(param1.position.x, param1.position.y, 0.5, this.dragComplete);
                }
            }
            return;
        }// end function

        private function dragComplete() : void
        {
            Player.state = State.STAND;
            return;
        }// end function

        private function stopPositionComplete(param1:IRole) : void
        {
            param1.play();
            this._currentGameScene.roleMoveHandler();
            return;
        }// end function

        public function addSummonPetByCSInfo(param1:SummonPetInfo) : void
        {
            var _loc_2:* = new MonsterInfo();
            _loc_2.summonPetInfo = param1;
            this.addRoleByInfo(_loc_2);
            if (UserObj.getInstance().playerInfo.personId.equal(param1.ownerId))
            {
                UserObj.getInstance().playerInfo.addSummonPetInfo(_loc_2);
                if (!this._summonPetPanel)
                {
                    this._summonPetPanel = new SummonPetPanel();
                    this._summonPetPanel.move(20, 140);
                }
                this._summonPetPanel.info = _loc_2;
            }
            return;
        }// end function

        public function summonPetDie(param1:SummonPetDetailInfo) : void
        {
            this.removeRoleByPersonId(param1.petId);
            if (UserObj.getInstance().playerInfo.removeSummonPetInfo(param1.petId))
            {
                if (this._summonPetPanel)
                {
                    this._summonPetPanel.reset();
                    Global.mainUIManager.removeUI(this._summonPetPanel);
                }
            }
            return;
        }// end function

        public function summonpetPositionsHandler(param1:ResSummonPetRunPositionsMessage) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.roleRunPositions(param1.petId, param1.position, param1.positions);
            }
            return;
        }// end function

        public function addMonsterByCSInfo(param1:CSMonsterInfo) : void
        {
            var _loc_2:* = new MonsterInfo();
            _loc_2.monsterInfo = param1;
            this.addRoleByInfo(_loc_2);
            return;
        }// end function

        public function monsterRunPositionsHandler(param1:ResMonsterRunPositionsMessage) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.roleRunPositions(param1.monsterId, param1.position, param1.positions);
            }
            return;
        }// end function

        public function monsterStopHandler(param1:ResMonsterStopMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.monsterId);
            if (_loc_2)
            {
                _loc_2.stopByPosition(param1.position);
            }
            return;
        }// end function

        public function addClientMonsterByInfo(param1:ClientMonsterInfo) : void
        {
            this.addClientRoleByInfo(param1);
            return;
        }// end function

        public function roundNpcShowHandler(param1:ResRoundNpcMessage) : void
        {
            this._currentGameScene.addNpcByCSInfo(param1.npc);
            return;
        }// end function

        public function canSkyCityIn(param1:int = 0) : Boolean
        {
            if (param1 != Params.SKY_CITY_MAP)
            {
                return true;
            }
            var _loc_2:* = EquipsObj.getInstance().getEquipBy(Params.WING);
            if (!long.isZero(_loc_2.itemId))
            {
                return true;
            }
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12095"));
            return false;
        }// end function

        public function changeMapByMove(param1:uint) : void
        {
            this._protocol.changeMapByTransfer(param1);
            return;
        }// end function

        private function checkOutBossHomeByPos(param1:uint, param2:int, param3:int, param4:long, param5:int, param6:int) : Boolean
        {
            if (ZonesControl.getInstance().inBossHome() && param1 == Params.BOSS_HOME_CITY_MAP)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", BossHomeConsts.LANG_VER));
                return true;
            }
            if (param1 == Params.BOSS_HOME_CITY_MAP)
            {
                ZonesControl.getInstance().openBossHome();
                return true;
            }
            if (!ZonesControl.getInstance().inBossHome())
            {
                return false;
            }
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10001", "lang_bosshome"), null, [param1, param2, param3, param4, param5, param6, false], this.changeMapByPos);
            return true;
        }// end function

        private function checkOutBossHome(param1:uint, param2:int = 0) : Boolean
        {
            if (ZonesControl.getInstance().inBossHome() && param1 == Params.BOSS_HOME_CITY_MAP)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", BossHomeConsts.LANG_VER));
                return true;
            }
            if (param1 == Params.BOSS_HOME_CITY_MAP)
            {
                ZonesControl.getInstance().openBossHome();
                return true;
            }
            if (!ZonesControl.getInstance().inBossHome())
            {
                return false;
            }
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("10001", "lang_bosshome"), null, [param1, param2], this.outBossHome);
            return true;
        }// end function

        private function outBossHome(param1:int, param2:int) : void
        {
            this.goldMapTrans(param1, param2, false);
            return;
        }// end function

        public function goldMapTrans(param1:uint, param2:int = 0, param3:Boolean = true) : void
        {
            var _loc_6:* = null;
            var _loc_4:* = false;
            var _loc_5:* = this.canSkyCityIn(param1);
            if (!this.canSkyCityIn(param1))
            {
                return;
            }
            if (param3)
            {
                if (this.checkOutBossHome(param1, param2))
                {
                    return;
                }
                if (param1 == Params.BOSS_HOME_CITY_MAP)
                {
                    ZonesControl.getInstance().openBossHome();
                }
            }
            if (VipModel.getInstance().info.level > 0)
            {
                _loc_4 = true;
            }
            else
            {
                _loc_6 = MapCfgObj.getInstance().getMap(param1);
                if (_loc_6.mapTransforCost <= UserObj.getInstance().playerInfo.money)
                {
                    _loc_4 = true;
                }
                else
                {
                    _loc_4 = false;
                    FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                }
            }
            if (_loc_4)
            {
                this._protocol.changeMapByGold(param1, param2);
                if (AutoFightManager.getInstance().isAutoFighting())
                {
                    AutoFightController.getInstance().closeAutoFight(true);
                }
            }
            return;
        }// end function

        public function changeMapByPos(param1:uint, param2:int, param3:int, param4:long, param5:int, param6:int = 0, param7:Boolean = true) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_8:* = this.canSkyCityIn(param1);
            if (!this.canSkyCityIn(param1))
            {
                return;
            }
            if (param7)
            {
                if (this.checkOutBossHomeByPos(param1, param2, param3, param4, param5, param6))
                {
                    return;
                }
                if (param1 == Params.BOSS_HOME_CITY_MAP)
                {
                    ZonesControl.getInstance().openBossHome();
                }
            }
            if (param1 == MapObj.getInstance().mapID)
            {
                if (MapObj.getInstance().isObstacle(param2, param3))
                {
                    _loc_9 = MapUtils.coo2Tile(RoleList.getInstance().player._x);
                    _loc_10 = MapUtils.coo2Tile(RoleList.getInstance().player._y);
                    _loc_11 = this.getNearRoadGrid(_loc_9, _loc_10, param2, param3);
                    if (_loc_11)
                    {
                        param2 = _loc_11.x;
                        param3 = _loc_11.y;
                    }
                }
            }
            this._protocol.changeMapByPos(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        public function wingChangeHandler(param1:ResWingChangeMessage) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.isZonesMorph)
                {
                    if (UICfg.OTHER_NORMAL_MODEL)
                    {
                        _loc_2.setOldItemCfg(param1.weaponId, param1.pos);
                        return;
                    }
                    if (_loc_2.info.personId.equal(UserObj.getInstance().playerInfo.personId))
                    {
                        if (param1.weaponId)
                        {
                            _loc_3 = ItemCfgObj.getInstance().getItemCfg(param1.weaponId);
                        }
                    }
                    return;
                }
                if (param1.weaponId > 0)
                {
                    if (param1.pos == Params.WING)
                    {
                        _loc_3 = ItemCfgObj.getInstance().getItemCfg(param1.weaponId);
                        if (_loc_3)
                        {
                            _loc_2.info.wingInfo = _loc_3;
                            _loc_2.info.wingInfo.streng = param1.weaponStreng;
                        }
                    }
                }
                else
                {
                    _loc_2.info.wingInfo = null;
                }
                _loc_2.updateAct();
            }
            return;
        }// end function

        public function weaponChangeHandler(param1:ResWeaponChangeMessage) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.isZonesMorph)
                {
                    return;
                }
                if (UICfg.OTHER_NORMAL_MODEL)
                {
                    _loc_2.setOldItemCfg(param1.weaponId, param1.pos);
                    return;
                }
                if (param1.weaponId > 0)
                {
                    _loc_3 = ItemCfgObj.getInstance().getItemCfg(param1.weaponId);
                    if (_loc_3)
                    {
                        if (param1.pos == Params.RIGHT_WEAPON)
                        {
                            _loc_2.info.weapon_other = _loc_3;
                            _loc_2.info.weapon_other.streng = param1.weaponStreng;
                        }
                        else
                        {
                            _loc_2.info.weapon = _loc_3;
                            _loc_2.info.weapon.streng = param1.weaponStreng;
                        }
                    }
                }
                else if (param1.pos == Params.RIGHT_WEAPON)
                {
                    _loc_2.info.weapon_other = null;
                }
                else
                {
                    _loc_2.info.weapon = null;
                }
                _loc_2.updateAct();
            }
            return;
        }// end function

        public function armorChangeHandler(param1:ResArmorChangeMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.isZonesMorph)
                {
                    return;
                }
                if (UICfg.OTHER_NORMAL_MODEL)
                {
                    _loc_2.setOldItemCfg(param1.armorId, Params.BODY);
                    return;
                }
                if (param1.armorId > 0)
                {
                    _loc_2.info.armor = ItemCfgObj.getInstance().getItemCfg(param1.armorId);
                    _loc_2.info.armor.streng = param1.armorStrength;
                }
                else
                {
                    _loc_2.info.armor = null;
                }
                _loc_2.loadRoleRes();
            }
            return;
        }// end function

        public function roundStrengthLevelHandler(param1:ResStrengthLevelMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.isZonesMorph)
            {
                return;
            }
            if (UICfg.OTHER_NORMAL_MODEL)
            {
                return;
            }
            _loc_2.info.allStrength = param1.strengthLevel;
            _loc_2.checkStrengthAll();
            return;
        }// end function

        public function cutePetChangeHandler(param1:ResEquipPetMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.isZonesMorph)
                {
                    return;
                }
                _loc_2.info.equipPetId = param1.equipPetId;
                _loc_2.resetCutePet();
            }
            return;
        }// end function

        public function addBlood(param1) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addBlood(param1);
            }
            return;
        }// end function

        public function addChildToBottomLayer(param1:DisplayObject) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.bottomLayer.addChild(param1);
            }
            return;
        }// end function

        public function showBossReliveItem(param1:ResMapBossInfoMessage) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.showBossReliveItem(param1);
            }
            return;
        }// end function

        public function dropRoundGoodsDisappear(param1:ResRoundGoodsDisappearMessage) : void
        {
            this._currentGameScene.dropRoundGoodsDisappear(param1.goodsIds);
            return;
        }// end function

        public function dropRoundGoods(param1:ResRoundGoodsMessage) : void
        {
            this._currentGameScene.dropRoundGoods(param1.goods);
            return;
        }// end function

        public function killDropRoundGoods() : void
        {
            this._currentGameScene.killDropRoundGoods();
            return;
        }// end function

        public function dropTakeUpSuccess(param1:ResTakeUpSuccessMessage) : void
        {
            var _loc_2:* = param1.goodModelId;
            this._currentGameScene.dropTakeUpSuccess(param1.goodsId);
            if (_loc_2 == 700034 || _loc_2 == 700035 || _loc_2 == 700036)
            {
                return;
            }
            var _loc_3:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_3.zones_type == ZoneType.ZONES_ISLAND)
            {
                IslandData.getInstance().checkIsElementHeart(_loc_2, param1.num);
            }
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_loc_2);
            if (ItemCfgObj.getInstance().getCfgBy(_loc_2) && _loc_4.q_type == ItemType.ELEMENT_HEART)
            {
            }
            else
            {
                ItemGetAnim.doFlyGetItemToBack(_loc_2);
            }
            return;
        }// end function

        public function dropTakeUpGoods(param1:DropIcon) : void
        {
            var _loc_2:* = null;
            if (!param1.dropInfo)
            {
                return;
            }
            if (!this.isClientPick)
            {
                if (param1.dropInfo)
                {
                    _loc_2 = new Vector.<long>;
                    _loc_2.push(param1.dropInfo.dropGoodsId);
                    this.dropTakeUpMultGoods(_loc_2);
                }
            }
            else
            {
                this._currentGameScene.dropTakeUpSuccess(param1.dropInfo.dropGoodsId);
                if (param1.dropInfo.itemModelId == 700034 || param1.dropInfo.itemModelId == 700035 || param1.dropInfo.itemModelId == 700036)
                {
                    MapClientControl.getInstance().addMoney(param1.dropInfo.num);
                }
                else
                {
                    ItemGetAnim.doFlyGetItemToBack(param1.dropInfo.itemModelId);
                }
                _loc_2 = new Vector.<long>;
                _loc_2.push(param1.dropInfo.dropGoodsId);
                this._currentGameScene.dropRoundGoodsDisappear(_loc_2);
            }
            return;
        }// end function

        private function dropTakeUpMultGoods(param1:Vector.<long>) : void
        {
            this._protocol.takeupDropGood(param1);
            return;
        }// end function

        public function getCurDropList() : Vector.<DropIcon>
        {
            if (!this._currentGameScene)
            {
                return null;
            }
            return this._currentGameScene.dropGoods;
        }// end function

        public function jugeElementIsPick() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (ElementHeartData.getInstance().isFull())
            {
                return false;
            }
            var _loc_1:* = MapControl.getInstance().getCurDropList();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = PropUtil.createItemByCfg(_loc_2.dropInfo.itemModelId);
                if (_loc_3 && PropUtil.isElementHeart(_loc_3.q_type))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function checkEncoughPick(param1:DropIcon) : Boolean
        {
            if (!param1 || !param1.dropInfo)
            {
                return false;
            }
            var _loc_2:* = PropUtil.createItemByCfg(param1.dropInfo.itemModelId);
            if (_loc_2 && PropUtil.isElementHeart(_loc_2.q_type) && !ElementHeartData.getInstance().isFull())
            {
                return true;
            }
            if (_loc_2 && !PropUtil.isElementHeart(_loc_2.q_type) && !BackpackObj.getInstance().isFull())
            {
                return true;
            }
            return false;
        }// end function

        public function dropTakeUpGoodsWithLegalRange(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = RoleList.getInstance().player as Player;
            this.dropTakeUpGoodsWithRange(_loc_3.x, _loc_3.y, 0, param1, param2);
            return;
        }// end function

        public function dropTakeUpGoodsOutRange(param1:Number, param2:Number, param3:int = 0, param4:Array = null, param5:Boolean = false) : DropIcon
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            if (this._currentGameScene && this._currentGameScene.dropGoods)
            {
                _loc_6 = this._currentGameScene.dropGoods;
                _loc_9 = RoleList.getInstance().player as Player;
                if (!_loc_9.cutePet)
                {
                    _loc_10 = Params.DROP_PICK_SMALL_RANGE;
                }
                else
                {
                    _loc_10 = Params.DROP_PICK_BIG_RANGE;
                }
                _loc_11 = param1 - param3;
                _loc_12 = param1 + param3;
                _loc_13 = param2 - param3;
                _loc_14 = param2 + param3;
                _loc_15 = _loc_9.x - _loc_10;
                _loc_16 = _loc_9.x + _loc_10;
                _loc_17 = _loc_9.y - _loc_10;
                _loc_18 = _loc_9.y + _loc_10;
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_8 = _loc_7.dropInfo;
                    if (_loc_8.x >= _loc_15 && _loc_8.x <= _loc_16 && _loc_8.y >= _loc_17 && _loc_8.y <= _loc_18 && (_loc_8.x < _loc_11 || _loc_8.x > _loc_12 || _loc_8.y < _loc_13 || _loc_8.y > _loc_14) && this.checkCanTakeUpGoodByOwner(_loc_8, param5))
                    {
                        if (param4 && param4.indexOf(_loc_8.itemModelId) == -1)
                        {
                            continue;
                        }
                        if (!this.checkEncoughPick(_loc_7))
                        {
                            continue;
                        }
                        return _loc_7;
                    }
                }
            }
            return null;
        }// end function

        public function trans(param1:uint, param2:uint, param3:uint, param4:Boolean = true, param5:int = 0, param6:int = 0) : void
        {
            var _loc_7:* = null;
            if (RoleList.getInstance().player.alive())
            {
                if (param4 && UserObj.getInstance().canTrans() || param6)
                {
                    this.changeMapByPos(param1, param2, param3, new long(), param5, param6);
                }
                else
                {
                    _loc_7 = RoleList.getInstance().player;
                    _loc_7.pathByCoo(param2 * MapUtils.GRID_BORDER, param3 * MapUtils.GRID_BORDER, 1, param1);
                }
                ;
            }
            return;
        }// end function

        public function dropTakeUpGoodsWithRange(param1:Number, param2:Number, param3:int = 0, param4:int = 1, param5:Boolean = false, param6:Array = null, param7:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = false;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = null;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = 0;
            if (this._currentGameScene && this._currentGameScene.dropGoods)
            {
                _loc_8 = this._currentGameScene.dropGoods;
                _loc_11 = RoleList.getInstance().player as Player;
                if (!_loc_11.cutePet || _loc_11.cutePet.petType != 5)
                {
                    _loc_12 = Params.DROP_PICK_SMALL_RANGE;
                    _loc_13 = 1;
                }
                else
                {
                    _loc_12 = Params.DROP_PICK_BIG_RANGE;
                    _loc_13 = 2;
                }
                if (param3 == 0)
                {
                    param3 = _loc_12;
                }
                _loc_14 = false;
                _loc_17 = 0;
                _loc_18 = new Vector.<long>;
                if (_loc_13 == 2)
                {
                    _loc_19 = Math.max(param1 - param3, _loc_11.x - _loc_12);
                    _loc_20 = Math.max(param2 - param3, _loc_11.y - _loc_12);
                    _loc_21 = Math.min(param1 + param3, _loc_11.x + _loc_12);
                    _loc_22 = Math.min(param2 + param3, _loc_11.y + _loc_12);
                    _loc_23 = 0;
                    for each (_loc_9 in _loc_8)
                    {
                        
                        _loc_10 = _loc_9.dropInfo;
                        if (param6 && param6.indexOf(_loc_10.itemModelId) == -1)
                        {
                            continue;
                        }
                        if (!this.checkEncoughPick(_loc_9))
                        {
                            continue;
                        }
                        if (_loc_10.x >= _loc_19 && _loc_10.x <= _loc_21 && _loc_10.y >= _loc_20 && _loc_10.y <= _loc_22)
                        {
                            if (this.checkCanTakeUpGoodByOwner(_loc_10, param7))
                            {
                                _loc_18.push(_loc_10.dropGoodsId);
                                _loc_14 = true;
                                _loc_23++;
                                if (_loc_23 == param4 && param4 != 0)
                                {
                                    break;
                                }
                            }
                            continue;
                        }
                        if (param5)
                        {
                            _loc_17 = ToolKit.distance(_loc_10.x, _loc_10.y, _loc_11.x, _loc_11.y);
                            if ((_loc_16 == 0 || _loc_16 > _loc_17) && this.checkCanTakeUpGoodByOwner(_loc_10, param7))
                            {
                                _loc_16 = _loc_17;
                                _loc_15 = _loc_9;
                            }
                        }
                    }
                }
                else
                {
                    for each (_loc_9 in _loc_8)
                    {
                        
                        _loc_10 = _loc_9.dropInfo;
                        if (param6 && param6.indexOf(_loc_10.itemModelId) == -1)
                        {
                            continue;
                        }
                        _loc_17 = ToolKit.distance(_loc_10.x, _loc_10.y, _loc_11.x, _loc_11.y);
                        if (_loc_17 <= _loc_12)
                        {
                            _loc_18.push(_loc_10.dropGoodsId);
                            _loc_14 = true;
                            _loc_23++;
                            if (_loc_23 == param4 && param4 != 0)
                            {
                                break;
                            }
                            continue;
                        }
                        if (param5)
                        {
                            _loc_17 = ToolKit.distance(_loc_10.x, _loc_10.y, _loc_11.x, _loc_11.y);
                            if (_loc_16 == 0 || _loc_16 > _loc_17)
                            {
                                _loc_16 = _loc_17;
                                _loc_15 = _loc_9;
                            }
                        }
                    }
                }
                if (_loc_18 && _loc_18.length)
                {
                    this.dropTakeUpMultGoods(_loc_18);
                }
                if (!_loc_14 && param5 && _loc_15)
                {
                    _loc_15.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                }
            }
            return;
        }// end function

        public function checkCanTakeUpGoodByOwner(param1:DropGoodsInfo, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = null;
            if (param2 && param1.isNanOwner == 0)
            {
                return false;
            }
            if (param1.ownerId.length == 0)
            {
                return true;
            }
            for each (_loc_3 in param1.ownerId)
            {
                
                if (_loc_3.equal(UserObj.getInstance().playerInfo.personId))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function updateWorldMapByMapId(param1:int) : void
        {
            if (this._bigMapPanel)
            {
                this._bigMapPanel.updateMapView(param1);
            }
            return;
        }// end function

        public function teamMemberUpdate(param1:ResTeamClientRefreshMessage) : void
        {
            if (this._bigMapPanel)
            {
                this._bigMapPanel.teamMemberUpdate(param1);
            }
            return;
        }// end function

        public function teamMemberPosUpdate(param1:ResTeammateMoveToClientMessage) : void
        {
            if (this._bigMapPanel)
            {
                this._bigMapPanel.teamMemberPosUpdate(param1);
            }
            return;
        }// end function

        private function __userLevelUpdate(event:RoleEvent) : void
        {
            if (this._bigMapPanel && this._bigMapPanel.isOpen)
            {
                this._bigMapPanel.updateByLevel(this._userInfo.fightPower);
            }
            this._userInfo.maxExp = LevelExpCfgObj.getInstance().getExpByLevel(this._userInfo.job, this._userInfo.level);
            return;
        }// end function

        private function __updateunlocateTalent(event:RoleEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._userInfo.level <= 23 && this._userInfo.level > 0 && this._userInfo.unallocatedTalent > 0)
            {
                _loc_2 = RecommandTalentPlusObj.getInstance().getPlus(this._userInfo.job, this._userInfo.level);
                _loc_3 = RoleAddPointUtil.getAddPoint(_loc_2, this._userInfo.job);
                if (_loc_3 != null)
                {
                    PrimaryRoleControl.getInstance().addPoint(_loc_3.agile, _loc_3.vitality, _loc_3.intelligence, _loc_3.strength);
                }
            }
            if (this._userInfo.level > 30 && this._userInfo.unallocatedTalent > 25)
            {
                if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)) != 0 && !GuideConfigObj.getInstance().isRolePointActiveing)
                {
                    FunGuideControl.getInstance().addGuide(FunGuideControl.getInstance().TALENT);
                }
            }
            if (event.obj)
            {
                BackpackObj.getInstance().checkEquipForTalentUp();
            }
            return;
        }// end function

        private function __updateVipCopy(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            this.topActivateAddedBtn(TopActivateName.TOP_ICON_VIP_COPY);
            _loc_2 = 0;
            _loc_3 = 0;
            while (_loc_3 < this.copyIdArray.length)
            {
                
                _loc_2 = _loc_2 + ZonesModel.getInstance().getCopyLeftNum(this.copyIdArray[_loc_3]);
                _loc_3++;
            }
            this.topActivateSetCountText(TopActivateName.TOP_ICON_VIP_COPY, "" + _loc_2);
            return;
        }// end function

        public function showOrHideAdult(param1:ResPlayerNonageRegisterMessage) : void
        {
            if (param1.result == 1)
            {
                this.removeAdultIcon();
            }
            else
            {
                this.addAdultIcon();
            }
            return;
        }// end function

        public function removeAdultIcon() : void
        {
            if (this.adultBtn)
            {
                this.adultBtn.removeFromParent();
                this.adultBtn.removeEvtListener(MouseEvent.CLICK, this.openAdult);
                this.adultBtn = null;
            }
            return;
        }// end function

        public function addAdultIcon() : void
        {
            this.adultBtn = new BaseButton(ToolKit.getNew("iconAdult"));
            var _loc_1:* = FrameworkGlobal.stage.stageWidth / 2 - 360 - 30;
            this.adultBtn.x = 370;
            this.adultBtn.y = 10;
            this.adultBtn.addEvtListener(MouseEvent.CLICK, this.openAdult, false, true);
            Global.mainUIManager.addUI(this.adultBtn, null, GroupPanelType.GROUP_LEVEL1);
            return;
        }// end function

        private function openAdult(event:MouseEvent) : void
        {
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12096"), "", null, this.jumpAdult, null, 2, LanguageCfgObj.getInstance().getByIndex("12100"));
            return;
        }// end function

        private function jumpAdult() : void
        {
            if (Params.adulturl)
            {
                ToolKit.gotoWeb(Params.adulturl);
            }
            return;
        }// end function

        private function _userDirectUpdate(event:RoleEvent) : void
        {
            if (this._bigMapPanel && this._bigMapPanel.isOpen)
            {
                this._bigMapPanel.updateUserDir(this._user.direct);
            }
            return;
        }// end function

        private function _userArrive(event:RoleEvent) : void
        {
            if (this._bigMapPanel)
            {
                this._bigMapPanel.updateUserByPos(RoleView(this._user).x, RoleView(this._user).y, true);
            }
            return;
        }// end function

        private function bigMapUserFindPath(param1:Array) : void
        {
            if (this._bigMapPanel)
            {
                this._bigMapPanel.userFindPath(param1);
            }
            return;
        }// end function

        public function freshMinimap() : void
        {
            if (this._minimap)
            {
                this._minimap.freshInfo();
            }
            return;
        }// end function

        public function getPrayTimes() : int
        {
            if (this._bottomBar)
            {
                return this._bottomBar.getPrayTimes();
            }
            return 0;
        }// end function

        public function reqLines() : void
        {
            this._protocol.reqLines();
            return;
        }// end function

        public function selectLine(param1:int) : void
        {
            this._protocol.reqSelectLine(param1);
            return;
        }// end function

        public function showRechargeD(param1:String = null) : void
        {
            if (param1 == null)
            {
                param1 = LanguageCfgObj.getInstance().getByIndex("10930");
            }
            Global.popManager.cue(param1, "", null, this.showRecharge, null, 1, LanguageCfgObj.getInstance().getByIndex("12097"));
            return;
        }// end function

        public function showRecharge() : void
        {
            if (!FrameworkGlobal.rechargeFunction)
            {
                Global.popManager.cue(StringRes.getInstance().getMessage("sven_pay_forbidden"), "", null, null, null, 1, LanguageCfgObj.getInstance().getByIndex("11547"));
            }
            else
            {
                JSTools.openWindow(Params.officialRechargeWebSite);
            }
            return;
        }// end function

        public function showFreshManCard() : void
        {
            JSTools.openWindow(Params.getCardWebSite);
            return;
        }// end function

        public function moveScene(param1:int, param2:int) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.moveScene(param1, param2);
            }
            return;
        }// end function

        public function addFilterToMap(param1:Array) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addFilterToMap(param1);
            }
            return;
        }// end function

        public function setPlayerOperatable(param1:Boolean) : void
        {
            if (!param1)
            {
                Global.popManager.addBgMask(param1);
            }
            else
            {
                Global.popManager.removeBgMask();
            }
            PlayerControl.getInstance().setPlayerMainBoxEnable(param1);
            MapControl.getInstance().setMiniMapEnable(param1);
            return;
        }// end function

        public function addClientTransfer(param1:VMCView) : void
        {
            if (this._currentGameScene)
            {
                this._currentGameScene.addClientTransfer(param1);
            }
            return;
        }// end function

        public function setMiniMapEnable(param1:Boolean) : void
        {
            if (this._minimap)
            {
                var _loc_2:* = param1;
                this._minimap.mouseChildren = param1;
                this._minimap.mouseEnabled = _loc_2;
            }
            return;
        }// end function

        public function setBankTopIconState(param1:Boolean = false) : void
        {
            var _loc_2:* = this._topActivateIconsPanel.getTopActivateIcon(TopActivateName.TOP_ICON_BANK);
            _loc_2.setEffect(param1, TopActivateIcon.EFFECT_FIRST_CLICK);
            return;
        }// end function

        private function guideConfigComplete(event:GuideEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = false;
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().XSCB_ZONE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_SCARLET_HOLD);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().DEKARON_ZONE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_DEKARON);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BELIA_WORLD_ZONE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_BELIAL_WORLD);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BOSS_HOME)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_BOSS_HOME);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().DESKTOP_ACTIVE_TEAM)) == 0)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_LINK_TO_DESKTOP);
                this.topActivateBtnTips(TopActivateName.TOP_ICON_LINK_TO_DESKTOP, LanguageCfgObj.getInstance().getByIndex("10931"));
            }
            else
            {
                this.topActivateRemoveBtn(TopActivateName.TOP_ICON_LINK_TO_DESKTOP);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().CHANGE_JOB_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().BOSSGUILD_ACTIVE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_BOSS_GUILD);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().DAILY_TASK_ACTIVE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else if (TaskModel.getInstance().dailyTaskList && TaskModel.getInstance().dailyTaskList.length)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10932");
                this.topActivateBtnTips(TopActivateName.TOP_ICON_DAILY_TASK, _loc_3);
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_DAILY_TASK);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().COUNTRY_ACTIVE_TEAM)) == 0)
            {
                _loc_2 = true;
            }
            else
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_COUNTRY);
            }
            if (!_loc_2)
            {
                GuideConfigObj.getInstance().removeEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            }
            else
            {
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            }
            return;
        }// end function

        public function openOrCloseTopPanel(param1:Boolean = true) : void
        {
            this._topActivateIconsPanel.openOrClose(param1);
            return;
        }// end function

        public function bosshomeShowMonsterDie(param1:RoleInfo) : void
        {
            TweenLite.delayedCall(0.3, this.startBosshomeDrop, [param1]);
            return;
        }// end function

        private function startBosshomeDrop(param1:RoleInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = BossHomeCfgObj.getInstance().getAngelByModelId(param1.cfgId);
            if (_loc_2 >= 0)
            {
                _loc_3 = new Image();
                _loc_4 = "res/image/bosshome/icon.png";
                _loc_3.load(_loc_4);
                _loc_5 = this._currentGameScene.gameLayer.localToGlobal(new Point(param1.x, param1.y));
                _loc_3.move(_loc_5.x, _loc_5.y - 150);
                Global.popManager.addGuideDisplayObject(_loc_3);
                TweenLite.to(_loc_3, 1.5, {x:_loc_5.x - 100});
                TweenLite.to(_loc_3, 1.5, {y:_loc_5.y, ease:Bounce.easeOut, onComplete:this.flyBossHomeIcon, onCompleteParams:[_loc_3]});
            }
            return;
        }// end function

        public function bosshomeElastic(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = 0;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            if (this._bosshomeDic[event.target])
            {
                _loc_2 = this._bosshomeDic[event.target].icon;
                _loc_3 = this._bosshomeDic[event.target].targetY;
                _loc_4 = this._bosshomeDic[event.target].targetX;
                _loc_5 = this._bosshomeDic[event.target].orginY;
                _loc_6 = this._bosshomeDic[event.target].orginX;
                _loc_7 = this._bosshomeDic[event.target].time;
                _loc_8 = this._bosshomeDic[event.target].starttime;
                _loc_9 = this._bosshomeDic[event.target].speed;
                _loc_10 = this._bosshomeDic[event.target].g;
                _loc_11 = _loc_3 - _loc_2.y;
                _loc_12 = _loc_4 - _loc_2.x;
                if (Math.sqrt(_loc_12 * _loc_12 + _loc_11 * _loc_11) < 1)
                {
                    this._bosshomeDic[event.target].targetX = _loc_4 - 30 + 5 * (_loc_7 / 5) * (_loc_7 / 5);
                    this._bosshomeDic[event.target].starttime = getTimer();
                    _loc_13 = (getTimer() - _loc_8) * 0.001;
                    this._bosshomeDic[event.target].speed = (-(this._bosshomeDic[event.target].speed + _loc_13 * _loc_10)) * 0.9;
                    this._bosshomeDic[event.target].g = -this._bosshomeDic[event.target].g;
                    if (_loc_5 - _loc_3 > 1)
                    {
                        this._bosshomeDic[event.target].targetY = _loc_5;
                        if (_loc_7 >= 1)
                        {
                            event.target.removeEventListener(TimerEvent.TIMER, this.bosshomeElastic);
                            event.target.stop();
                            this.flyBossHomeIcon(_loc_2);
                        }
                    }
                    else if (Math.abs(_loc_3 - _loc_5) < 1)
                    {
                        _loc_7++;
                        this._bosshomeDic[event.target].time = _loc_7;
                        _loc_14 = 1;
                        _loc_14 = 0.25;
                        _loc_15 = 0;
                        while (_loc_15 < (_loc_7 - 1))
                        {
                            
                            _loc_14 = _loc_14 * 0.5;
                            _loc_15++;
                        }
                        _loc_14 = int(150 * _loc_14);
                        this._bosshomeDic[event.target].targetY = _loc_5 - _loc_14;
                    }
                    return;
                }
                if (Math.sqrt(_loc_12 * _loc_12 + _loc_11 * _loc_11) < 1)
                {
                    _loc_2.move(_loc_4, _loc_3);
                }
                else
                {
                    _loc_16 = _loc_12 * 0.1;
                    if (_loc_16 < 0)
                    {
                        _loc_16 = Math.min(-1, _loc_16);
                    }
                    else
                    {
                        _loc_16 = Math.max(1, _loc_16);
                    }
                    _loc_13 = (getTimer() - _loc_8) * 0.001;
                    _loc_17 = _loc_10 * _loc_13;
                    _loc_18 = _loc_5 + _loc_9 * _loc_13 + 0.5 * _loc_10 * _loc_13 * _loc_13;
                    _loc_19 = _loc_2.x + _loc_16;
                    _loc_2.move(_loc_19, _loc_18);
                }
            }
            return;
        }// end function

        public function flyBossHomeIcon(param1:Image) : void
        {
            var _loc_2:* = param1.localToGlobal(new Point(0, 0));
            Global.popManager.flyBossHomeIcon(_loc_2.x, _loc_2.y);
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        private function guideActive(event:GuideEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = String(event.data);
            if (_loc_2 == GuideConfigObj.getInstance().XSCB_ZONE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_SCARLET_HOLD, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().DEKARON_ZONE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_DEKARON, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().BELIA_WORLD_ZONE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_BELIAL_WORLD, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().BOSS_HOME)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_BOSS_HOME, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().CHANGE_JOB_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_CHANGE_JOB, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().DESKTOP_ACTIVE_TEAM)
            {
                if (WeiDuanType.NO_WEIDUAN == Params.wdType)
                {
                }
                else
                {
                    this.topActivateAddedBtn(TopActivateName.TOP_ICON_LINK_TO_DESKTOP, true);
                    this.topActivateBtnTips(TopActivateName.TOP_ICON_LINK_TO_DESKTOP, LanguageCfgObj.getInstance().getByIndex("10933"));
                }
            }
            if (_loc_2 == GuideConfigObj.getInstance().BOSSGUILD_ACTIVE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_BOSS_GUILD, true);
            }
            if (_loc_2 == GuideConfigObj.getInstance().DAILY_TASK_ACTIVE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_DAILY_TASK, true);
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10932");
                this.topActivateBtnTips(TopActivateName.TOP_ICON_DAILY_TASK, _loc_3);
            }
            if (_loc_2 == GuideConfigObj.getInstance().COUNTRY_ACTIVE_TEAM)
            {
                this.topActivateAddedBtn(TopActivateName.TOP_ICON_COUNTRY, true);
            }
            return;
        }// end function

        public function flashToMail(param1:Array, param2:Point) : void
        {
            this._minimap.flashToEmail(param1, param2);
            return;
        }// end function

        public function registerGuide() : void
        {
            var _loc_1:* = this._topActivateIconsPanel.getTopActivateIcon(TopActivateName.TOP_ICON_REWARDS_THOLD);
            GuideControl.getInstance().registerGuide(_loc_1, this, GuideConfigObj.getInstance().SIGN_WAGE_GUIDE_ID_1);
            _loc_1 = this._topActivateIconsPanel.getTopActivateIcon(TopActivateName.TOP_ICON_DEKARON);
            GuideMultiControl.getInstance().registerGuide(_loc_1, this, GuideConfigObj.getInstance().DEKARON_ZONE_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

        private function updateWSBlock() : void
        {
            var _loc_1:* = this.WS_BLOCK[0][0];
            var _loc_2:* = this.WS_BLOCK[0][1];
            var _loc_3:* = [];
            while (_loc_1 <= this.WS_BLOCK[1][0])
            {
                
                _loc_2 = this.WS_BLOCK[0][1];
                while (_loc_2 <= this.WS_BLOCK[1][1])
                {
                    
                    _loc_3.push({tx:_loc_1, ty:_loc_2});
                    _loc_2++;
                }
                _loc_1++;
            }
            MapObj.getInstance().generateObstacle(_loc_3);
            return;
        }// end function

        private function showZoneLoading() : Function
        {
            if (!this._loadingComponent)
            {
                this._loadingComponent = new ChangeSceneLoadingComponent();
            }
            return this._loadingComponent.setProgress;
        }// end function

        private function showLoading(param1:int) : void
        {
            if (!this._loadingComponent)
            {
                this._loadingComponent = new ChangeSceneLoadingComponent();
            }
            this._loadingComponent.beginShow(param1);
            if (!this._loadingComponent.parent)
            {
                FrameworkGlobal.stage.addChild(this._loadingComponent);
            }
            return;
        }// end function

        public static function getInstance() : MapControl
        {
            if (instance == null)
            {
                instance = new MapControl;
            }
            return instance;
        }// end function

    }
}
