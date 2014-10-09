package com.game.player.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import com.game.autopk.controller.*;
    import com.game.backpack.control.*;
    import com.game.country.control.*;
    import com.game.expireguide.control.*;
    import com.game.fight.control.*;
    import com.game.fight.view.*;
    import com.game.login.control.*;
    import com.game.magicbook.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.npc.message.*;
    import com.game.player.message.*;
    import com.game.player.model.*;
    import com.game.player.protocol.*;
    import com.game.player.view.*;
    import com.game.primaryrole.control.*;
    import com.game.primaryrole.view.*;
    import com.game.prompt.message.*;
    import com.game.redfortress.control.*;
    import com.game.role.*;
    import com.game.shop.control.*;
    import com.game.sound.control.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.platform.*;
    import com.staticdata.*;
    import flash.geom.*;
    import interfaces.role.*;

    public class PlayerControl extends Object
    {
        private var _roleBox:PlayerMainBox;
        private var _reliveBox:ReliveBox;
        private var _roleList:RoleList;
        private var _protocol:PlayerProtocol;
        public var remainTime:int = 30;
        private var delayFun:Function;
        private var _pkTips:PKTips;
        private var hasInit:Boolean = false;
        private static var instance:PlayerControl;

        public function PlayerControl()
        {
            this.delayFun = function () : void
            {
                var _loc_1:* = this;
                var _loc_2:* = this.remainTime - 1;
                _loc_1.remainTime = _loc_2;
                return;
            }// end function
            ;
            this._roleList = RoleList.getInstance();
            this._protocol = new PlayerProtocol();
            return;
        }// end function

        public function playerAttributeChangeHandler(param1:ResPlayerAttributeChangeMessage) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_3:* = param1.attributeChangeList.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2.setAttributte(param1.attributeChangeList[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        public function playerInfoHandler(param1:ResMyPlayerInfoMessage) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo;
            _loc_2.myPlayerInfo = param1;
            Platform.instance.onPlayerInfoReceived();
            UserObj.getInstance().backpackInfo.cellNum = param1.cellnum;
            UserObj.getInstance().backpackInfo.cellTime = param1.cellTime;
            UserObj.getInstance().backpackInfo.openningGridId = param1.gridId;
            UserObj.getInstance().backpackInfo.data = param1.items;
            BackPackControl.getInstance().addCD();
            BackPackControl.getInstance().cellTimeRes();
            var _loc_3:* = new EquipsInfo();
            _loc_3.data = param1.equips;
            EquipsObj.getInstance().info = _loc_3;
            PlayerConfig.getInstance().value = param1.config;
            SoundControl.getInstance().setting(PlayerConfig.getInstance().getValue(PlayerConfig.SOUND_SETTING));
            MagicBookData.parse(param1);
            if (!this._roleBox)
            {
                this._roleBox = new PlayerMainBox();
                Global.mainUIManager.addUI(this._roleBox, null, GroupPanelType.GROUP_LEVEL1);
            }
            if (!SelectRoleControl.getInstance().hasInit)
            {
            }
            this.checkNeedRegPlat();
            ExpireGuideControl.getInstance().checkBackpack();
            return;
        }// end function

        public function reqForPlayer(param1:long, param2:String = "role") : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                switch(param2)
                {
                    case OtherRoleMainPanel.ROLE:
                    {
                        PrimaryRoleControl.getInstance().openPrimayRoleMain();
                        break;
                    }
                    case OtherRoleMainPanel.HORSE:
                    {
                        PrimaryRoleControl.getInstance().openHorse();
                        break;
                    }
                    case OtherRoleMainPanel.ARTIFACT:
                    {
                        PrimaryRoleControl.getInstance().openArtifact();
                        break;
                    }
                    case OtherRoleMainPanel.MAGICBOOK:
                    {
                        PrimaryRoleControl.getInstance().openMagicBook();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }
            var _loc_3:* = new PlayerInfo();
            _loc_3.personId = param1;
            OtherRoleControl.getInstance().openOtherRoleMainPanel(_loc_3, param2);
            return;
        }// end function

        public function reqFinishThreeChangeJob() : void
        {
            this._protocol.reqFinishThreeChangeJob();
            return;
        }// end function

        public function resFinishThreeChangeJob(param1:ResFinishThreeChangeJobMessage) : void
        {
            var _loc_2:* = null;
            if (param1.result)
            {
                _loc_2 = ChangeJobControl.getInstance().changeJobBox;
                if (_loc_2 && _loc_2.isOpen)
                {
                    _loc_2.close();
                }
                if (UserObj.getInstance().playerInfo.level < 350)
                {
                    MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
                }
            }
            return;
        }// end function

        public function saveConfig(param1:int, param2:int) : void
        {
            PlayerConfig.getInstance().setValue(param2, param1);
            this._protocol.saveConfig(PlayerConfig.getInstance().value);
            return;
        }// end function

        public function transaction(param1:RoleInfo) : void
        {
            if (!this._roleBox)
            {
                this._roleBox = new PlayerMainBox();
                Global.mainUIManager.addUI(this._roleBox);
            }
            return;
        }// end function

        public function clickPlayerMainBoxImage() : void
        {
            PrimaryRoleControl.getInstance().openPrimayRoleMain();
            return;
        }// end function

        public function playerAvatarHandler(param1:ResPlayerAvatarMessage) : void
        {
            return;
        }// end function

        public function getPlayerBoxGloblePoint() : Point
        {
            if (this._roleBox)
            {
                return this._roleBox.localToGlobal(new Point(0, 0));
            }
            return new Point(0, 0);
        }// end function

        public function playerExpChangeHandler(param1:ResPlayerExpChangeMessage) : void
        {
            UserObj.getInstance().playerInfo.exp = param1.currentExp;
            return;
        }// end function

        public function playerJobChangeHandler(param1:ResPlayerChangeJobMessage) : void
        {
            UserObj.getInstance().playerInfo.job = param1.job;
            UserObj.getInstance().playerInfo.unallocatedTalent = UserObj.getInstance().playerInfo.unallocatedTalent + param1.addbase;
            return;
        }// end function

        public function playerRoundJobChangeHandler(param1:ResRoundChangeJobMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_2.info.job = param1.job;
            }
            return;
        }// end function

        public function playerLevelUpHandler(param1:ResPlayerLevelUpMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2 && _loc_2.info)
            {
                _loc_2.info.level = param1.currentLevel;
            }
            this.checkNeedRegPlat();
            return;
        }// end function

        private function checkNeedRegPlat() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo;
            if (Params.needPlatReg && _loc_1.level >= Params.GUEST_REG_LEVEL)
            {
                RegistControl.getInstance().openPlatRegistPanel();
            }
            return;
        }// end function

        public function playerDieHandler(param1:ResPlayerDieMessage) : void
        {
            var job:int;
            var type:int;
            var msg:* = param1;
            var r1:* = this._roleList.getRole(msg.personId);
            var temp:* = r1 as Player;
            Log.log("受攻击者[" + msg.personId + "]" + r1 ? ("存在") : ("不存在"));
            if (r1)
            {
                r1.stopPath();
                r1.dead();
                if (r1.isPlayer())
                {
                    job = r1.info.job;
                    if (job % 3 == 1)
                    {
                        SoundControl.getInstance().playSound(SoundFlag.DIE_WARRIOR);
                    }
                    else if (job % 3 == 2)
                    {
                        SoundControl.getInstance().playSound(SoundFlag.DIE_MAGICER);
                    }
                    else if (job % 3 == 0)
                    {
                        SoundControl.getInstance().playSound(SoundFlag.DIE_BOWMAN);
                    }
                }
                if (r1.isUser())
                {
                    FightControl.getInstance().delCurrentSkill();
                    UserObj.getInstance().selectRole = null;
                    DieLogic.die();
                    type = MapObj.getInstance().isZonesMap();
                    if (ZonesControl.getInstance().inBossHome())
                    {
                        ZonesControl.getInstance().openBossHomeDefeatPanel();
                        return;
                    }
                    if (type > 0)
                    {
                        if (type == ZoneType.ZONES_RED_FORTRESS)
                        {
                            ZonesRedFortressControl.getInstance().openRedDortressRelive(10);
                        }
                        else if (type == ZoneType.ZONES_ANGEL)
                        {
                            ZonesRedFortressControl.getInstance().openRedDortressRelive(10);
                        }
                        else if (type == ZoneType.ZONES_COUNTRY)
                        {
                            this.openOrCloseReliveBox({attackername:msg.attackername, dieTime:msg.time});
                        }
                        else if (type == ZoneType.ZONES_BELIAL_WORLD)
                        {
                            Ticker.registerTimer(1, null, function () : void
            {
                PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
                return;
            }// end function
            , 1);
                            ZonesControl.getInstance().openZonesDefeatPanel();
                        }
                        else if (type == ZoneType.ZONES_DELARON)
                        {
                            ZonesRedFortressControl.getInstance().openRedDortressRelive(3);
                        }
                        else if (type == ZoneType.ZONES_XS)
                        {
                            Ticker.registerTimer(1, null, function () : void
            {
                PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
                return;
            }// end function
            , 1);
                            ZonesControl.getInstance().openZonesDefeatPanel();
                        }
                        else if (type == ZoneType.ZONES_ISLAND)
                        {
                            Ticker.registerTimer(1, null, function () : void
            {
                PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
                return;
            }// end function
            , 1);
                            ZonesControl.getInstance().openZonesDefeatPanel();
                        }
                        else
                        {
                            Ticker.registerTimer(1, null, function () : void
            {
                PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
                return;
            }// end function
            , 1);
                        }
                    }
                    else
                    {
                        this.openOrCloseReliveBox({attackername:msg.attackername, dieTime:msg.time});
                    }
                }
            }
            return;
        }// end function

        public function openOrCloseReliveBox(param1:Object) : void
        {
            if (!this._reliveBox)
            {
                this._reliveBox = new ReliveBox();
            }
            this.remainTime = 30;
            Ticker.registerTimer(1, this.delayFun, null, this.remainTime);
            this._reliveBox.initData(param1);
            Global.popManager.addPop(this._reliveBox, true, true);
            Global.popManager.hideAllBox();
            this._reliveBox.openOrClose();
            return;
        }// end function

        public function updateplayerMaxHpChange(param1:ResPlayerMaxHpChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                _loc_2.info.HP = param1.currentHp;
                _loc_2.info.HPMax = param1.maxHp;
            }
            return;
        }// end function

        public function updateplayerMaxMpChange(param1:ResPlayerMaxMpChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                _loc_2.info.MP = param1.currentMp;
                _loc_2.info.MPMax = param1.maxMp;
            }
            return;
        }// end function

        public function reqRevive(param1:int, param2:int = 0) : void
        {
            if (param1 == AutoReviveType.RETURN_REVIVE)
            {
                this._protocol.revive();
            }
            else if (param1 == AutoReviveType.AUTO_REVIVE)
            {
                this._protocol.localRevive(param2, 1);
            }
            return;
        }// end function

        public function reviveSuccessHandler(param1:ResReviveSuccessMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                _loc_2.revive();
                if (_loc_2.isUser() && this._reliveBox)
                {
                    Global.popManager.removeBgMask();
                    this._reliveBox.reliveType = param1.reason;
                    this._reliveBox.close();
                    Ticker.killTimer(this.delayFun);
                    DieLogic.revive();
                }
            }
            return;
        }// end function

        public function playerHpChangeHandler(param1:ResPlayerHpChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.HP = param1.currentHp;
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function playerMpChangeHandler(param1:ResPlayerMpChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.MP = param1.currentMp;
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function updateTitle(param1:long, param2:int) : void
        {
            var _loc_3:* = null;
            if (param1 == null)
            {
                _loc_3 = this._roleList.player;
            }
            else
            {
                _loc_3 = this._roleList.getRole(param1);
            }
            if (_loc_3)
            {
                if (_loc_3.info)
                {
                    if (_loc_3.info.topTitleId != param2)
                    {
                        _loc_3.info.topTitleId = param2;
                        _loc_3.updateTitleImg();
                    }
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function updateSuitEffect(param1:ResSuitEffectMessage) : void
        {
            var _loc_2:* = null;
            if (param1.playerId == null)
            {
                _loc_2 = this._roleList.player;
            }
            else
            {
                _loc_2 = this._roleList.getRole(param1.playerId);
            }
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.suitEffectCount = param1.suitEffectCount;
                    _loc_2.info.suitEffectIds = param1.suitEffectIds;
                    param1.suitEffectIds = null;
                    if (_loc_2.isShow)
                    {
                        _loc_2.updateSuitEffect();
                    }
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function updateVIPBuff() : void
        {
            if (this._roleBox)
            {
                this._roleBox.updateVIPBuff();
            }
            return;
        }// end function

        public function updateStoneNum() : void
        {
            if (!this._reliveBox)
            {
                return;
            }
            this._reliveBox.updateStoneNume();
            return;
        }// end function

        public function playerStateChangeHandler(param1:ResPlayerStateChangeMessage) : void
        {
            UserObj.getInstance().playerInfo.fightState = param1.state;
            return;
        }// end function

        public function playerNonageHanlder(param1:ResPlayerNonageTimeMessage) : void
        {
            if (BasicGlobal.will)
            {
                return;
            }
            if (param1.time > 5 * 3600)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12150"), "", null, null, null, 1);
            }
            else if (param1.time > 4.5 * 3600)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12151"), "", null, null, null, 1);
            }
            else if (param1.time > 4 * 3600)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12152"), "", null, null, null, 1);
            }
            else if (param1.time > 12600)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12153"), "", null, null, null, 1);
            }
            else if (param1.time > 10800)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12154"), "", null, null, null, 1);
            }
            else if (param1.time > 7200)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12155"), "", null, null, null, 1);
            }
            else if (param1.time > 3600)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12156"), "", null, null, null, 1);
            }
            else
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12157"), "", null, null, null, 1);
            }
            return;
        }// end function

        public function playerPKValueChangeHandler(param1:ResPlayerPkValueChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.pkValue = param1.currentPkValue;
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function get pkTips() : PKTips
        {
            if (!this._pkTips)
            {
                this._pkTips = new PKTips();
                this._pkTips.visible = false;
            }
            return this._pkTips;
        }// end function

        public function playerEnemiesChangeHandler(param1:ResChangePlayerEnemiesToClientMessage) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.enemies;
            var _loc_3:* = 0;
            while (_loc_3 < param1.enemies.length)
            {
                
                _loc_4 = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_2.length)
                {
                    
                    if (_loc_2[_loc_5].equal(param1.enemies[_loc_3]))
                    {
                        _loc_4 = true;
                    }
                    _loc_5++;
                }
                if (!_loc_4)
                {
                    _loc_6 = RoleList.getInstance().getRole(param1.enemies[_loc_3]);
                    _loc_7 = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
                    if (_loc_6 && MapObj.getInstance().mapID != 300010 && _loc_7.zones_type != ZoneType.ZONES_RED_FORTRESS)
                    {
                        this.pkTips.visible = true;
                        this.pkTips.setInfo(_loc_6);
                    }
                }
                _loc_3++;
            }
            UserObj.getInstance().playerInfo.enemies = param1.enemies;
            return;
        }// end function

        public function playerGuildChangeHandler(param1:ResPlayerGuildChangeMessage) : void
        {
            var _loc_2:* = this._roleList.getRole(param1.personId);
            if (_loc_2)
            {
                if (_loc_2.info)
                {
                    _loc_2.info.guildName = param1.guildName;
                    if (param1.guildId && param1.guildId.equal(new long(0, 0)))
                    {
                        _loc_2.info.guildId = null;
                    }
                    else
                    {
                        _loc_2.info.guildId = param1.guildId;
                    }
                }
                else
                {
                    Log.error("角色的info为空");
                }
            }
            return;
        }// end function

        public function playerStopGatherHandler(param1:ResStopGatherMessage) : void
        {
            if (UserObj.getInstance().playerInfo.personId.equal(param1.personId))
            {
                CountryControl.getInstance().stopGather();
            }
            return;
        }// end function

        public function nonageHanlder(param1:NonagePromptMessage) : void
        {
            Global.popManager.cue(param1.content, "", null, null, null, 1);
            return;
        }// end function

        public function setPlayerMainBoxEnable(param1:Boolean) : void
        {
            if (this._roleBox)
            {
                this._roleBox.setPlayerMainBoxEnable(param1);
            }
            return;
        }// end function

        public function setRateMcVisible(param1:Boolean) : void
        {
            if (this._roleBox)
            {
                this._roleBox.setRateMcVisible(param1);
            }
            return;
        }// end function

        public function setRateText(param1:String) : void
        {
            if (this._roleBox)
            {
                this._roleBox.setRateText(param1);
            }
            return;
        }// end function

        public function openBannerTips() : void
        {
            var _loc_1:* = "<font color=\'#F0ECE0\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12158"), [UserObj.getInstance().playerInfo.pkValue]) + "\n" + LanguageCfgObj.getInstance().getByIndex("10997") + "</font>";
            Global.popManager.cue(_loc_1, LanguageCfgObj.getInstance().getByIndex("10998"), null, null, null, 1);
            if (!this.hasInit)
            {
                this.hasInit = true;
                FrameworkGlobal.stage.addEventListener(SysCueEvent.LINK, this.openStore);
            }
            return;
        }// end function

        private function openStore(event:SysCueEvent = null) : void
        {
            var _loc_2:* = null;
            if (event.data == "openStore")
            {
                _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(700049);
                ShopController.getInstance().openBuyItem(_loc_2);
            }
            return;
        }// end function

        public function get roleBox() : PlayerMainBox
        {
            return this._roleBox;
        }// end function

        public static function getInstance() : PlayerControl
        {
            if (instance == null)
            {
                instance = new PlayerControl;
            }
            return instance;
        }// end function

    }
}
