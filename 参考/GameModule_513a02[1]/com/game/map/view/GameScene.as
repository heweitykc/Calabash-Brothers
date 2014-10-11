package com.game.map.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.effect.*;
    import com.f1.events.*;
    import com.f1.interfaces.*;
    import com.f1.manager.pop.*;
    import com.f1.manager.resource.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.chat.control.*;
    import com.game.common.*;
    import com.game.country.control.*;
    import com.game.dragonking.control.*;
    import com.game.fight.control.*;
    import com.game.guide.control.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.game.map.event.*;
    import com.game.map.message.*;
    import com.game.map.model.*;
    import com.game.map.view.scrollcue.*;
    import com.game.prenotice.control.*;
    import com.game.role.*;
    import com.game.role.control.*;
    import com.game.role.model.*;
    import com.game.sound.control.*;
    import com.game.structs.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.role.*;

    public class GameScene extends SimpleScene
    {
        protected var _mapID:uint;
        private var transfers:Array;
        protected var _roleList:RoleList;
        protected var _npcList:NpcList;
        protected var _cutePetList:CutePetList;
        protected var _magicBookRoleList:MagicBookRoleList;
        private var _dropFlyList:DropFlyIconList;
        private var _stageClickMC:VMCView;
        private var _selectCircle:VMCView;
        private var _selectNpcCircle:VMCView;
        private var _dropGoods:Vector.<DropIcon>;
        private var _bossReliveList:Vector.<BossReliveItem>;
        private var _loadingComponent:ChangeSceneLoadingComponent;
        private var _mapNameImage:Image;
        private var lastFilter:DisplayObject;
        private var hasTipsAdult:Boolean = false;
        private var hasInitCountry:Boolean = false;
        private var count:int = 0;
        private var transEffect:VMCView;
        private var _delayShowDrop:uint;
        private var _dropTimerStr:String;

        public function GameScene()
        {
            this._roleList = RoleList.getInstance();
            this._npcList = NpcList.getInstance();
            this._cutePetList = CutePetList.getInstance();
            this._dropFlyList = DropFlyIconList.getInstance();
            this._magicBookRoleList = MagicBookRoleList.getInstance();
            this.initLiveness();
            if (Params.isadult == AdultType.NO_ADULT && !this.hasTipsAdult)
            {
                this.hasTipsAdult = true;
                MapControl.getInstance().addAdultIcon();
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12096"), "", null, this.jumpAdult, null, 2, LanguageCfgObj.getInstance().getByIndex("12100"));
            }
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
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

        private function addedToStage(event:Event) : void
        {
            FrameworkGlobal.stageAddEvtListener(MouseEvent.CLICK, this.__clickBg);
            FrameworkGlobal.addMsgListen(GameEvent.CHAT_CLICK_BLANK, this.__clickChatBlank);
            FrameworkGlobal.stageAddEvtListener("rightClick", this.__rightClickBg);
            return;
        }// end function

        private function removeFromStage(event:Event) : void
        {
            FrameworkGlobal.stageRemoveEvtListener(MouseEvent.CLICK, this.__clickBg);
            FrameworkGlobal.stageRemoveEvtListener("rightClick", this.__rightClickBg);
            return;
        }// end function

        private function mapSetCfgComplete() : void
        {
            MapObj.getInstance().setMapPoint(_bgView.mapPos);
            TweenLite.delayedCall(1, function () : void
            {
                FrameworkGlobal.sendMsg(new MapEvent(MapEvent.MAP_CHANGE_COMPLETE));
                var _loc_1:* = UserObj.getInstance().playerInfo.vipid > 0;
                return;
            }// end function
            );
            return;
        }// end function

        private function __clickChatBlank(event:GameEvent) : void
        {
            var _loc_2:* = new MouseEvent(MouseEvent.CLICK);
            _loc_2.localX = event.obj.x;
            _loc_2.localY = event.obj.y;
            FrameworkGlobal.stage.dispatchEvent(_loc_2);
            return;
        }// end function

        override protected function updateMap(param1:String) : void
        {
            var url:* = param1;
            if (this._mapID == Params.CLIENT_ZONES_DRAGON_KING)
            {
                _bgView.update(url, function () : void
            {
                PreVResManager.load(PreVResManager.PRE_FIREDRAGON + UserObj.getInstance().playerInfo.jobkind, _progressFun, function () : void
                {
                    mapReady();
                    DragonKingController.getInstance().onResComplete();
                    return;
                }// end function
                , null);
                return;
            }// end function
            );
            }
            else
            {
                super.updateMap(url);
            }
            return;
        }// end function

        public function changeMap() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = this._mapID == MapObj.getInstance().mapID;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapPreID);
            this._mapID = MapObj.getInstance().mapID;
            var _loc_3:* = MapCfgObj.getInstance().getMap(this._mapID);
            var _loc_4:* = false;
            if (!_loc_2 || _loc_2.zones_type == 0 && _loc_3.zones_type != 0 || _loc_3.mapId == Params.CLIENT_ZONES_SKE_KING_ID || _loc_3.mapId == Params.CLIENT_ZONES_DRAGON_KING)
            {
                if (_loc_3.zones_type != 5)
                {
                    MapControl.getInstance().updateLines(new Array(), 0);
                    _loc_4 = true;
                }
            }
            if (!_loc_2 && _loc_3.zones_type != 0 || _loc_2.zones_type == 0 && _loc_3.zones_type != 0)
            {
                PrenoticeControl.getInstance().setPrenoticeVisible(false);
            }
            else
            {
                PrenoticeControl.getInstance().setPrenoticeVisible(true);
            }
            this.reset();
            var _loc_5:* = Params.MAP_PATH + _loc_3.url + ".bin";
            MapObj.getInstance().tilesba = null;
            this.updateMap(_loc_5);
            if (AutoFightManager.getInstance().isAutoFighting())
            {
                AutoFightController.getInstance().closeAutoFight(true);
            }
            FrameworkGlobal.sendMsg(new MapEvent(MapEvent.MAP_CHANGE));
            this.transfers = MapCfgObj.getInstance().getTransferByMapId(this._mapID);
            for each (_loc_7 in this.transfers)
            {
                
                _loc_6 = new VMCView();
                _loc_6.auto = true;
                if (!_loc_6.updatePose("90", true))
                {
                    _loc_6.loadRes("res/effect/tx3002.png", null, true, null, null, null, null, FrameworkGlobal.LOAD_MAP_EFFECT);
                }
                _loc_6.move(_loc_7.x, _loc_7.y);
                _bottomLayer.addChild(_loc_6);
                _sceneItems.push(_loc_6);
            }
            MapControl.getInstance().freshMinimap();
            if (!this._mapNameImage)
            {
                this._mapNameImage = new Image();
            }
            if (!this._mapNameImage.parent)
            {
                Global.popManager.addedMapNameTips(this._mapNameImage);
            }
            var _loc_8:* = 0;
            if (this._mapID >= 300001 && this._mapID <= 300007)
            {
                _loc_8 = 300001;
            }
            else if (this._mapID >= 400001 && this._mapID <= 400008)
            {
                _loc_8 = 300002;
            }
            else
            {
                _loc_8 = this._mapID;
            }
            this._mapNameImage.load("art/res/changscene/" + _loc_8 + ".png", this.loadMapNameCompelete);
            if (this._selectCircle && this._selectCircle.url)
            {
                this._selectCircle.loadRes(this._selectCircle.url);
            }
            PlayerArriveHandler.handle();
            var _loc_9:* = TaskGlobal.task;
            if (!_loc_2 && _loc_3.zones_type == 0 || _loc_2.zones_type != 0 && _loc_3.zones_type == 0 && _loc_9 && int(_loc_9.conf.q_task_type) == TaskGlobal.TASK_ELSE && _loc_9.actionMsg && (_loc_9.actionMsg.id == 10 || _loc_9.actionMsg.id == 29) || TaskGlobal.isChangeSceneContinueTask && _loc_3.zones_type == 0)
            {
                TaskGlobal.manager.continueTask(TaskGlobal.task, false);
                TaskGlobal.isChangeSceneContinueTask = false;
            }
            if (TaskGlobal.taskFindPathCallBack != null)
            {
                TaskGlobal.taskFindPathCallBack();
                TaskGlobal.taskFindPathCallBack = null;
            }
            return;
        }// end function

        private function loadMapNameCompelete(param1:Object = null) : void
        {
            TweenLite.killTweensOf(this._mapNameImage);
            if (this._mapNameImage.parent)
            {
                this._mapNameImage.parent.removeChild(this._mapNameImage);
            }
            TweenLite.killDelayedCallsTo(this.showMapName);
            TweenLite.delayedCall(5, this.showMapName);
            return;
        }// end function

        private function showMapName() : void
        {
            if (!this._mapNameImage.parent)
            {
                Global.popManager.addedMapNameTips(this._mapNameImage);
            }
            (this._mapNameImage.parent.parent as BaseSprite).layoutMC(this._mapNameImage, Layout.CENTER, 0, -180);
            ScrollMC.start(this._mapNameImage, 2, ScrollMC.MAP_NAME_TYPE);
            return;
        }// end function

        override protected function mapReady() : void
        {
            this.mapSetCfgComplete();
            if (_bgView)
            {
                MapObj.getInstance().tilesba = _bgView.tileByteArrays;
            }
            super.mapReady();
            this.initPlayer();
            changeLightStreng(this._mapID);
            this.roleMoveHandler();
            AutoFightController.getInstance().start();
            Common.gameInited();
            PrenoticeControl.getInstance();
            SpeakControl.getInstance();
            if (Params.autoFight)
            {
                Params.autoFight = false;
                TweenLite.delayedCall(1, function () : void
            {
                AutoFightController.getInstance().openAutoFight();
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function initPlayer() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            if (_playerRole)
            {
                _playerRole.updatePosition();
            }
            else
            {
                _loc_2 = PropUtil.hasAutoPickCutePet(_loc_1.equipPetId);
                if (_loc_2 != 0)
                {
                    _loc_3 = new CutePetInfo();
                    _loc_3.conByParentInfo(_loc_1);
                    _loc_4 = Global.roleFactory.createPlayerCutePet(_loc_3);
                    this.addCutePet(_loc_4, true);
                    _loc_4.flyToParent();
                }
                _playerRole = Global.roleFactory.creatPlayer(_loc_1);
                _playerRole.addEvtListener(RoleEvent.ARRIVE, this.__arrive);
                this.addRole(_playerRole);
                this._roleList.player = _playerRole;
            }
            _playerRole.resetMagicBook();
            _playerRole.resetCutePet();
            if (FrameworkGlobal.showHighLevelShadow || _loc_1.level <= FrameworkGlobal.showLightLevel)
            {
                FrameworkGlobal.showHighLevelShadow = true;
                super.showBottomLight(null);
            }
            return;
        }// end function

        private function initLiveness() : void
        {
            return;
        }// end function

        private function initCountry() : void
        {
            if (!this.hasInitCountry)
            {
                this.hasInitCountry = true;
                Ticker.registerTimer(1, this.checkTime);
            }
            return;
        }// end function

        private function checkTime() : void
        {
            var _loc_1:* = ToolKit.getServerDate();
            this.checkCountry(_loc_1);
            return;
        }// end function

        private function checkCountry(param1:Date) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = this;
            var _loc_5:* = this.count + 1;
            _loc_4.count = _loc_5;
            if (this.count < 1800)
            {
                return;
            }
            this.count = 0;
            var _loc_2:* = param1.day;
            if (_loc_2 == 5 && param1.hours < 20)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10940");
                Global.popManager.addedToMarQueeTop(_loc_3);
            }
            return;
        }// end function

        protected function __arrive(event:RoleEvent) : void
        {
            PlayerArriveHandler.handle();
            this.checkTransfer();
            return;
        }// end function

        private function checkTransfer() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.transfers)
            {
                
                if (ToolKit.distance(_playerRole._x, _playerRole._y, _loc_1.x, _loc_1.y) <= _loc_1.r)
                {
                    if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
                    {
                        MapControl.getInstance().changeMapByMove(_loc_1.q_tran_id);
                    }
                    else
                    {
                        MapControl.getInstance().changeMapByMove(_loc_1.q_tran_id);
                    }
                    return;
                }
            }
            return;
        }// end function

        private function playEffext() : void
        {
            if (this.transEffect == null)
            {
                this.transEffect = new VMCView();
                this.transEffect.auto = true;
            }
            this.transEffect.loadRes("res/effect/transEffect.png");
            this.transEffect.updatePose("front_90", true);
            this.transEffect.replay();
            (RoleList.getInstance().player as DisplayObjectContainer).addChild(this.transEffect);
            TweenLite.delayedCall(0.5, function () : void
            {
                transEffect.removeFromParent(true);
                return;
            }// end function
            );
            return;
        }// end function

        public function addRoleByInfo(param1:RoleInfo) : IRole
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                return _loc_2;
            }
            _loc_2 = Global.roleFactory.creatRole(param1);
            this.addRole(_loc_2);
            return _loc_2;
        }// end function

        public function addClientRoleByInfo(param1:RoleInfo) : IRole
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                return _loc_2;
            }
            _loc_2 = Global.roleFactory.createClientRole(param1);
            this.addRole(_loc_2);
            return _loc_2;
        }// end function

        protected function addRole(param1:IRole) : void
        {
            addElement(param1);
            this._roleList.addRole(param1);
            if (param1 != _playerRole)
            {
                if (!param1.info || param1.info.q_mouse == 0)
                {
                    param1.addEvtListener(MouseEvent.MOUSE_DOWN, this.__clickRole);
                    param1.addEvtListener("rightClick", this.__clickRole);
                    param1.addEvtListener(MouseEvent.MOUSE_MOVE, this.__overRole);
                    param1.addEvtListener(MouseEvent.MOUSE_OUT, this.__outRole);
                }
            }
            return;
        }// end function

        public function removeRolesByPersonID(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                this.removeRoleByPersonID(_loc_2);
            }
            return;
        }// end function

        public function removeRoleByPersonID(param1:long) : void
        {
            var _loc_2:* = this._roleList.getRole(param1);
            this.removeRole(_loc_2);
            return;
        }// end function

        public function removeRole(param1:IRole) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!param1)
            {
                return;
            }
            if (param1.cutePet)
            {
                _loc_2 = this._cutePetList.getCutePet(param1.cutePet.parentId);
                this._cutePetList.removeCutePet(_loc_2);
                removeElement(_loc_2);
            }
            if (param1.magicBookInfo)
            {
                _loc_3 = this._magicBookRoleList.getMagicBookRole(param1.magicBookInfo.parentId);
                this._magicBookRoleList.removeMagicBookRole(_loc_3);
                removeElement(_loc_3);
            }
            if (param1.info)
            {
            }
            this._roleList.removeRole(param1);
            removeElement(param1);
            return;
        }// end function

        public function removeRoleFromRoles(param1:IRole) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!param1)
            {
                return;
            }
            if (param1.cutePet)
            {
                _loc_2 = this._cutePetList.getCutePet(param1.cutePet.parentId);
                this._cutePetList.removeCutePet(_loc_2);
                removeElement(_loc_2);
            }
            if (param1.magicBookInfo)
            {
                _loc_3 = this._magicBookRoleList.getMagicBookRole(param1.info.personId);
                this._magicBookRoleList.removeMagicBookRole(_loc_3);
                removeElement(_loc_3);
            }
            if (param1.info)
            {
            }
            removeElement(param1);
            return;
        }// end function

        public function removeNpcByPersonID(param1:long) : void
        {
            var _loc_2:* = this._npcList.getNpc(param1);
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2 == NpcData.getInstance().selectNpc)
            {
                NpcData.getInstance().selectNpc = null;
            }
            this._npcList.removeNpc(_loc_2);
            this.checkNPC(_loc_2, false);
            removeElement(_loc_2);
            return;
        }// end function

        public function removeNPCSound(param1:Vector.<long>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = this._npcList.getNpc(_loc_2);
                if (!_loc_3 || _loc_3.info)
                {
                    return;
                }
                removeElement(_loc_3);
            }
            return;
        }// end function

        private function __overRole(event:MouseEvent) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = IRole(event.currentTarget);
            var _loc_3:* = _gameLayer.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            if (_loc_3.length == 1 && _loc_3[0].parent && _loc_3[0].parent is ShadowViewNew)
            {
                Global.primaryCursorManager.hide();
                _loc_2.unShine();
                if (!_loc_2.isPlayer())
                {
                    _loc_2.hideBloodStripe();
                }
                return;
            }
            var _loc_4:* = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                if (_loc_3[_loc_5] is Bitmap)
                {
                    _loc_7 = new Point(event.stageX, event.stageY);
                    _loc_7 = (_loc_3[_loc_5] as Bitmap).globalToLocal(_loc_7);
                    _loc_8 = (_loc_3[_loc_5] as Bitmap).bitmapData.getPixel32(_loc_7.x, _loc_7.y);
                    if ((_loc_8 & 4278190080) != 0 && !(_loc_3[_loc_5].parent is ShadowViewNew))
                    {
                        _loc_4 = false;
                        _loc_2 = _loc_3[_loc_5].parent as IRole;
                    }
                }
                _loc_5++;
            }
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_9 = _loc_3[_loc_6].parent as IRole;
                if (_loc_9)
                {
                    _loc_9.unShine();
                    if (!_loc_9.isPlayer())
                    {
                        _loc_9.hideBloodStripe();
                    }
                }
                _loc_10 = _loc_3[_loc_6].parent as INpc;
                if (_loc_10)
                {
                    _loc_10.unShine();
                }
                _loc_6++;
            }
            Global.primaryCursorManager.hide();
            if (_loc_4)
            {
                return;
            }
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.isEnemy())
            {
                Global.primaryCursorManager.showAttackIcon();
            }
            if (!_loc_2.isUser())
            {
                _loc_2.shine();
                this.lastFilter = _loc_2 as DisplayObject;
            }
            if (!_loc_2.isPlayer())
            {
                _loc_2.showBloodStripe();
            }
            return;
        }// end function

        private function __outRole(event:MouseEvent) : void
        {
            Global.primaryCursorManager.hide();
            var _loc_2:* = IRole(event.currentTarget);
            _loc_2.unShine();
            if (!_loc_2.isPlayer())
            {
                _loc_2.hideBloodStripe();
            }
            if (this.lastFilter)
            {
                if (this.lastFilter is IRole)
                {
                    (this.lastFilter as IRole).unShine();
                }
                else if (this.lastFilter is INpc)
                {
                    (this.lastFilter as INpc).unShine();
                }
            }
            return;
        }// end function

        protected function __clickRole(event:MouseEvent) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_2:* = IRole(event.currentTarget);
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.isMonster() && !_loc_2.alive())
            {
                return;
            }
            var _loc_3:* = _gameLayer.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            var _loc_4:* = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                if (_loc_3[_loc_5].parent && !(_loc_3[_loc_5].parent is ShadowViewNew))
                {
                    _loc_4 = false;
                }
                _loc_5++;
            }
            if (_loc_4)
            {
                _loc_8 = new MouseEvent(MouseEvent.CLICK, true, false, event.stageX, event.stageY);
                FrameworkGlobal.stage.dispatchEvent(_loc_8);
                return;
            }
            var _loc_6:* = true;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3.length)
            {
                
                if (_loc_3[_loc_7] is Bitmap)
                {
                    _loc_9 = new Point(event.stageX, event.stageY);
                    _loc_9 = (_loc_3[_loc_7] as Bitmap).globalToLocal(_loc_9);
                    _loc_10 = (_loc_3[_loc_7] as Bitmap).bitmapData.getPixel32(_loc_9.x, _loc_9.y);
                    if ((_loc_10 & 4278190080) != 0 && !(_loc_3[_loc_7].parent is ShadowViewNew))
                    {
                        _loc_6 = false;
                        if (_loc_3[_loc_7].parent is IRole)
                        {
                            _loc_2 = _loc_3[_loc_7].parent as IRole;
                        }
                    }
                }
                _loc_7++;
            }
            if (_loc_6)
            {
                _loc_11 = new MouseEvent(MouseEvent.CLICK, true, false, event.stageX, event.stageY);
                FrameworkGlobal.stage.dispatchEvent(_loc_11);
                return;
            }
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2 && _loc_2.isUser())
            {
                return;
            }
            Player.state = State.NONE;
            UserObj.getInstance().selectRole = _loc_2;
            this.showSelectRole(_loc_2);
            if (_playerRole.info.currentSkill)
            {
                if (!_loc_2.isPlayer() || event.type == "rightClick")
                {
                    _playerRole.info.currentSkill.targetRole = _loc_2;
                    FightControl.getInstance().checkAndAttack(_playerRole);
                }
            }
            else if (!UserObj.getInstance().playerInfo.isBecome && (!_loc_2.isPlayer() && _loc_2.isEnemy() || event.type == "rightClick"))
            {
                FightControl.getInstance().useSkill(UserObj.getInstance().playerInfo.defaultSkillId, _loc_2);
            }
            CountryControl.getInstance().stopGather();
            return;
        }// end function

        public function doRole(param1:IRole) : void
        {
            if (param1.isMonster() && !param1.alive())
            {
                return;
            }
            UserObj.getInstance().selectRole = param1;
            this.showSelectRole(param1);
            if (_playerRole.info.currentSkill)
            {
                if (!_playerRole.isPlayer())
                {
                    _playerRole.info.currentSkill.targetRole = param1;
                    FightControl.getInstance().checkAndAttack(_playerRole);
                }
            }
            else if (!param1.isPlayer())
            {
                FightControl.getInstance().useSkill(UserObj.getInstance().playerInfo.defaultSkillId, param1);
            }
            CountryControl.getInstance().stopGather();
            return;
        }// end function

        public function showSelectRole(param1:IRole) : void
        {
            if (this._selectNpcCircle && this._selectNpcCircle.parent)
            {
                this._selectNpcCircle.parent.removeChild(this._selectNpcCircle);
            }
            if (!param1)
            {
                if (this._selectCircle)
                {
                    this._selectCircle.removeFromParent();
                }
                return;
            }
            var _loc_2:* = "res/effect/heel_enemy.png";
            var _loc_3:* = "res/effect/heel_league.png";
            if (this._selectCircle == null)
            {
                this._selectCircle = new VMCView();
                this._selectCircle.auto = true;
            }
            if (param1.isEnemy())
            {
                if (this._selectCircle.url != _loc_2)
                {
                    this._selectCircle.loadRes(_loc_2);
                }
            }
            else if (this._selectCircle.url != _loc_3)
            {
                this._selectCircle.loadRes(_loc_3);
            }
            this._selectCircle.updatePose("90", true);
            this._selectCircle.play();
            param1.addCircle(this._selectCircle);
            return;
        }// end function

        public function addNpcsByCSInfo(param1:Vector.<NpcInfo>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                this.addNpcByCSInfo(_loc_2);
            }
            return;
        }// end function

        public function addNpcByCSInfo(param1:NpcInfo) : void
        {
            var _loc_2:* = new NpcShowInfo();
            _loc_2.npcInfo = param1;
            var _loc_3:* = Global.roleFactory.creatNpc(_loc_2);
            this.addNPC(_loc_3);
            return;
        }// end function

        public function addNPCByInfo(param1:RoleInfo) : INpc
        {
            var _loc_2:* = null;
            if (param1 is NpcShowInfo)
            {
                _loc_2 = Global.roleFactory.creatNpc(param1);
                this.addNPC(_loc_2);
            }
            return _loc_2;
        }// end function

        protected function addNPC(param1:INpc) : void
        {
            addElement(param1);
            this._npcList.addNpc(param1);
            this.checkNPC(param1, true);
            param1.addEvtListener(MouseEvent.CLICK, this.__clickNpc);
            param1.addEvtListener("rightClick", this.__clickNpc);
            param1.addEvtListener(MouseEvent.MOUSE_MOVE, this.__overNpc);
            param1.addEvtListener(MouseEvent.MOUSE_OUT, this.__outNpc);
            return;
        }// end function

        private function checkNPC(param1:INpc, param2:Boolean) : void
        {
            var _loc_3:* = param1.info.cfgId;
            if (NpcData.getInstance().taskMap[_loc_3])
            {
                NpcControl.getInstance().setTaskIcon(_loc_3, param2);
            }
            return;
        }// end function

        private function __overNpc(event:MouseEvent) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = INpc(event.currentTarget);
            var _loc_3:* = _gameLayer.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            if (_loc_3.length == 1 && _loc_3[0].parent && _loc_3[0].parent is ShadowViewNew)
            {
                _loc_2.unShine();
                _loc_2.hideCursor();
                return;
            }
            var _loc_4:* = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                if (_loc_3[_loc_5] is Bitmap)
                {
                    _loc_7 = new Point(event.stageX, event.stageY);
                    _loc_7 = (_loc_3[_loc_5] as Bitmap).globalToLocal(_loc_7);
                    _loc_8 = (_loc_3[_loc_5] as Bitmap).bitmapData.getPixel32(_loc_7.x, _loc_7.y);
                    if ((_loc_8 & 4278190080) != 0 && !(_loc_3[_loc_5].parent is ShadowViewNew))
                    {
                        _loc_4 = false;
                        if (_loc_3[_loc_5].parent is INpc)
                        {
                            _loc_2 = _loc_3[_loc_5].parent as INpc;
                        }
                    }
                }
                _loc_5++;
            }
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_9 = _loc_3[_loc_6].parent as INpc;
                if (_loc_9)
                {
                    _loc_9.unShine();
                    _loc_9.hideCursor();
                }
                _loc_10 = _loc_3[_loc_6].parent as INpc;
                if (_loc_10)
                {
                    _loc_10.unShine();
                }
                _loc_6++;
            }
            if (_loc_4)
            {
                return;
            }
            if (!_loc_2)
            {
                return;
            }
            if (!_loc_2.isUser())
            {
                _loc_2.shine();
                this.lastFilter = _loc_2 as DisplayObject;
            }
            if (_loc_2.info.cfgId == 105001)
            {
            }
            else
            {
                _loc_2.showCursor();
            }
            return;
        }// end function

        private function __outNpc(event:MouseEvent) : void
        {
            Global.primaryCursorManager.hide();
            if (this.lastFilter)
            {
                if (this.lastFilter is IRole)
                {
                    (this.lastFilter as IRole).unShine();
                }
                else if (this.lastFilter is INpc)
                {
                    (this.lastFilter as INpc).unShine();
                }
            }
            return;
        }// end function

        private function __clickNpc(event:MouseEvent) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_2:* = INpc(event.currentTarget);
            var _loc_3:* = _gameLayer.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            var _loc_4:* = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                if (_loc_3[_loc_5].parent && !(_loc_3[_loc_5].parent is ShadowViewNew))
                {
                    _loc_4 = false;
                }
                _loc_5++;
            }
            if (_loc_4 && !isNaN(event.stageX))
            {
                _loc_8 = new MouseEvent(MouseEvent.CLICK, true, false, event.stageX, event.stageY);
                FrameworkGlobal.stage.dispatchEvent(_loc_8);
                return;
            }
            var _loc_6:* = true;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3.length)
            {
                
                if (_loc_3[_loc_7] is Bitmap)
                {
                    _loc_9 = new Point(event.stageX, event.stageY);
                    _loc_9 = (_loc_3[_loc_7] as Bitmap).globalToLocal(_loc_9);
                    _loc_10 = (_loc_3[_loc_7] as Bitmap).bitmapData.getPixel32(_loc_9.x, _loc_9.y);
                    if ((_loc_10 & 4278190080) != 0 && !(_loc_3[_loc_7].parent is ShadowViewNew))
                    {
                        _loc_6 = false;
                        _loc_2 = _loc_3[_loc_7].parent as INpc;
                    }
                }
                _loc_7++;
            }
            if (_loc_6 && !isNaN(event.stageX))
            {
                _loc_11 = new MouseEvent(MouseEvent.CLICK, true, false, event.stageX, event.stageY);
                FrameworkGlobal.stage.dispatchEvent(_loc_11);
                return;
            }
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.isUser())
            {
                return;
            }
            Player.state = State.NONE;
            NpcControl.getInstance().selectNpc = _loc_2;
            this.showSelectNpc(_loc_2);
            FightControl.getInstance().delCurrentSkill();
            _playerRole.pathByCoo(_loc_2._x, _loc_2._y, 3, 0, false, false);
            Player.state = State.NONE;
            return;
        }// end function

        public function doNpc(param1:INpc) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1.isUser())
            {
                return;
            }
            Player.state = State.NONE;
            NpcControl.getInstance().selectNpc = param1;
            this.showSelectNpc(param1);
            FightControl.getInstance().delCurrentSkill();
            _playerRole.pathByCoo(param1._x, param1._y, 3, 0, false, false);
            if (param1.info.cfgId != 105001)
            {
                CountryControl.getInstance().stopGather();
            }
            return;
        }// end function

        public function showSelectNpc(param1:INpc) : void
        {
            var _loc_2:* = "res/effect/heel_league.png";
            if (this._selectCircle && this._selectCircle.parent)
            {
                this._selectCircle.parent.removeChild(this._selectCircle);
            }
            if (!this._selectNpcCircle)
            {
                this._selectNpcCircle = new VMCView();
                this._selectNpcCircle.auto = true;
            }
            this._selectNpcCircle.loadRes(_loc_2);
            this._selectNpcCircle.updatePose("90", true);
            this._selectNpcCircle.play();
            param1.getSprite().addChildAt(this._selectNpcCircle, 0);
            return;
        }// end function

        public function addCutePetByInfo(param1:CutePetInfo) : ICutePet
        {
            var _loc_2:* = this._cutePetList.getCutePet(param1.personId);
            if (_loc_2)
            {
                return _loc_2;
            }
            _loc_2 = Global.roleFactory.createCutePet(param1);
            this.addCutePet(_loc_2);
            return _loc_2;
        }// end function

        public function addPlayerCutePetByInfo(param1:CutePetInfo) : ICutePet
        {
            var _loc_2:* = this._cutePetList.playerCutePet;
            if (_loc_2)
            {
                return _loc_2;
            }
            _loc_2 = Global.roleFactory.createPlayerCutePet(param1);
            this.addCutePet(_loc_2, true);
            return _loc_2;
        }// end function

        protected function addCutePet(param1:ICutePet, param2:Boolean = false) : void
        {
            addElement(param1);
            if (param2)
            {
                this._cutePetList.playerCutePet = param1;
            }
            this._cutePetList.addCutePet(param1);
            return;
        }// end function

        public function removeCutePetByParentId(param1:long) : void
        {
            var _loc_2:* = this._cutePetList.getCutePet(param1);
            if (!_loc_2)
            {
                return;
            }
            this._cutePetList.removeCutePet(_loc_2);
            removeElement(_loc_2);
            return;
        }// end function

        public function removeCutePet(param1:ICutePet) : void
        {
            this._cutePetList.removeCutePet(param1);
            removeElement(param1);
            return;
        }// end function

        public function addMagicBookByInfo(param1:MagicBookInfo, param2:Boolean = false) : IMagicBookRole
        {
            var _loc_3:* = this._magicBookRoleList.getMagicBookRole(param1.parentId);
            if (_loc_3)
            {
                return _loc_3;
            }
            _loc_3 = Global.roleFactory.createMagicBookRole(param1);
            this.addMagicBookRole(_loc_3);
            return _loc_3;
        }// end function

        public function removeMagicBookByParentId(param1:long) : void
        {
            var _loc_2:* = this._magicBookRoleList.getMagicBookRole(param1);
            if (!_loc_2)
            {
                return;
            }
            this._magicBookRoleList.removeMagicBookRole(_loc_2);
            removeElement(_loc_2);
            return;
        }// end function

        protected function addMagicBookRole(param1:IMagicBookRole, param2:Boolean = false) : void
        {
            addElement(param1);
            if (param2)
            {
                this._magicBookRoleList.playerMagicBook = param1;
            }
            this._magicBookRoleList.addMagicBookRole(param1);
            return;
        }// end function

        public function addClientTransfer(param1:VMCView) : void
        {
            _bottomLayer.addChild(param1);
            _sceneItems.push(param1);
            return;
        }// end function

        public function addSpeciaRole(param1:IRoleView) : void
        {
            addElement(param1);
            return;
        }// end function

        private function __rightClickBg(event:MouseEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (event.target == FrameworkGlobal.stage || event.target == _bgView)
            {
                _loc_2 = event.stageX - _gameLayer.x;
                _loc_3 = event.stageY - _gameLayer.y;
                FightControl.getInstance().useSkill(UserObj.getInstance().playerInfo.defaultSkillId, null, _loc_2, _loc_3);
            }
            return;
        }// end function

        protected function __clickBg(event:MouseEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            if (event.target == FrameworkGlobal.stage || event.target == _bgView || event.target is Player)
            {
                _loc_2 = event.stageX - _gameLayer.x;
                _loc_3 = event.stageY - _gameLayer.y;
                FightControl.getInstance().delCurrentSkill();
                Player(RoleList.getInstance().player).stopAutoFightBack();
                if (_playerRole && Player.state != State.AUTO_ROAD)
                {
                    TweenLite.killDelayedCallsTo(this.delayStateBack);
                    AutoFightController.getInstance().closeAutoFind();
                    _playerRole.pathByCoo(_loc_2, _loc_3, 0, 0, false, false);
                    Player.state = State.NONE;
                    GuideControl.getInstance().taskStopPath();
                    TaskGlobal.autoTask = false;
                    ZonesControl.getInstance().cancelPath();
                    NpcControl.getInstance().selectNpc = null;
                    DieLogic.isComingBack = false;
                    _loc_4 = PopManager(Global.popManager).getTxtCueText();
                    if (_loc_4 && _loc_4 == TaskGlobal.CLICK_SCENE_HINT)
                    {
                        PopManager(Global.popManager).clearTxtCue();
                    }
                }
                else
                {
                    Player.state = State.NONE;
                    Global.popManager.txtCue(TaskGlobal.CLICK_SCENE_HINT, 5);
                    TweenLite.delayedCall(5, this.delayStateBack);
                    event.stopImmediatePropagation();
                    TaskGlobal.manager.setAutoTask(true);
                }
                this.showStageClickMC(_loc_2, _loc_3);
                CountryControl.getInstance().stopGather();
            }
            return;
        }// end function

        private function delayStateBack() : void
        {
            Player.state = State.AUTO_ROAD;
            return;
        }// end function

        public function roleRunPositions(param1:long, param2:Position, param3:Vector.<int>) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_10:* = null;
            var _loc_13:* = 0;
            var _loc_4:* = this._roleList.getRole(param1);
            if (!this._roleList.getRole(param1))
            {
                return;
            }
            if (param2)
            {
                _loc_4.move(param2.x, param2.y);
            }
            var _loc_7:* = _loc_4._x;
            var _loc_8:* = _loc_4._y;
            var _loc_9:* = [[_loc_7, _loc_8]];
            var _loc_11:* = [];
            var _loc_12:* = 0;
            for each (_loc_13 in param3)
            {
                
                _loc_5 = (_loc_13 & 224) >> 5;
                _loc_11.push(_loc_5);
                _loc_6 = _loc_13 & 31;
                _loc_10 = MapUtils.countDirectionAddtion(_loc_5);
                _loc_10 = [_loc_9[_loc_12][0] + _loc_10[0] * _loc_6 * MapUtils.GRID_BORDER, _loc_9[_loc_12][1] + _loc_10[1] * _loc_6 * MapUtils.GRID_BORDER];
                _loc_9.push(_loc_10);
                _loc_12 = _loc_12 + 1;
            }
            _loc_9.shift();
            _loc_4.pathByAStarArray(_loc_9, _loc_11);
            if (_loc_4.info is MonsterInfo)
            {
                SoundControl.getInstance().playMonseterSound(SoundFlag.MONSTER_SOUND, (_loc_4.info as MonsterInfo).cfgId);
            }
            return;
        }// end function

        public function roleRunEnd(param1:long, param2:Position) : void
        {
            return;
        }// end function

        protected function showStageClickMC(param1:int, param2:int) : void
        {
            if (this._stageClickMC == null)
            {
                this._stageClickMC = new VMCView();
                this._stageClickMC.loadRes("res/effect/mouseclick.png", null, true);
                this._stageClickMC.auto = true;
            }
            if (this._stageClickMC.parent == null)
            {
                _gameLayer.addChild(this._stageClickMC);
            }
            this._stageClickMC.updatePose("90", false, false, true);
            this._stageClickMC.move(param1, param2);
            this._stageClickMC.play();
            return;
        }// end function

        public function drawPath(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            ToolKit.clearMcChild(_tempLayer);
            for each (_loc_3 in param1)
            {
                
                _loc_2 = ToolKit.creatCircle(0, 0, 3, 16711680, -1, 1);
                _loc_2.x = _loc_3[0];
                _loc_2.y = _loc_3[1];
                _tempLayer.addChild(_loc_2);
            }
            return;
        }// end function

        public function shock(param1:uint, param2:uint) : void
        {
            Effects.flash(gameLayer, 1, 1, 0.05, 6, param2, param1);
            Effects.flash(_bgView, 1, 1, 0.05, 6, param2, param1, this.roleMoveHandler);
            return;
        }// end function

        override public function roleMoveHandler() : void
        {
            super.roleMoveHandler();
            this.checkAlphaForLight();
            if (_playerRole)
            {
                MapControl.getInstance().minimap.setCoo(_playerRole.px, _playerRole.py);
            }
            return;
        }// end function

        protected function checkAlphaForLight() : void
        {
            if (_playerRole)
            {
                if (MapControl.getInstance().isAlpha(_playerRole.px, _playerRole.py))
                {
                    if (isShowBottomLight)
                    {
                        if (!isNaN(_lightAlpha))
                        {
                            bottomLightFirst.alpha = Math.min(_lightAlpha, 0.5);
                        }
                    }
                }
                else if (isShowBottomLight)
                {
                    if (!isNaN(_lightAlpha))
                    {
                        bottomLightFirst.alpha = _lightAlpha;
                    }
                }
            }
            return;
        }// end function

        public function showBossReliveItem(param1:ResMapBossInfoMessage) : void
        {
            var _loc_2:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._resetBossReliveList();
            var _loc_3:* = 0;
            var _loc_4:* = param1.bossIds.length;
            var _loc_5:* = ToolKit.getServerTime() / 1000;
            while (_loc_3 < _loc_4)
            {
                
                if (param1.bossReviveTime[_loc_3] == 0)
                {
                }
                else
                {
                    _loc_6 = QMonsterBossQcfgObj.getInstance().getMonsterBossCfgByMonsterId(param1.bossIds[_loc_3]);
                    _loc_2 = new BossReliveItem();
                    _loc_2.info = _loc_6;
                    _loc_2.count = param1.bossReviveTime[_loc_3] + _loc_5;
                    _loc_7 = MapUtils.tile2Coo([_loc_6.q_map_x, _loc_6.q_map_y]);
                    _loc_2.move(_loc_7[0] - (_loc_2.width >> 1), _loc_7[1] - (_loc_2.height >> 1));
                    _bottomLayer.addChild(_loc_2);
                    this._bossReliveList.push(_loc_2);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function dropRoundGoods(param1:DropGoodsInfo) : void
        {
            TweenLite.delayedCall(1, this.showDropRoundGoods, [param1]);
            return;
        }// end function

        public function killDropRoundGoods() : void
        {
            TweenLite.killDelayedCallsTo(this.showDropRoundGoods);
            return;
        }// end function

        private function showDropRoundGoods(param1:DropGoodsInfo) : void
        {
            var icon:DropIcon;
            var info:* = param1;
            SoundControl.getInstance().playItemSound(SoundFlag.DROP_ITEM, info.itemModelId);
            if (!this._dropGoods)
            {
                this._resetDropList();
            }
            icon = ObjectPool.CheckOut(DropIcon);
            icon.clean();
            icon.dropInfo = info;
            _bottomLayer.addChild(icon);
            icon.move(info.x, info.y - 100);
            if (!MapControl.getInstance().isClientPick)
            {
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y - 150, onComplete:function () : void
            {
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y});
                return;
            }// end function
            });
                this._addDropToList(icon);
            }
            else
            {
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y - 150, onComplete:function () : void
            {
                TweenLite.to(icon, 0.15, {x:info.x, y:info.y, onComplete:clientDrop, onCompleteParams:[icon]});
                return;
            }// end function
            });
            }
            return;
        }// end function

        public function addToBottomLayer(param1:DisplayObject) : void
        {
            _bottomLayer.addChild(param1);
            return;
        }// end function

        private function clientDrop(param1:DropIcon) : void
        {
            MapClientControl.getInstance().dealDrop(param1);
            return;
        }// end function

        public function showDropForLogin(param1:Vector.<DropGoodsInfo>) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = ObjectPool.CheckOut(DropIcon);
                _loc_2.clean();
                _loc_5 = param1[_loc_4];
                _loc_2.dropInfo = _loc_5;
                _bottomLayer.addChild(_loc_2);
                _loc_2.move(_loc_5.x, _loc_5.y - 100);
                this._addDropToList(_loc_2);
                _loc_4++;
            }
            return;
        }// end function

        public function dropRoundGoodsDisappear(param1:Vector.<long>) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = this.getDropIcon(param1[_loc_4]);
                if (_loc_5 != -1)
                {
                    _loc_3 = this._dropGoods[_loc_5];
                    this._removeDropToList(_loc_5);
                    TweenLite.killTweensOf(_loc_3, false);
                    _loc_3.clean();
                    ObjectPool.CheckIn(_loc_3);
                }
                _loc_4++;
            }
            return;
        }// end function

        public function dropTakeUpSuccess(param1:long) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._dropGoods)
            {
                SoundControl.getInstance().playSound(SoundFlag.GET_ITEM);
                if (RoleList.getInstance().player && RoleList.getInstance().player.cutePet && RoleList.getInstance().player.cutePet.petType == 5)
                {
                    _loc_3 = CutePetList.getInstance().playerCutePet;
                    for each (_loc_2 in this._dropGoods)
                    {
                        
                        if (_loc_2.dropInfo.dropGoodsId.equal(param1) && _loc_2.dropInfo.isNanOwner != 0)
                        {
                            _loc_4 = new DropFlyIcon();
                            _loc_4.info = _loc_2.dropInfo;
                            _gameLayer.addChild(_loc_4);
                            _loc_4.moveToTarget();
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        private function getDropIcon(param1:long) : int
        {
            var _loc_3:* = null;
            if (!this._dropGoods)
            {
                return -1;
            }
            var _loc_2:* = this._dropGoods.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this._dropGoods[_loc_4].dropInfo;
                if (_loc_3.dropGoodsId.high == param1.high && _loc_3.dropGoodsId.low == param1.low)
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        override public function resize() : void
        {
            var _loc_1:* = MapControl.getInstance().scrollCue;
            if (_loc_1)
            {
                _loc_1.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH / 2);
            }
            super.resize();
            return;
        }// end function

        override public function reset() : void
        {
            var _loc_1:* = null;
            ToolKit.clearMcChild(_bottomLayer, true);
            ToolKit.clearMcChild(_topLayer, true);
            ToolKit.clearMcChild(_bloodLayer, true);
            for each (_loc_1 in _roles)
            {
                
                if (_loc_1 != _playerRole && _loc_1 != this._cutePetList.playerCutePet && this._magicBookRoleList.playerMagicBook != _loc_1)
                {
                    _loc_1.removeFromParent(true);
                }
            }
            if (this._roleList)
            {
                this._roleList.reset();
            }
            if (this._cutePetList)
            {
                this._cutePetList.reset();
            }
            if (this._magicBookRoleList)
            {
                this._magicBookRoleList.reset();
            }
            if (_playerRole)
            {
                if (this._roleList)
                {
                    this._roleList.addRole(_playerRole);
                }
                if (this._cutePetList && this._cutePetList.playerCutePet)
                {
                    this._cutePetList.addCutePet(this._cutePetList.playerCutePet);
                }
            }
            if (this._npcList)
            {
                NpcData.getInstance().selectNpc = null;
                this._npcList.reset();
            }
            if (this._dropFlyList)
            {
                this._dropFlyList.reset();
            }
            this._resetDropList();
            this._resetBossReliveList();
            UserObj.getInstance().selectRole = null;
            super.reset();
            if (_playerRole)
            {
                TweenLite.killTweensOf(_playerRole, false);
                _roles = [_playerRole];
            }
            if (this._cutePetList.playerCutePet)
            {
                _loc_3.push(this._cutePetList.playerCutePet);
            }
            if (_playerRole && _playerRole.info)
            {
                _playerRole.info.currentSkill = null;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            if (this._roleList)
            {
                this._roleList.reset();
            }
            if (_playerRole)
            {
                _playerRole.removeEvtListener(RoleEvent.ARRIVE, this.__arrive);
            }
            _playerRole = null;
            if (this._cutePetList)
            {
                this._cutePetList.reset();
                this._cutePetList.playerCutePet = null;
            }
            if (this._magicBookRoleList)
            {
                this._magicBookRoleList.reset();
                this._magicBookRoleList.playerMagicBook = null;
            }
            super.finalize();
            return;
        }// end function

        public function get dropGoods() : Vector.<DropIcon>
        {
            return this._dropGoods;
        }// end function

        private function _addDropToList(param1:DropIcon) : void
        {
            if (AutoFightManager.getInstance().isAutoFighting() && param1 && param1.dropInfo && PropUtil.isRare(param1.dropInfo.itemModelId) && MapControl.getInstance().checkCanTakeUpGoodByOwner(param1.dropInfo))
            {
                AutoFightManager.getInstance().pickRareItem(param1);
            }
            this._dropGoods.push(param1);
            this._setDropListCheck(true);
            return;
        }// end function

        private function _removeDropToList(param1:int) : void
        {
            this._dropGoods.splice(param1, 1);
            if (this._dropGoods.length > 0)
            {
                this._setDropListCheck(true);
            }
            else
            {
                this._setDropListCheck(false);
            }
            return;
        }// end function

        private function _resetDropList() : void
        {
            this._dropGoods = new Vector.<DropIcon>;
            this._setDropListCheck(false);
            return;
        }// end function

        private function _resetBossReliveList() : void
        {
            var _loc_1:* = null;
            if (this._bossReliveList && this._bossReliveList.length)
            {
                for each (_loc_1 in this._bossReliveList)
                {
                    
                    if (_loc_1.parent)
                    {
                        _loc_1.parent.removeChild(_loc_1);
                    }
                    _loc_1.finalize();
                }
            }
            this._bossReliveList = new Vector.<BossReliveItem>;
            return;
        }// end function

        private function _setDropListCheck(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this._dropTimerStr)
                {
                    this._dropTimerStr = TimerManager.registerTimer(1, 0, this._checkDropList);
                }
            }
            else if (this._dropTimerStr)
            {
                TimerManager.killTimer(this._dropTimerStr);
                this._dropTimerStr = null;
            }
            return;
        }// end function

        private function _checkDropList(event:TimerManagerEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._dropGoods && this._dropGoods.length)
            {
                for each (_loc_2 in this._dropGoods)
                {
                    
                    _loc_3 = _loc_2.dropInfo;
                    if (_loc_3.ownerId.length > 0 && _loc_3.dropTime.toNumber() + 30000 < ToolKit.getServerTime())
                    {
                        _loc_3.ownerId = new Vector.<long>;
                    }
                }
            }
            return;
        }// end function

    }
}
