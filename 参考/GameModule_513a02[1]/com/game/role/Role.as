package com.game.role
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.effect.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.scrollmc.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.buff.message.*;
    import com.game.country.control.*;
    import com.game.country.events.*;
    import com.game.country.model.*;
    import com.game.fight.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.role.model.*;
    import com.game.role.util.*;
    import com.game.role.view.*;
    import com.game.sound.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.game.zones.control.*;
    import com.game.zones.view.bosshome.cfg.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class Role extends SimpleRole implements IRole
    {
        protected var _stopWhenEffect:Boolean;
        protected var _stopWhenRelease:Boolean;
        protected var _excursion_y:int = 50;
        private var _pracStarVmcView:VMCView;
        private var _loginVmcView:VMCView;
        protected var _cutePet:CutePetInfo;
        protected var _magicBookInfo:MagicBookInfo;
        protected var _alwaysShowBloodStripe:Boolean = true;
        private var _bloodStripe:BloodStripe;
        private var textHeight:uint = 22;
        private var pracTxt:Bitmap;
        private var _nameTxt:Bitmap;
        private var guildTxt:Bitmap;
        private var countryFightMC:MovieClip;
        private var lsMC:MovieClip;
        private var bompMC:MovieClip;
        private var _titleImg:VMCView;
        private var _topSuitEffectVmc:VMCView;
        private var _bottomSuitEffectVmc:VMCView;
        private var _nobImg:VMCView;
        private var _vmcMonstBottom:VMCView;
        private var _stat:String;
        protected var _fightObj:FightObj;
        private var _csysDesignName:BaseSprite;
        private var _csysDesignImg:Image;
        private var _countryName:BaseSprite;
        private var _countryImg:Image;
        private var _attackDefenceImg:Image;
        public var _bossDropImg:Image;
        private var _roleLevelIcon:VMCView;
        private var _monsterTypeImg:Image;
        private var _csysDesignTxt:TextField;
        private var _csysKillImg:Image;
        private var _csysKillNum:ImgNumber;
        private var blood_num:ImgNumber;
        private var teamSign:Bitmap;
        private var guildSign:MovieClip;
        private var _isZonesMorph:Boolean;
        private var _isInSkillShunyi:Boolean = false;
        private var _oldWeapon:ItemCfg;
        private var _oldWeapon_other:ItemCfg;
        private var _oldWingInfo:ItemCfg;
        private var _oldArmor:ItemCfg;
        private var _angerSprite:BaseSprite;
        private var _angerImg:Image;
        private var _angerTxt:Sprite;
        private var buffviews:Dictionary;
        private var curShowBuffEffectRes:VMCView;
        private var countryMonsterID:Array;
        private static const nameFormat:TextFormat = new TextFormat("宋体", 12, null);
        private static const guildFormat:TextFormat = new TextFormat("宋体", 12, null, false);

        public function Role()
        {
            this.countryMonsterID = [130041003, 130041004, 130041005, 130041006, 130041007, 130041008, 130041009, 1300410013, 1300410014, 130041015, 130041016, 130041017, 130041018, 130041019, 1300410023, 1300410024, 130041025, 130041026, 130041027, 130041028, 130041029, 1300410033, 1300410034, 130041035, 130041036, 130041037, 130041038, 130041039];
            this._fightObj = FightObj.getInstance();
            _bodyView.addEvtListener(VMCEvent.ACT_EFECT, this.__actEffect);
            _bodyView.addEvtListener(VMCEvent.ACT_RELEASE, this.__actRelease);
            this.initUI();
            return;
        }// end function

        public function get magicBookInfo() : MagicBookInfo
        {
            return this._magicBookInfo;
        }// end function

        public function get stopWhenEffect() : Boolean
        {
            return this._stopWhenEffect;
        }// end function

        public function set stopWhenEffect(param1:Boolean) : void
        {
            this._stopWhenEffect = param1;
            return;
        }// end function

        public function get stopWhenRelease() : Boolean
        {
            return this._stopWhenRelease;
        }// end function

        public function set stopWhenRelease(param1:Boolean) : void
        {
            this._stopWhenRelease = param1;
            return;
        }// end function

        public function set alwaysShowBloodStripe(param1:Boolean) : void
        {
            if (!isPlayer() && !isCreamMonster() && !isBossMonster())
            {
                this._alwaysShowBloodStripe = param1;
                if (param1)
                {
                    this.showBloodStripe();
                }
                else
                {
                    this.hideBloodStripe();
                }
            }
            return;
        }// end function

        public function get alwaysShowBloodStripe() : Boolean
        {
            return this._alwaysShowBloodStripe;
        }// end function

        private function initUI() : void
        {
            CountryData.getInstance().addEvtListener(CountryEvent.COUNTRY_CAPTURE_CHANGE, this.showHideCountryFightMC);
            this.showHideCountryFightMC();
            return;
        }// end function

        private function __updateGuildName(event:Event = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!info)
            {
                return;
            }
            if (info.guildId)
            {
                if (isUser())
                {
                    var _loc_4:* = 6863384;
                    nameFormat.color = 6863384;
                    guildFormat.color = _loc_4;
                }
                else if (isSummonPet())
                {
                    guildFormat.color = 4749055;
                }
                else
                {
                    guildFormat.color = 6863384;
                }
                if (!this.guildTxt)
                {
                    this.guildTxt = TxtImage.getTxtImage("[" + LanguageCfgObj.getInstance().getByIndex("12178") + "]" + info.guildName, guildFormat);
                    this.guildTxt.x = -int(this.guildTxt.width / 2);
                    if (this._bloodStripe.parent)
                    {
                        if (!this.isZonesMorph)
                        {
                            addChild(this.guildTxt);
                        }
                    }
                }
            }
            else
            {
                if (this.guildTxt && this.guildTxt.parent)
                {
                    this.guildTxt.parent.removeChild(this.guildTxt);
                }
                this.guildTxt = null;
            }
            this.updateNameY();
            if (isUser())
            {
                _loc_2 = RoleList.getInstance().roles;
                for each (_loc_3 in _loc_2)
                {
                    
                    _loc_3.showIsSameGuild();
                }
            }
            else
            {
                this.showIsSameGuild();
            }
            return;
        }// end function

        private function __updateRoleNameColor(event:Event = null) : void
        {
            if (!info)
            {
                return;
            }
            if (info.name)
            {
                if (info.pkValue >= 1)
                {
                    nameFormat.color = 16711680;
                }
                else if (isUser())
                {
                    nameFormat.color = 13936737;
                }
                else if (isSummonPet())
                {
                    nameFormat.color = 4749055;
                }
                else
                {
                    nameFormat.color = 15264489;
                }
                if (this._nameTxt.parent)
                {
                    this._nameTxt.parent.removeChild(this._nameTxt);
                }
                this._nameTxt = TxtImage.getTxtImage(info.name, nameFormat);
                this._nameTxt.x = -int(this._nameTxt.width / 2);
                this.updateNameY();
                if (!this.isZonesMorph || isUser())
                {
                    addChild(this._nameTxt);
                }
            }
            return;
        }// end function

        private function __updateRoleNameColorByCountryState() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = false;
            if (!info)
            {
                return;
            }
            if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID)
            {
                return;
            }
            if (!info.guildId)
            {
                return;
            }
            if (info.name)
            {
                _loc_1 = CountryData.getInstance().curentCaptureID;
                _loc_2 = UserObj.getInstance().playerInfo.guildId;
                _loc_3 = _loc_2 && _loc_2.equal(_loc_1);
                _loc_4 = info.guildId.equal(_loc_1);
                if (isUser())
                {
                    nameFormat.color = 13936737;
                }
                else if (_loc_3 == _loc_4)
                {
                    nameFormat.color = 16777215;
                }
                else
                {
                    nameFormat.color = 16711680;
                }
                if (this._nameTxt.parent)
                {
                    this._nameTxt.parent.removeChild(this._nameTxt);
                }
                if (_loc_4)
                {
                    if (!this._attackDefenceImg)
                    {
                        this._attackDefenceImg = new Image();
                    }
                    this._attackDefenceImg.load("res/image/countryIcon/defence.png");
                }
                else
                {
                    if (!this._attackDefenceImg)
                    {
                        this._attackDefenceImg = new Image();
                    }
                    this._attackDefenceImg.load("res/image/countryIcon/attack.png");
                }
                this._nameTxt = TxtImage.getTxtImage(info.name, nameFormat);
                this._nameTxt.x = (-int(this._nameTxt.width + 24)) / 2 + 24;
                this._attackDefenceImg.x = (-int(this._nameTxt.width + 24)) / 2;
                addChild(this._attackDefenceImg);
                if (!this.isZonesMorph || isUser())
                {
                    addChild(this._nameTxt);
                }
                this.updateNameY();
            }
            return;
        }// end function

        public function addBossDamageIcon() : void
        {
            this._bossDropImg = new Image();
            this._bossDropImg.load("res/image/boss/box.png", null, null, null, true);
            if (this._roleLevelIcon)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 44)) / 2 + 44;
                this._bossDropImg.x = (-int(this._nameTxt.width + 44)) / 2;
                this._bossDropImg.y = this._nameTxt.y;
            }
            else
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
                this._bossDropImg.x = (-int(this._nameTxt.width + 22)) / 2;
                this._bossDropImg.y = this._nameTxt.y;
            }
            if (!this._bossDropImg.parent)
            {
                addChild(this._bossDropImg);
            }
            return;
        }// end function

        public function removeBossDamageIcon() : void
        {
            if (this._bossDropImg)
            {
                if (this._bossDropImg.parent)
                {
                    this._bossDropImg.parent.removeChild(this._bossDropImg);
                }
                this._bossDropImg.dispose();
            }
            if (this._roleLevelIcon)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
            }
            else
            {
                this._nameTxt.x = (-this._nameTxt.width) / 2;
            }
            this.updateNameY();
            return;
        }// end function

        public function setBossDamageIconNull() : void
        {
            if (this._bossDropImg)
            {
                if (this._bossDropImg.parent)
                {
                    this._bossDropImg.parent.removeChild(this._bossDropImg);
                }
                this._bossDropImg.dispose();
                this._bossDropImg = null;
            }
            this.updateNameY();
            return;
        }// end function

        private function __updateCsysKills(event:Event) : void
        {
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                this.showCountryTitle();
            }
            else
            {
                this.showCsysDesignation();
            }
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            super.info = param1;
            if (!isPlayer() && !isCreamMonster() && !isBossMonster())
            {
                this._alwaysShowBloodStripe = false;
            }
            this.info.addEvtListener(RoleEvent.UPDATE_PK_VALUE, this.__updateRoleNameColor);
            this.info.addEvtListener(RoleEvent.UPDATE_EXP, this.showExpNum);
            this.info.addEvtListener(RoleEvent.UPDATE_DU, this.showDuNum);
            this.info.addEvtListener(RoleEvent.UPDATE_BECOME, this.showBompMC);
            this.info.addEvtListener(RoleEvent.UPDATE_GUILD_ID, this.__updateGuildName);
            this.info.addEvtListener(RoleEvent.UPDATE_CSYS_KILLS, this.__updateCsysKills);
            this.info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
            if (isUser())
            {
                FrameworkGlobal.addMsgListen("hideTitle", this.__hideTitle);
            }
            if (_info.roleType == RoleType.ROLE_TYPE_PLAYER && !isUser())
            {
                FrameworkGlobal.addMsgListen(GameEvent.SHOW_OR_HIDE_PLAYERS, this.__showOrHidePlayers);
            }
            if (_info.roleType == RoleType.ROLE_TYPE_MONSTER)
            {
                FrameworkGlobal.addMsgListen(GameEvent.SHOW_OR_HIDE_MONSTER, this.__showOrHideMonster);
            }
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2 && _loc_2.zones_type == ZoneType.ZONES_COUNTRY)
            {
                FrameworkGlobal.addMsgListen(GameEvent.OTHER_NORMAL_MODEL, this.__showOtherNormalModel);
            }
            if (_loc_2.zones_type == ZoneType.ZONES_COUNTRY && UICfg.OTHER_NORMAL_MODEL)
            {
                this.__showOtherNormalModel(null);
            }
            if (isMonster() && UICfg.NORMAL_MONSTER)
            {
                this.__showOrHideMonster(null);
            }
            if (!this._bloodStripe)
            {
                this._bloodStripe = new BloodStripe();
                this._bloodStripe.x = -int(this._bloodStripe.width / 2);
            }
            if (this._bloodStripe)
            {
                this._bloodStripe.info = param1;
            }
            if (param1.guildName)
            {
                if (isUser())
                {
                    var _loc_9:* = 6863384;
                    nameFormat.color = 6863384;
                    guildFormat.color = _loc_9;
                }
                else if (isSummonPet())
                {
                    guildFormat.color = 4749055;
                }
                else
                {
                    guildFormat.color = 6863384;
                }
                if (!this.guildTxt)
                {
                    this.guildTxt = TxtImage.getTxtImage("[" + LanguageCfgObj.getInstance().getByIndex("12178") + "]" + param1.guildName, guildFormat);
                    this.guildTxt.x = -int(this.guildTxt.width / 2);
                    addChild(this.guildTxt);
                }
            }
            if (param1.name)
            {
                if (isMonster())
                {
                    _loc_3 = UserObj.getInstance().playerInfo.level;
                    _loc_4 = param1.level;
                    _loc_5 = 0;
                    if (_info.monster_type == MonsterType.MONSTER_NORMAL || _info.monster_type == MonsterType.MONSTER_CREAM)
                    {
                        _loc_5 = GlobalCfgObj.getInstance().getMousterLevel1();
                    }
                    else if (_info.monster_type == MonsterType.MONSTER_BOSS)
                    {
                        _loc_5 = GlobalCfgObj.getInstance().getMousterLevel4();
                    }
                    _loc_6 = GlobalCfgObj.getInstance().getMousterLevel2();
                    _loc_7 = GlobalCfgObj.getInstance().getMousterLevel3();
                    if (_loc_3 - _loc_4 > _loc_5)
                    {
                        nameFormat.color = 7105644;
                    }
                    else if (_loc_3 - _loc_4 >= 0 && _loc_3 - _loc_4 <= _loc_5 || _loc_4 - _loc_3 >= 0 && _loc_4 - _loc_3 <= _loc_6)
                    {
                        nameFormat.color = 16777215;
                    }
                    else if (_loc_4 - _loc_3 >= _loc_6 && _loc_4 - _loc_3 <= _loc_7)
                    {
                        nameFormat.color = 16738408;
                    }
                    else if (_loc_4 - _loc_3 >= _loc_7)
                    {
                        nameFormat.color = 16711680;
                    }
                    _loc_8 = param1.name + "[" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [param1.level]) + "]";
                    if (isCreamMonster() && _loc_2.zones_type != ZoneType.ZONES_RED_FORTRESS)
                    {
                        if (!this._monsterTypeImg)
                        {
                            this._monsterTypeImg = new Image();
                        }
                        this._monsterTypeImg.load("art/res/item/i10197.png");
                        this._nameTxt = TxtImage.getTxtImage(_loc_8, nameFormat);
                        this._nameTxt.x = (-int(this._nameTxt.width + 29)) / 2 + 29;
                        this._monsterTypeImg.x = (-int(this._nameTxt.width + 29)) / 2;
                        addChild(this._monsterTypeImg);
                    }
                    else if (isBossMonster() && _loc_2.zones_type != ZoneType.ZONES_RED_FORTRESS)
                    {
                        if (!this._monsterTypeImg)
                        {
                            this._monsterTypeImg = new Image();
                        }
                        this._monsterTypeImg.load("art/res/item/i10196.png");
                        this._nameTxt = TxtImage.getTxtImage(_loc_8, nameFormat);
                        this._nameTxt.x = (-int(this._nameTxt.width + 47)) / 2 + 47;
                        this._monsterTypeImg.x = (-int(this._nameTxt.width + 47)) / 2;
                        addChild(this._monsterTypeImg);
                    }
                    else
                    {
                        this._nameTxt = TxtImage.getTxtImage(_loc_8, nameFormat);
                        this._nameTxt.x = -int(this._nameTxt.width / 2);
                    }
                }
                else
                {
                    if (isUser())
                    {
                        nameFormat.color = 13936737;
                    }
                    else if (isSummonPet())
                    {
                        nameFormat.color = 4749055;
                    }
                    else
                    {
                        nameFormat.color = 15264489;
                    }
                    _loc_8 = param1.name;
                    this._nameTxt = TxtImage.getTxtImage(_loc_8, nameFormat);
                    this._nameTxt.x = -int(this._nameTxt.width / 2);
                }
                if (MapObj.getInstance().mapID == Params.BOSS_HOME_CITY_MAP)
                {
                    this.showAngerTitle();
                }
            }
            if (!isMonster())
            {
                this.__updateRoleNameColor();
            }
            if (this._alwaysShowBloodStripe && (isPlayer() || isCreamMonster() || isBossMonster()))
            {
                this.showBloodStripe();
            }
            if (param1.sculpt_zoom > 0)
            {
                this._bodyView.scale = param1.sculpt_zoom / 10000;
            }
            if (isMonster() && param1.monster_type == 3)
            {
                if (_loc_2.mapZones && _loc_2.zones_type == ZoneType.ZONES_DELARON)
                {
                    this.showBottomFlash(true);
                }
            }
            if (_isShow)
            {
                this.updateTitleImg();
            }
            this.updateSuitEffect();
            this.updateNameY();
            this.setStateIcon(Params.SCENE_LOGIN);
            if (_isPathing)
            {
                param1.actType = Params.ACTION_RUN;
            }
            if (_info.buffs.length > 0)
            {
                this.updateBuffView();
            }
            if (isMonster())
            {
                if (_info.q_mouse == 1)
                {
                    var _loc_9:* = false;
                    this.mouseEnabled = false;
                    this.mouseChildren = _loc_9;
                }
                else
                {
                    var _loc_9:* = true;
                    this.mouseEnabled = true;
                    this.mouseChildren = _loc_9;
                }
            }
            this.showIsCommonTeam();
            this.showIsSameGuild();
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                this.showCountryTitle();
            }
            this.resetCutePet();
            this.resetMagicBook();
            if (isPlayer())
            {
                this.__updateLevel(null);
            }
            return;
        }// end function

        private function __updateLevel(event:Event) : void
        {
            var _loc_2:* = 0;
            if (isPlayer())
            {
                _loc_2 = _info.level;
                if (RoleLevelUtil.isMasterLevel(_loc_2))
                {
                    this.showRoleLevelIcon();
                }
                else
                {
                    this.removeRoleLevelIcon();
                }
            }
            return;
        }// end function

        private function removeRoleLevelIcon() : void
        {
            if (this._bossDropImg)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
                this._bossDropImg.x = (-int(this._nameTxt.width + 22)) / 2;
            }
            else
            {
                this._nameTxt.x = (-this._nameTxt.width) / 2;
            }
            if (this._roleLevelIcon)
            {
                this._roleLevelIcon.parent.removeChild(this._roleLevelIcon);
                this._roleLevelIcon.finalize();
                this._roleLevelIcon = null;
            }
            this.updateNameY();
            return;
        }// end function

        private function showRoleLevelIcon() : void
        {
            if (!this._roleLevelIcon)
            {
                this._roleLevelIcon = new VMCView();
                this._roleLevelIcon.auto = true;
                this._roleLevelIcon.updatePose("90", true);
            }
            this._roleLevelIcon.loadRes("res/effect/bigmaster/master_sign_effect.png", null, true);
            if (this._bossDropImg)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 44)) / 2 + 44;
                this._bossDropImg.x = (-int(this._nameTxt.width + 44)) / 2;
            }
            else
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
            }
            var _loc_1:* = (-int(this._nameTxt.width + 22)) / 2;
            var _loc_2:* = this._nameTxt.y;
            if (!this._roleLevelIcon.parent)
            {
                addChild(this._roleLevelIcon);
            }
            this._roleLevelIcon.move(_loc_1 + 12, _loc_2 + 8);
            return;
        }// end function

        public function updateTitleImg() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (info.topTitleId > 0 && !this._isZonesMorph && _loc_1 && _loc_1.zones_type != ZoneType.ZONES_COUNTRY)
            {
                _loc_2 = info.topTitleId;
                if (this._titleImg == null)
                {
                    this._titleImg = new VMCView();
                }
                _loc_3 = TitleCfgObj.getInstance().getTitleById(info.topTitleId);
                this._excursion_y = _loc_3.q_excursion_y;
                this._titleImg.auto = true;
                this._titleImg.updatePose("90", true, true);
                this._titleImg.loadRes(_loc_3.url, null, ifKeep(), this.showTitleImg);
                if (this._titleImg.parent == null)
                {
                    addChild(this._titleImg);
                }
            }
            else if (this._titleImg)
            {
                this._titleImg.removeFromParent(true);
            }
            return;
        }// end function

        private function showTitleImg() : void
        {
            this._titleImg.poseInfo = VMCManager.getPoseInfo(this._titleImg.url, "90");
            this.updateNameY();
            return;
        }// end function

        public function showTitle() : void
        {
            this.updateTitleImg();
            this.updateNameY();
            return;
        }// end function

        private function __hideTitle(event:Event) : void
        {
            if (this._titleImg && this._titleImg.parent)
            {
                this._titleImg.parent.removeChild(this._titleImg);
            }
            this.updateNameY();
            return;
        }// end function

        public function updateSuitEffect() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            if (_isShow && info.suitEffectCount)
            {
                _loc_3 = false;
                _loc_4 = false;
                _loc_5 = 0;
                while (_loc_5 < info.suitEffectCount)
                {
                    
                    _loc_2 = SuitEffectCfgObj.instance.getSuitEffectCfg(info.suitEffectIds[_loc_5]);
                    if (_loc_2.q_level)
                    {
                        _loc_4 = true;
                        if (this._bottomSuitEffectVmc == null)
                        {
                            this._bottomSuitEffectVmc = new VMCView();
                        }
                        this._bottomSuitEffectVmc.auto = true;
                        this._bottomSuitEffectVmc.updatePose("90", true, true);
                        if (this._bottomSuitEffectVmc.parent == null)
                        {
                            addChildAt(this._bottomSuitEffectVmc, 0);
                        }
                        else if (getChildIndex(this._bottomSuitEffectVmc) != 0)
                        {
                            setChildIndex(this._bottomSuitEffectVmc, 0);
                        }
                        this._bottomSuitEffectVmc.loadRes(_loc_2.url, null, ifKeep());
                    }
                    else
                    {
                        _loc_3 = true;
                        if (this._topSuitEffectVmc == null)
                        {
                            this._topSuitEffectVmc = new VMCView();
                        }
                        this._topSuitEffectVmc.auto = true;
                        this._topSuitEffectVmc.updatePose("90", true, true);
                        if (this._topSuitEffectVmc.parent == null)
                        {
                            addChild(this._topSuitEffectVmc);
                        }
                        this._topSuitEffectVmc.loadRes(_loc_2.url, null, ifKeep());
                    }
                    _loc_5++;
                }
                if (_loc_3)
                {
                }
                else
                {
                    if (this._topSuitEffectVmc)
                    {
                        this._topSuitEffectVmc.removeFromParent(true);
                    }
                    this._topSuitEffectVmc = null;
                }
                if (_loc_4)
                {
                    _vIndex = 1;
                }
                else
                {
                    if (this._bottomSuitEffectVmc)
                    {
                        this._bottomSuitEffectVmc.removeFromParent(true);
                    }
                    this._bottomSuitEffectVmc = null;
                    _vIndex = 0;
                }
            }
            else
            {
                this.clearSuitEffect();
            }
            return;
        }// end function

        public function clearSuitEffect() : void
        {
            if (this._topSuitEffectVmc)
            {
                this._topSuitEffectVmc.removeFromParent(true);
            }
            this._topSuitEffectVmc = null;
            if (this._bottomSuitEffectVmc)
            {
                this._bottomSuitEffectVmc.removeFromParent(true);
            }
            this._bottomSuitEffectVmc = null;
            _vIndex = 0;
            return;
        }// end function

        override protected function updateViewLayout() : void
        {
            if (this._bottomSuitEffectVmc)
            {
                if (this._bottomSuitEffectVmc.parent)
                {
                    if (getChildIndex(this._bottomSuitEffectVmc) != 0)
                    {
                        setChildIndex(this._bottomSuitEffectVmc, 0);
                    }
                    _vIndex = 1;
                }
            }
            super.updateViewLayout();
            return;
        }// end function

        public function addCircle(param1:DisplayObject) : void
        {
            addChildAt(param1, _vIndex);
            return;
        }// end function

        private function showBottomFlash(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this._vmcMonstBottom)
                {
                    this._vmcMonstBottom = new VMCView();
                    this.addChild(this._vmcMonstBottom);
                    this.setChildIndex(this._vmcMonstBottom, 0);
                    this._vmcMonstBottom.loadRes("res/effect/zones/zonessceenbottom.png");
                    this._vmcMonstBottom.auto = true;
                    this._vmcMonstBottom.updatePose("90", true);
                    this._vmcMonstBottom.play();
                }
            }
            else if (this._vmcMonstBottom)
            {
                this._vmcMonstBottom.stop();
                this._vmcMonstBottom.finalize();
                this._vmcMonstBottom = null;
            }
            return;
        }// end function

        private function __showOrHidePlayers(event:GameEvent = null) : void
        {
            var _loc_2:* = false;
            if (_info && _info.roleType == RoleType.ROLE_TYPE_PLAYER && !isUser())
            {
                _loc_2 = UICfg.hideOtherPlayer;
                if (_loc_2)
                {
                    hide();
                    this.hideAllBuff();
                }
                else
                {
                    show();
                    this.showAllBuff();
                }
            }
            return;
        }// end function

        private function __showOrHideMonster(event:GameEvent = null) : void
        {
            if (_info && _info.roleType == RoleType.ROLE_TYPE_MONSTER)
            {
                if (UICfg.NORMAL_MONSTER && _info.monster_type == 1)
                {
                    hide();
                }
                else
                {
                    show();
                }
            }
            return;
        }// end function

        private function __showOtherNormalModel(event:GameEvent) : void
        {
            if (isUser())
            {
                return;
            }
            if (!isPlayer())
            {
                return;
            }
            if (_info)
            {
                if (UICfg.OTHER_NORMAL_MODEL)
                {
                    this._oldWeapon = _info.weapon;
                    this._oldWeapon_other = _info.weapon_other;
                    this._oldWingInfo = _info.wingInfo;
                    this._oldArmor = _info.armor;
                    _info.wingInfo = null;
                    _info.armor = null;
                    _info.weapon = null;
                    _info.weapon_other = null;
                    this.setVisible(false);
                    changeToSimpleShadow();
                }
                else
                {
                    _info.weapon = this._oldWeapon;
                    _info.weapon_other = this._oldWeapon_other;
                    _info.wingInfo = this._oldWingInfo;
                    _info.armor = this._oldArmor;
                    this._oldWeapon = null;
                    this._oldWeapon_other = null;
                    this._oldWingInfo = null;
                    this._oldArmor = null;
                    this.setVisible(false);
                }
                setViewVisible(_shadowMC, true);
                _isShow = true;
                updateAct();
            }
            return;
        }// end function

        public function setOldItemCfg(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            if (param1 > 0)
            {
                _loc_3 = ItemCfgObj.getInstance().getItemCfg(param1);
            }
            switch(param2)
            {
                case Params.LEFT_WEAPON:
                {
                    this._oldWeapon = _loc_3;
                    break;
                }
                case Params.RIGHT_WEAPON:
                {
                    this._oldWeapon_other = _loc_3;
                    break;
                }
                case Params.BODY:
                {
                    this._oldArmor = _loc_3;
                    break;
                }
                case Params.WING:
                {
                    this._oldWingInfo = _loc_3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function resetCutePet() : void
        {
            var _loc_1:* = PropUtil.hasAutoPickCutePet(_info.equipPetId);
            if (!this._cutePet && !_info.isPlayer(UserObj.getInstance().playerInfo.personId) && _loc_1 != 0)
            {
                this._cutePet = new CutePetInfo();
                this._cutePet.conByParentInfo(info);
                MapControl.getInstance().addCutePet(this._cutePet);
            }
            else if (this._cutePet && _loc_1 == 0)
            {
                MapControl.getInstance().removeCutePetById(_info.personId);
                this._cutePet = null;
            }
            if (this._magicBookInfo)
            {
                MapControl.getInstance().addMagicBookRole(this._magicBookInfo);
            }
            else
            {
                MapControl.getInstance().removeMagicBookRole(_info.personId);
            }
            return;
        }// end function

        public function resetMagicBook() : void
        {
            if (info is PlayerInfo)
            {
                this._magicBookInfo = (info as PlayerInfo).magicBook;
                if (this._magicBookInfo)
                {
                    this._magicBookInfo.conByParentInfo(info);
                    MapControl.getInstance().addMagicBookRole(this._magicBookInfo);
                }
                else
                {
                    MapControl.getInstance().removeMagicBookRole(_info.personId);
                }
            }
            return;
        }// end function

        override public function pathByAStarArray(param1:Array, param2:Array = null) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._cutePet && param1 && param1.length)
            {
                _loc_3 = MapControl.getInstance().cutePetFindPath(this._cutePet.x, this._cutePet.y, param1);
                _loc_4 = CutePetList.getInstance().getCutePet(this._cutePet.parentId);
                if (_loc_4)
                {
                    _loc_4.moveToParent(_loc_3);
                }
            }
            if (this._magicBookInfo && param1 && param1.length)
            {
                _loc_5 = MapControl.getInstance().cutePetFindPath(this._magicBookInfo.x, this._magicBookInfo.y, param1);
                _loc_6 = MagicBookRoleList.getInstance().getMagicBookRole(this._magicBookInfo.parentId);
                if (_loc_6)
                {
                    _loc_6.player = this;
                    _loc_6.moveToParent(_loc_5);
                }
            }
            return super.pathByAStarArray(param1, param2);
        }// end function

        private function __actRelease(event:Event = null) : void
        {
            if (this._stopWhenRelease && isPathing)
            {
                stop();
                this._stopWhenRelease = false;
            }
            return;
        }// end function

        private function __actEffect(event:Event = null) : void
        {
            if (this._stopWhenEffect && isPathing)
            {
                stop();
                this._stopWhenEffect = false;
            }
            return;
        }// end function

        override public function play() : void
        {
            this._stopWhenEffect = false;
            this._stopWhenRelease = false;
            super.play();
            return;
        }// end function

        override protected function showView() : void
        {
            super.showView();
            this.__showOrHidePlayers();
            this.updateNameY();
            return;
        }// end function

        private function updateNameY(param1 = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = 1;
            var _loc_3:* = 0;
            if (this._bloodStripe)
            {
                if (this.isZonesMorph && high > 135)
                {
                    this._bloodStripe.y = int(-135 - _loc_2 * this.textHeight);
                }
                else
                {
                    this._bloodStripe.y = int(-high - _loc_2 * this.textHeight);
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this.guildTxt)
            {
                this.guildTxt.y = int(-high - _loc_2 * this.textHeight);
                _loc_3 = this.guildTxt.y;
                _loc_2 = _loc_2 + 1;
            }
            if (this._nameTxt)
            {
                if (!this._attackDefenceImg)
                {
                    this._nameTxt.x = -int(this._nameTxt.width / 2);
                }
                if (this._monsterTypeImg)
                {
                    if (isCreamMonster())
                    {
                        this._nameTxt.x = (-int(this._nameTxt.width + 29)) / 2 + 29;
                    }
                    else if (isBossMonster())
                    {
                        this._nameTxt.x = (-int(this._nameTxt.width + 47)) / 2 + 47;
                    }
                }
                if (this.isZonesMorph && high > 135)
                {
                    this._nameTxt.y = int(-135 - _loc_2 * this.textHeight);
                }
                else
                {
                    this._nameTxt.y = int(-high - _loc_2 * this.textHeight);
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._attackDefenceImg)
            {
                this._attackDefenceImg.y = this._nameTxt.y - 3;
            }
            if (this._bossDropImg && this._roleLevelIcon)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 44)) / 2 + 44;
                this._bossDropImg.x = (-int(this._nameTxt.width + 44)) / 2;
                this._bossDropImg.y = this._nameTxt.y;
                _loc_4 = (-int(this._nameTxt.width + 44)) / 2 + 22;
                _loc_5 = this._nameTxt.y;
                this._roleLevelIcon.move(_loc_4 + 12, _loc_5 + 8);
            }
            else if (this._bossDropImg)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
                this._bossDropImg.x = (-int(this._nameTxt.width + 22)) / 2;
                this._bossDropImg.y = this._nameTxt.y;
            }
            else if (this._roleLevelIcon)
            {
                this._nameTxt.x = (-int(this._nameTxt.width + 22)) / 2 + 22;
                _loc_4 = (-int(this._nameTxt.width + 22)) / 2;
                _loc_5 = this._nameTxt.y;
                this._roleLevelIcon.move(_loc_4 + 12, _loc_5 + 8);
            }
            if (this._monsterTypeImg)
            {
                this._monsterTypeImg.y = this._nameTxt.y - 11;
            }
            if (this.bompMC)
            {
                this.bompMC.y = this._nameTxt.y - 35;
                _loc_2 = _loc_2 + 1;
            }
            if (this.countryFightMC)
            {
                this.countryFightMC.y = this._nameTxt.y - 25;
                _loc_2 = _loc_2 + 1;
            }
            if (this._countryName)
            {
                if (this.bompMC)
                {
                    this._countryName.y = this.bompMC.y - 53;
                }
                else if (this.countryFightMC)
                {
                    this._countryName.y = this.countryFightMC.y - 53;
                }
                else
                {
                    this._countryName.y = this._nameTxt.y - 53;
                }
            }
            if (this._angerSprite)
            {
                if (this.bompMC)
                {
                    this._angerSprite.y = this.bompMC.y - 3;
                }
                else if (this.countryFightMC)
                {
                    this._angerSprite.y = this.countryFightMC.y - 3;
                }
                else if (this._monsterTypeImg)
                {
                    this._angerSprite.y = this._monsterTypeImg.y - 3;
                }
                else
                {
                    this._angerSprite.y = this._nameTxt.y;
                }
            }
            if (this._bloodStripe && this._csysDesignName)
            {
                if (isUser())
                {
                    this._csysDesignName.move(-96.5, this._bloodStripe.y - 80 - 30);
                }
                else
                {
                    this._csysDesignName.move(-96.5, this._bloodStripe.y - 80);
                }
            }
            if (this._titleImg)
            {
                if (this._nobImg)
                {
                    _loc_3 = _loc_3 - this._nobImg.height;
                }
                else
                {
                    _loc_3 = _loc_3 - 25;
                }
                if (this._nameTxt)
                {
                    if (this._titleImg.poseInfo)
                    {
                        this._titleImg.move(this._titleImg._x, this._nameTxt.y - this._excursion_y);
                    }
                }
            }
            return;
        }// end function

        override public function set scale(param1:Number) : void
        {
            super.scale = param1;
            this.updateNameY();
            return;
        }// end function

        public function dead() : void
        {
            if (UserObj.getInstance().selectRole == this)
            {
                UserObj.getInstance().selectRole = null;
            }
            if (_info)
            {
                _info.HP = 0;
            }
            if (this._cutePet)
            {
                MapControl.getInstance().removeCutePetById(this._cutePet.parentId);
                this._cutePet = null;
            }
            setAct(Params.ACTION_DEAD, false, false);
            if (isMonster())
            {
                if (ZonesControl.getInstance().inBossHome())
                {
                    MapControl.getInstance().bosshomeShowMonsterDie(info);
                }
            }
            return;
        }// end function

        private function playMonsterSound() : void
        {
            if (_info)
            {
                SoundControl.getInstance().playMonseterSound(SoundFlag.MONSTER_DIE, _info.cfgId);
            }
            return;
        }// end function

        public function kickFly(param1:IRole, param2:uint, param3:Boolean = true) : void
        {
            var _loc_5:* = null;
            if (isMonster() || isClientMonster())
            {
                TweenLite.delayedCall(0.3, this.playMonsterSound);
                if (ZonesControl.getInstance().inBossHome())
                {
                    MapControl.getInstance().bosshomeShowMonsterDie(info);
                }
            }
            if (UserObj.getInstance().selectRole == this)
            {
                UserObj.getInstance().selectRole = null;
            }
            if (param3 && _info)
            {
                _info.HP = 0;
            }
            this.stopWhenEffect = true;
            setAct(Params.ACTION_KICK_FLY, false, false);
            var _loc_4:* = 100;
            param2 = 200;
            param2 = param2 * (_loc_4 / _info.q_weight);
            var _loc_6:* = 0;
            while (_loc_6 <= param2)
            {
                
                _loc_5 = ToolKit.getPointBackPoint(param2 - _loc_6, param1._x, param1._y, _x, _y);
                if (!MapObj.getInstance().isObstacle(MapUtils.coo2Tile(_loc_5.x), MapUtils.coo2Tile(_loc_5.y)))
                {
                    break;
                }
                _loc_6 = _loc_6 + 25;
            }
            move2(_loc_5.x, _loc_5.y, 0.5 * FrameworkGlobal.GLOBAL_BMP_MULTIPLE, this.deadComplete);
            TweenLite.killDelayedCallsTo(this.kickDown);
            TweenLite.delayedCall(0.2 * FrameworkGlobal.GLOBAL_BMP_MULTIPLE, this.kickDown);
            return;
        }// end function

        private function kickDown() : void
        {
            if (_bodyView)
            {
                this.play();
            }
            return;
        }// end function

        private function deadComplete() : void
        {
            if (!alive())
            {
                dispatchEvent(new RoleEvent(RoleEvent.DEAD));
                if (isMonster() || isClientMonster())
                {
                    TweenLite.delayedCall(1, MapControl.getInstance().removeRoleFromRoles, [this]);
                }
                if (scrollMCBuffer)
                {
                    scrollMCBuffer.stop();
                }
                if (isUser())
                {
                    CountryControl.getInstance().stopGather();
                }
            }
            return;
        }// end function

        public function alphaCheck() : Boolean
        {
            var _loc_1:* = _bodyView.bitmapData.getPixel32(0, 0) >> 24 & 255;
            return _loc_1 == 0;
        }// end function

        public function revive() : void
        {
            _fatherActType = Params.ACTION_STAND_ID;
            super.setAct(Params.ACTION_STAND_ID, true, false);
            this.resetCutePet();
            return;
        }// end function

        override protected function actComplete() : void
        {
            switch(actType)
            {
                case Params.ACTION_DEAD:
                {
                    this.deadComplete();
                    return;
                }
                default:
                {
                    break;
                }
            }
            super.actComplete();
            return;
        }// end function

        public function showBloodStripe() : void
        {
            if (this._bloodStripe && this._bloodStripe.parent != this)
            {
                addChild(this._bloodStripe);
            }
            if (alive())
            {
                if (this._bloodStripe && this._bloodStripe.parent != this)
                {
                    addChild(this._bloodStripe);
                }
                if (this.guildTxt && this.guildTxt.parent != this)
                {
                    if (!this.isZonesMorph)
                    {
                        addChild(this.guildTxt);
                    }
                }
                if (this._nameTxt && this._nameTxt.parent != this)
                {
                    if (!this.isZonesMorph || isUser())
                    {
                        addChild(this._nameTxt);
                    }
                }
                if (this._angerSprite && this._angerSprite.parent != this)
                {
                    if (!this.isZonesMorph || isUser())
                    {
                        addChild(this._angerSprite);
                    }
                }
                if (this._monsterTypeImg && this._monsterTypeImg.parent != this)
                {
                    addChild(this._monsterTypeImg);
                }
            }
            return;
        }// end function

        public function hideBloodStripe() : void
        {
            if (!this._alwaysShowBloodStripe)
            {
                if (this._bloodStripe)
                {
                    if (this._bloodStripe.parent == this)
                    {
                        removeChild(this._bloodStripe);
                    }
                }
                if (this.guildTxt)
                {
                    if (this.guildTxt.parent == this)
                    {
                        removeChild(this.guildTxt);
                    }
                }
                if (this._nameTxt)
                {
                    if (this._nameTxt.parent == this)
                    {
                        removeChild(this._nameTxt);
                    }
                }
                if (this._angerSprite)
                {
                    if (this._angerSprite.parent == this)
                    {
                        removeChild(this._angerSprite);
                    }
                }
                if (this._monsterTypeImg)
                {
                    if (this._monsterTypeImg.parent == this)
                    {
                        removeChild(this._monsterTypeImg);
                    }
                }
            }
            return;
        }// end function

        public function removeBloodStripe() : void
        {
            if (this._bloodStripe)
            {
                removeChild(this._bloodStripe);
                this._bloodStripe = null;
            }
            return;
        }// end function

        public function setStateIcon(param1:String) : void
        {
            if (param1 == null)
            {
                this.disposeStateIcon();
                return;
            }
            if (param1 == Params.SCENE_ENTER_PRAC)
            {
                this.updateNameY();
            }
            else if (param1 == Params.SCENE_OUT_PRAC)
            {
            }
            else if (param1 == Params.SCENE_LOGIN)
            {
            }
            return;
        }// end function

        private function __onLoginMcDone(event:Event) : void
        {
            removeChild(this._loginVmcView);
            return;
        }// end function

        private function disposeStateIcon() : void
        {
            if (this._loginVmcView && this._loginVmcView.parent)
            {
                this._loginVmcView.parent.removeChild(this._loginVmcView);
            }
            if (this._pracStarVmcView && this._pracStarVmcView.parent)
            {
                this._pracStarVmcView.parent.removeChild(this._pracStarVmcView);
            }
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            if (this._pracStarVmcView && this._stat == Params.SCENE_ENTER_PRAC)
            {
                this._pracStarVmcView.enterFrame();
            }
            super.enterFrame(event);
            return;
        }// end function

        public function attack() : void
        {
            stopPath();
            setAct(Params.ACTION_SIMPLE_ATTACK_ID);
            return;
        }// end function

        public function canAtk(param1:IRole) : Boolean
        {
            return true;
        }// end function

        public function face2(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (param1 == _x && param2 == _y)
            {
                return MapUtils.roleDir2MapDirect(direct);
            }
            _loc_3 = MapUtils.countDirection(_x, _y, param1, param2);
            direct = MapUtils.mapDirect2RoleDir(_loc_3);
            return _loc_3;
        }// end function

        public function isRidingHorse() : Boolean
        {
            if (_info.horseInfo && _info.horseInfo.isRiding())
            {
                return true;
            }
            return false;
        }// end function

        public function attacked(param1:Boolean, param2:int = 0, param3:int = 0, param4:uint = 1, param5:int = 1, param6:int = 60, param7:int = 1) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (alive() && !_isPathing && !this.isRidingHorse() && info && info.q_evasive_style != 3)
            {
                setAct(Params.ACTION_SIMPLE_HURT_ID, false, true);
            }
            if (param4 > 1)
            {
                _loc_8 = param2 / param4;
                _loc_9 = 0;
                while (_loc_9 < param4)
                {
                    
                    TweenLite.delayedCall(0.2 * _loc_9, this.playAttack, [param1, _loc_8, param3, param5, param6, param7]);
                    _loc_9++;
                }
            }
            else
            {
                this.playAttack(param1, param2, param3, param5, param6, param7);
            }
            if (_bodyView)
            {
                Effects.blin(_bodyView, param4);
            }
            return;
        }// end function

        public function playAttack(param1:Boolean, param2:int, param3:int = 0, param4:int = 1, param5:int = 60, param6:int = 1) : void
        {
            if (isMonster() || isClientMonster())
            {
                this.showMonsterDamageNum(param1, param2, param3, param4, param5, param6);
            }
            else
            {
                this.showBloodScrollNum(param1, param2, param3);
            }
            return;
        }// end function

        private function showBloodScrollNum(param1:Boolean, param2:int, param3:int = 0) : void
        {
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            if (UICfg.hideOtherPlayer && !isUser() && !param1)
            {
                return;
            }
            this.blood_num = ObjectPool.CheckOut(ImgNumber);
            var _loc_4:* = -1;
            var _loc_5:* = "";
            var _loc_6:* = [26, 30, 31, 25, 0, 88, 76, 88, 88];
            var _loc_7:* = ["fightHuixin", "fightZhuoyue", "fightIgnore", "fightReflect", "", "fightFatal", "fightMagicBook", "fightErupt", "fightAppend"];
            var _loc_8:* = [1, 2, 16, 8, 0, 4, 32, 64, 128];
            var _loc_9:* = 0;
            var _loc_10:* = -1;
            while (param3)
            {
                
                if (param3 & 1)
                {
                    _loc_11 = _loc_8[_loc_9];
                    _loc_12 = _loc_6[_loc_9];
                    _loc_13 = _loc_7[_loc_9];
                    if (_loc_10 < _loc_11)
                    {
                        _loc_10 = _loc_11;
                        _loc_4 = _loc_12;
                        _loc_5 = _loc_13;
                    }
                }
                param3 = param3 >> 1;
                _loc_9++;
            }
            if (_loc_4 > 0)
            {
                if (param2 > 0)
                {
                    this.blood_num.setNumber("" + param2.toString(), _loc_4, 0, false, true, _loc_5);
                }
                else if (param2 < 0)
                {
                    this.blood_num.setNumber("" + param2.toString(), _loc_4, 0, false, true, _loc_5);
                }
            }
            else if (param2 > 0)
            {
                this.blood_num.setNumber("+" + param2.toString(), 28, 0);
            }
            else if (param2 < 0)
            {
                this.blood_num.setNumber("-" + Math.abs(param2).toString(), 28, 0);
            }
            addChild(this.blood_num);
            showTopCue(this.blood_num, 0, 0, 0, 0, ScrollMC.BLOOD_TYPE, 0, 0, 0, false, 0, -77, 1, 22, 1);
            return;
        }// end function

        private function showExpNum(event:RoleEvent) : void
        {
            var _loc_2:* = event.obj;
            this.blood_num = ObjectPool.CheckOut(ImgNumber);
            if (_loc_2 > 0)
            {
                this.blood_num.setNumber("+" + _loc_2.toString(), 27, 5, false, true, "fightExp");
                addChild(this.blood_num);
                showTopCue(this.blood_num, 0, 0, this.blood_num.width * (ScrollMC.EXP_SCALE - 1) / 2, 58, ScrollMC.EXP_TYPE, 1, 100, 0, true);
            }
            return;
        }// end function

        public function showDuNum(event:RoleEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = event.obj[0];
            var _loc_3:* = event.obj[1];
            this.blood_num = ObjectPool.CheckOut(ImgNumber);
            if (_loc_3 < 0)
            {
                _loc_4 = "";
                _loc_5 = 24;
                _loc_6 = 0;
                if (_loc_2 == 1)
                {
                    _loc_4 = "fightZhongdu";
                    _loc_5 = 29;
                    _loc_6 = 5;
                }
                this.blood_num.setNumber(_loc_3.toString(), _loc_5, _loc_6, false, true, _loc_4);
                addChild(this.blood_num);
                showTopCue(this.blood_num, 0, 0, 0, 0, ScrollMC.BLOOD_TYPE, 0, 0, 0, false, 0, -77, 1, 22, 1);
            }
            return;
        }// end function

        public function showZonesIntegral(param1:int) : void
        {
            this.blood_num = ObjectPool.CheckOut(ImgNumber);
            if (param1 > 0)
            {
                this.blood_num.setNumber("+" + param1.toString(), 41, 5, false, true, "num_41_integral");
                addChild(this.blood_num);
                showTopCue(this.blood_num, 0, 0, this.blood_num.width * (ScrollMC.EXP_SCALE - 1) / 2, 58, ScrollMC.EXP_TYPE, 1, 100, 0, true);
            }
            return;
        }// end function

        public function showIsCommonTeam() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.isTeamMember(false);
            if (_info.personId.equal(UserObj.getInstance().playerInfo.personId))
            {
                _loc_1 = false;
            }
            if (_loc_1 && !this._isZonesMorph)
            {
                if (!this.teamSign)
                {
                    _loc_2 = ToolKit.getNew("teamcommonsign") as BitmapData;
                    this.teamSign = new Bitmap(_loc_2);
                }
                this.addChild(this.teamSign);
                this.teamSign.x = 20;
                this.teamSign.y = -40;
            }
            else
            {
                if (this.teamSign && this.teamSign.parent)
                {
                    this.teamSign.parent.removeChild(this.teamSign);
                }
                this.teamSign = null;
            }
            return;
        }// end function

        public function showIsSameGuild() : void
        {
            var _loc_1:* = this.isGuildMember2();
            if (_info.personId.equal(UserObj.getInstance().playerInfo.personId))
            {
                _loc_1 = false;
            }
            if (_loc_1 && !this._isZonesMorph)
            {
                if (!this.guildSign)
                {
                    this.guildSign = ToolKit.getNew("guildsign");
                }
                this.addChild(this.guildSign);
                this.guildSign.x = 40;
                this.guildSign.y = -40;
            }
            else
            {
                if (this.guildSign && this.guildSign.parent)
                {
                    this.guildSign.parent.removeChild(this.guildSign);
                }
                this.guildSign = null;
            }
            return;
        }// end function

        public function showCsysDesignation() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!isPlayer())
            {
                return;
            }
            if (!this._isZonesMorph || info.csysKills <= 0)
            {
                if (this._csysDesignName && this._csysDesignName.parent)
                {
                    this._csysDesignName.parent.removeChild(this._csysDesignName);
                }
                this._csysDesignName = null;
                this._csysKillNum = null;
                this._csysKillImg = null;
                return;
            }
            if (!this._csysDesignName)
            {
                this._csysDesignName = new BaseSprite();
                this.addChild(this._csysDesignName);
                if (isUser())
                {
                    this._csysDesignName.move(-96.5, -210 - 30);
                }
                else
                {
                    this._csysDesignName.move(-96.5, -210);
                }
            }
            if (!this._csysKillNum)
            {
                this._csysKillNum = new ImgNumber();
                this._csysKillNum.move(113, 47);
                this._csysKillImg = new Image();
                this._csysKillImg.move(43, 30);
                this._csysKillImg.load("res/image/playerzone/zoneskill.png");
                this._csysDesignName.addChild(this._csysKillImg);
                this._csysDesignName.addChild(this._csysKillNum);
            }
            this._csysKillNum.setNumber(info.csysKills.toString(), 42);
            if (info.csysKills >= 3)
            {
                if (!this._csysDesignImg)
                {
                    this._csysDesignImg = new Image();
                    this._csysDesignImg.move(0, -5);
                }
                this._csysDesignName.addChildAt(this._csysDesignImg, 0);
                _loc_1 = info.csysKills;
                _loc_1 = _loc_1 > 10 ? (10) : (_loc_1);
                _loc_2 = "res/image/playerzone/zones_" + _loc_1 + ".png";
                this._csysDesignImg.load(_loc_2);
            }
            return;
        }// end function

        public function showAngerTitle() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (!isMonster())
            {
                return;
            }
            if (!this._angerSprite)
            {
                this._angerSprite = new BaseSprite();
                if (!this._monsterTypeImg)
                {
                    this._angerSprite.x = -86.5;
                    this._angerSprite.y = this._nameTxt.y;
                }
                else
                {
                    this._angerSprite.x = this._monsterTypeImg.x - 30;
                    this._angerSprite.y = this._monsterTypeImg.y - 4;
                }
            }
            var _loc_1:* = BossHomeCfgObj.getInstance().getAngelByModelId(_info.cfgId);
            if (_loc_1 >= 0)
            {
                if (!this._angerImg)
                {
                    this._angerImg = new Image();
                    this._angerSprite.addChildAt(this._angerImg, 0);
                }
                _loc_2 = "res/image/bosshome/icon.png";
                this._angerImg.load(_loc_2);
                this._angerTxt = new Sprite();
                _loc_3 = 0;
                while (_loc_3 < _loc_1.toString().length)
                {
                    
                    _loc_4 = ToolKit.getNew("num_28_" + _loc_1.toString().charAt(_loc_3));
                    _loc_4.x = this._angerTxt.width - 2;
                    this._angerTxt.addChild(_loc_4);
                    _loc_3++;
                }
                this._angerTxt.x = -this._angerTxt.width + this._angerImg.x;
                this._angerTxt.y = 10;
                this._angerSprite.addChild(this._angerTxt);
            }
            else
            {
                this._angerSprite.removeFromParent();
                this._angerSprite = null;
            }
            this.updateNameY();
            return;
        }// end function

        public function showCountryTitle() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!isPlayer())
            {
                return;
            }
            if (!this._countryName)
            {
                this._countryName = new BaseSprite();
                this.addChild(this._countryName);
                this._countryName.x = -96.5;
            }
            if (info.csysKills >= 10)
            {
                if (!this._countryImg)
                {
                    this._countryImg = new Image();
                    this._countryName.addChildAt(this._countryImg, 0);
                }
                _loc_1 = info.csysKills;
                _loc_1 = int(_loc_1 / 10) + 2;
                _loc_2 = "res/image/playerzone/zones_" + _loc_1 + ".png";
                this._countryImg.load(_loc_2);
            }
            else
            {
                this._countryName.removeFromParent();
                this._countryName = null;
            }
            this.updateNameY();
            return;
        }// end function

        private function showMonsterDamageNum(param1:Boolean, param2:int, param3:int = 0, param4:int = 1, param5:int = 60, param6:int = 1) : void
        {
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            if (UICfg.NORMAL_MONSTER && !param1)
            {
                return;
            }
            this.blood_num = ObjectPool.CheckOut(ImgNumber);
            var _loc_7:* = -1;
            var _loc_8:* = "";
            var _loc_9:* = [26, 30, 31, 25, 0, 88, 76, 88, 88];
            var _loc_10:* = ["fightHuixin", "fightZhuoyue", "fightIgnore", "fightReflect", "", "fightFatal", "fightMagicBook", "fightErupt", "fightAppend"];
            var _loc_11:* = [1, 2, 16, 8, 0, 4, 32, 64, 128];
            var _loc_12:* = 0;
            var _loc_13:* = -1;
            while (param3)
            {
                
                if (param3 & 1)
                {
                    _loc_14 = _loc_11[_loc_12];
                    _loc_15 = _loc_9[_loc_12];
                    _loc_16 = _loc_10[_loc_12];
                    if (_loc_13 < _loc_14)
                    {
                        _loc_13 = _loc_14;
                        _loc_7 = _loc_15;
                        _loc_8 = _loc_16;
                    }
                }
                param3 = param3 >> 1;
                _loc_12++;
            }
            if (_loc_7 > 0)
            {
                if (param2 > 0)
                {
                    this.blood_num.setNumber("" + param2.toString(), _loc_7, 0, false, true, _loc_8);
                }
                else if (param2 < 0)
                {
                    this.blood_num.setNumber("" + param2.toString(), _loc_7, 0, false, true, _loc_8);
                }
            }
            else if (param2 > 0)
            {
                this.blood_num.setNumber("+" + param2.toString(), 24, 0);
            }
            else if (param2 < 0)
            {
                this.blood_num.setNumber("-" + Math.abs(param2).toString(), 24, 0);
            }
            addChild(this.blood_num);
            showTopCue(this.blood_num, 0, 0, 0, 0, ScrollMC.MONSTER_DAMAGE_TYPE, 0, 0, 0, false, 0, -77, param4, param5, param6);
            return;
        }// end function

        public function willDead(param1:int) : Boolean
        {
            if (_info.HP + param1 <= 0)
            {
                return true;
            }
            return false;
        }// end function

        public function distanceSQ(param1:IRole) : uint
        {
            return ToolKit.distanceSQ(_x, _y, param1._x, param1._y);
        }// end function

        private function updateBuffView() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in _info.buffs)
            {
                
                this.addBuffView(_loc_1);
                _loc_2 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                _loc_2.obj = {op:"AU", t:_loc_1.q_buff_id};
                _info.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function addBuffView(param1:BuffInfo) : void
        {
            var buffInfo:* = param1;
            this.recoverBuffView(buffInfo);
            if (buffInfo.q_small_ico)
            {
                setTimeout(function () : void
            {
                if (curShowBuffEffectRes && curShowBuffEffectRes.url == buffInfo.url)
                {
                    curShowBuffEffectRes.play();
                }
                VMCManager.addRes(buffInfo.q_small_ico, showEffect, [buffInfo.q_small_ico]);
                return;
            }// end function
            , 800);
            }
            return;
        }// end function

        private function showEffect(param1:String) : void
        {
            if (this.curShowBuffEffectRes)
            {
                this.curShowBuffEffectRes.finalize();
                this.curShowBuffEffectRes = null;
            }
            if (VMCManager.getPoseInfo(param1, "90"))
            {
                this.curShowBuffEffectRes = new VMCView();
                this.curShowBuffEffectRes.auto = true;
                this.curShowBuffEffectRes.url = param1;
                this.curShowBuffEffectRes.updatePose("90", false, false, true);
                if (this.curShowBuffEffectRes.poseInfo.scale > 1)
                {
                    this.curShowBuffEffectRes.scale = this.curShowBuffEffectRes.poseInfo.scale;
                }
                addRes(this.curShowBuffEffectRes, 0, 1, high * this.curShowBuffEffectRes.offsetY);
            }
            return;
        }// end function

        private function recoverBuffView(param1:BuffInfo) : void
        {
            if (!param1)
            {
                return;
            }
            if (!this.buffviews)
            {
                this.buffviews = new Dictionary();
            }
            if (!this.buffviews[param1.q_buffswf_location])
            {
                this.buffviews[param1.q_buffswf_location] = new Dictionary();
            }
            var _loc_2:* = this.buffviews[param1.q_buffswf_location];
            if (param1.url)
            {
                if (_loc_2)
                {
                    if (_loc_2["front"] && _loc_2["front"].url == param1.url)
                    {
                        return;
                    }
                    if (_loc_2["front"])
                    {
                        this.removeBuffViewGeneral(_loc_2["front"]);
                    }
                    if (_loc_2["back"])
                    {
                        this.removeBuffViewGeneral(_loc_2["back"]);
                    }
                }
                else
                {
                    var _loc_3:* = new Dictionary();
                    _loc_2 = new Dictionary();
                    this.buffviews[param1.q_buffswf_location] = _loc_3;
                }
                VMCManager.addRes(param1.url, this.showBuffView, [_loc_2, param1.url], null, null, true);
            }
            return;
        }// end function

        private function showHideCountryFightMC(event:CountryEvent = null) : void
        {
            this.hideCountryFightMC();
            if (info && info is PlayerInfo && PlayerInfo(info).guildId && PlayerInfo(info).guildId.equal(CountryData.getInstance().curentCaptureID) && !isUser() && !PlayerInfo(info).guildId.equal(UserObj.getInstance().playerInfo.guildId))
            {
                if (!this.countryFightMC)
                {
                    this.countryFightMC = ToolKit.getNew("capture");
                }
                if (!this.countryFightMC.parent)
                {
                    this.countryFightMC.x = (-this.countryFightMC.width) / 2;
                    addChild(this.countryFightMC);
                }
            }
            this.__updateRoleNameColorByCountryState();
            this.updateNameY();
            return;
        }// end function

        private function showHideLSMC(event:CountryEvent = null) : void
        {
            return;
        }// end function

        public function showBompMC(event:RoleEvent) : void
        {
            if (event.obj)
            {
                if (!this.bompMC)
                {
                    this.bompMC = ToolKit.getNew("imBomp");
                }
                if (!this.bompMC.parent)
                {
                    this.bompMC.x = (-this.bompMC.width) / 2;
                    addChild(this.bompMC);
                }
            }
            else if (this.bompMC && this.bompMC.parent)
            {
                removeChild(this.bompMC);
                this.bompMC = null;
            }
            this.updateNameY();
            return;
        }// end function

        private function hideCountryFightMC() : void
        {
            if (this.countryFightMC && this.countryFightMC.parent)
            {
                this.countryFightMC.parent.removeChild(this.countryFightMC);
                this.countryFightMC = null;
            }
            return;
        }// end function

        private function showBuffView(param1:Dictionary, param2:String, param3:Boolean = true) : void
        {
            if (param1["front"])
            {
                param1["front"].finalize();
                param1["front"] = null;
            }
            if (param1["back"])
            {
                param1["back"].finalize();
                param1["back"] = null;
            }
            if (VMCManager.getPoseInfo(param2, "90"))
            {
                param1["front"] = new VMCView();
                param1["front"].auto = true;
                param1["front"].url = param2;
                param1["front"].updatePose("90", param3);
                if (param1["front"].poseInfo && param1["front"].poseInfo.scale > 1)
                {
                    param1["front"].scale = param1["front"].poseInfo.scale;
                }
                if (UICfg.hideOtherPlayer && !isUser())
                {
                    param1["front"].visible = false;
                    param1["front"].stop();
                }
                addRes(param1["front"], 0, 1, high * param1["front"].offsetY);
            }
            if (VMCManager.getPoseInfo(param2, "front_" + "90"))
            {
                param1["front"] = new VMCView();
                param1["front"].auto = true;
                param1["front"].url = param2;
                param1["front"].updatePose("front_90", param3);
                if (param1["front"].poseInfo && param1["front"].poseInfo.scale > 1)
                {
                    param1["front"].scale = param1["front"].poseInfo.scale;
                }
                if (UICfg.hideOtherPlayer && !isUser())
                {
                    param1["front"].visible = false;
                    param1["front"].stop();
                }
                addRes(param1["front"], 0, 1, high * param1["front"].offsetY);
            }
            if (VMCManager.getPoseInfo(param2, "back_" + "90"))
            {
                param1["back"] = new VMCView();
                param1["back"].auto = true;
                param1["back"].url = param2;
                param1["back"].updatePose("back_90", param3);
                if (param1["back"].poseInfo && param1["back"].poseInfo.scale > 1)
                {
                    param1["back"].scale = param1["back"].poseInfo.scale;
                }
                if (UICfg.hideOtherPlayer && !isUser())
                {
                    param1["back"].visible = false;
                    param1["back"].stop();
                }
                addRes(param1["back"], 0, 2, high * param1["back"].offsetY);
            }
            return;
        }// end function

        public function showAllBuff() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.buffviews)
            {
                
                if (_loc_1)
                {
                    if (_loc_1["back"])
                    {
                        _loc_1["back"].play();
                        _loc_1["back"].visible = true;
                    }
                    if (_loc_1["front"])
                    {
                        _loc_1["front"].play();
                        _loc_1["front"].visible = true;
                    }
                }
            }
            return;
        }// end function

        public function hideAllBuff() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.buffviews)
            {
                
                if (_loc_1)
                {
                    if (_loc_1["back"])
                    {
                        _loc_1["back"].visible = false;
                        _loc_1["back"].stop();
                    }
                    if (_loc_1["front"])
                    {
                        _loc_1["front"].visible = false;
                        _loc_1["front"].stop();
                    }
                }
            }
            return;
        }// end function

        public function removeBuffView(param1:BuffInfo) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 == null || _info == null)
            {
                return;
            }
            var _loc_2:* = this.buffviews[param1.q_buffswf_location];
            var _loc_3:* = _info.buffs;
            if (_loc_3 == null)
            {
                return;
            }
            _loc_4 = _loc_3.length;
            var _loc_6:* = _loc_4 - 1;
            while (_loc_6 >= 0)
            {
                
                if (_loc_3[_loc_6] == null)
                {
                    return;
                }
                if (param1.q_buffswf_location == _loc_3[_loc_6].q_buffswf_location)
                {
                    _loc_5 = _loc_3[_loc_6];
                    break;
                }
                _loc_6 = _loc_6 - 1;
            }
            if (_loc_2)
            {
                if (_loc_2["front"] && _loc_2["front"].url == param1.url)
                {
                    this.removeBuffViewGeneral(_loc_2["front"]);
                    this.buffviews[param1.q_buffswf_location] = null;
                }
                else if (_loc_2["front"] && _loc_2["front"].url != param1.url)
                {
                    return;
                }
                if (_loc_2["back"] && _loc_2["back"].url == param1.url)
                {
                    this.removeBuffViewGeneral(_loc_2["back"]);
                    this.buffviews[param1.q_buffswf_location] = null;
                }
                else if (_loc_2["back"] && _loc_2["back"].url != param1.url)
                {
                    return;
                }
            }
            if (_loc_5)
            {
                this.recoverBuffView(_loc_5);
                return;
            }
            return;
        }// end function

        private function removeBuffViewGeneral(param1:VMCView) : void
        {
            if (param1 && param1.parent && param1.parent == this)
            {
                removeChild(param1);
            }
            if (param1)
            {
                param1.finalize();
            }
            param1 = null;
            return;
        }// end function

        private function removeCurBuffFiler() : void
        {
            return;
        }// end function

        public function clearAllBuffView() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.buffviews)
            {
                
                if (_loc_1)
                {
                    this.removeBuffViewGeneral(_loc_1["front"]);
                    this.removeBuffViewGeneral(_loc_1["back"]);
                    _loc_1 = null;
                }
            }
            this.buffviews = null;
            this.removeCurBuffFiler();
            return;
        }// end function

        public function getBuffInfoBack(param1:ResBuffInfoMessage) : void
        {
            var _loc_2:* = _info.getBuff(param1.buffId);
            _loc_2.remain = param1.remain;
            _loc_2.value = param1.value;
            var _loc_3:* = new RoleEvent(RoleEvent.UPDATE_BUFF);
            _loc_3.obj = {op:"AU", t:param1.buffId};
            _info.dispatchEvent(_loc_3);
            return;
        }// end function

        private function cueAddBuffEffect(param1:BuffInfo) : void
        {
            return;
        }// end function

        public function hasBuff(param1:uint) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in _info.buffs)
            {
                
                if (_loc_2.q_buff_id == param1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function isEnemy() : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_1:* = MapObj.getInstance().mapID;
            if (MapCfgObj.getInstance().getMap(_loc_1).q_map_safe == 1)
            {
                if (isMonster() || isClientMonster() || isNotAnyMonster())
                {
                    if (info && info is MonsterInfo && MonsterInfo(info).friend == 1)
                    {
                        return false;
                    }
                    return true;
                }
                return false;
            }
            if (_loc_1 == Params.COUNTRY_MAP_ID)
            {
                if (!info)
                {
                    return false;
                }
                _loc_3 = info.cfgId;
                _loc_4 = CountryData.getInstance().curentCaptureID;
                _loc_5 = UserObj.getInstance().playerInfo.guildId;
                if (isMonster() && _loc_5 && _loc_4 && _loc_4.equal(_loc_5))
                {
                    return false;
                }
                _loc_6 = _loc_5 && _loc_5.equal(_loc_4);
                _loc_7 = info.guildId ? (info.guildId.equal(_loc_4)) : (true);
                if (_loc_6 == _loc_7)
                {
                    return false;
                }
            }
            var _loc_2:* = RoleList.getInstance().player.info.pkState;
            switch(RoleList.getInstance().player.info.pkState)
            {
                case 0:
                {
                    if (isMonster() || isClientMonster())
                    {
                        if (info && info is MonsterInfo && MonsterInfo(info).friend == 1)
                        {
                            return false;
                        }
                        return true;
                    }
                    if (_info && _info.owner)
                    {
                        _loc_8 = RoleList.getInstance().getRole(_info.owner).info;
                    }
                    else
                    {
                        _loc_8 = _info;
                    }
                    if (_loc_8 && (_loc_8.pkValue > 0 || this.inAttacked(_loc_8.personId)) && !this.isTeamMember() && !this.isGuildMember1())
                    {
                        return true;
                    }
                    if (_loc_8 && _loc_8.pkValue == 0)
                    {
                        if (!this.inAttacked(_loc_8.personId))
                        {
                            return false;
                        }
                        return true;
                    }
                    if (_loc_8)
                    {
                        return false;
                    }
                    break;
                }
                case 1:
                {
                    if (_info && _loc_8.personId.equal(RoleList.getInstance().player.info.personId) || _info && _loc_8.owner && _loc_8.owner.equal(RoleList.getInstance().player.info.personId))
                    {
                        return false;
                    }
                    return isMonster() || !this.isTeamMember() && !this.isGuildMember1();
                }
                case 2:
                {
                    if (_info && _loc_8.personId.equal(RoleList.getInstance().player.info.personId) || _info && _loc_8.owner && _loc_8.owner.equal(RoleList.getInstance().player.info.personId))
                    {
                        return false;
                    }
                    if (info && info is MonsterInfo && MonsterInfo(info).friend == 1)
                    {
                        return false;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return true;
        }// end function

        public function isFriend() : Boolean
        {
            return !this.isEnemy();
        }// end function

        private function inAttacked(param1:long) : Boolean
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.enemies;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].equal(param1))
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function isTeamMember(param1:Boolean = true) : Boolean
        {
            if (!_info)
            {
                return false;
            }
            var _loc_2:* = TeamModel.getInstance().vecTeamInfo;
            if (!_loc_2 || _loc_2.length == 0)
            {
                return false;
            }
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_info.personId && _info.personId.equal(_loc_2[_loc_3].memberid) || param1 && _info.owner && _info.owner.equal(_loc_2[_loc_3].memberid))
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function isGuildMember1() : Boolean
        {
            var _loc_3:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            if (!_loc_1)
            {
                return false;
            }
            var _loc_2:* = _loc_1.guildId;
            if (isSummonPet())
            {
                _loc_3 = RoleList.getInstance().getRole(_info.owner).info.guildId;
                if (_info.owner && _loc_3 && _loc_3.equal(_loc_2))
                {
                    return true;
                }
            }
            else if (isPlayer() && _info.guildId && _info.guildId.equal(_loc_2))
            {
                return true;
            }
            return false;
        }// end function

        public function isGuildMember2() : Boolean
        {
            var _loc_1:* = UserObj.getInstance().playerInfo;
            if (!_loc_1)
            {
                return false;
            }
            var _loc_2:* = _loc_1.guildId;
            if (isPlayer() && _info.guildId && _info.guildId.equal(_loc_2))
            {
                return true;
            }
            return false;
        }// end function

        override public function setVisible(param1:Boolean) : void
        {
            if (_isShow != param1)
            {
                setViewVisible(this._titleImg, param1 && MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID);
                if (param1 && MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID)
                {
                    this.updateTitleImg();
                }
                else if (this._titleImg)
                {
                    this._titleImg.url = null;
                }
            }
            super.setVisible(param1);
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killTweensOf(this);
            TweenLite.killDelayedCallsTo(this.playAttack);
            TweenLite.killDelayedCallsTo(this.kickDown);
            TweenLite.killDelayedCallsTo(this.playMonsterSound);
            this.disposeStateIcon();
            if (this._loginVmcView)
            {
                this._loginVmcView.finalize();
            }
            if (this._pracStarVmcView)
            {
                this._pracStarVmcView.finalize();
            }
            if (this._nobImg && this._nobImg.parent)
            {
                this._nobImg.parent.removeChild(this._nobImg);
                this._nobImg.finalize();
            }
            if (this._angerSprite)
            {
                if (this._angerSprite.parent)
                {
                    this._angerSprite.parent.removeChild(this._angerSprite);
                }
            }
            if (this._titleImg)
            {
                this._titleImg.removeFromParent(true);
            }
            this.clearSuitEffect();
            if (this._vmcMonstBottom && this._vmcMonstBottom.parent)
            {
                this._vmcMonstBottom.stop();
                this._vmcMonstBottom.parent.removeChild(this._vmcMonstBottom);
                this._vmcMonstBottom.finalize();
                this._vmcMonstBottom = null;
            }
            super.finalize();
            return;
        }// end function

        public function removeCountryTitle() : void
        {
            if (this.bompMC && this.bompMC.parent)
            {
                this.bompMC.parent.removeChild(this.bompMC);
                this.bompMC = null;
            }
            if (this._countryName && this._countryName.parent)
            {
                this._countryName.removeFromParent();
                this._countryName = null;
            }
            if (this._countryImg && this._countryImg.parent)
            {
                this._countryImg.parent.removeChild(this._countryImg);
                this._countryImg = null;
            }
            if (this._attackDefenceImg && this._attackDefenceImg.parent)
            {
                this._attackDefenceImg.parent.removeChild(this._attackDefenceImg);
                this._attackDefenceImg = null;
            }
            if (!isMonster())
            {
                this.__updateRoleNameColor();
            }
            this.updateNameY();
            return;
        }// end function

        public function get cutePet() : CutePetInfo
        {
            return this._cutePet;
        }// end function

        public function get isZonesMorph() : Boolean
        {
            return this._isZonesMorph;
        }// end function

        public function set isZonesMorph(param1:Boolean) : void
        {
            if (this._isZonesMorph != param1)
            {
                this._isZonesMorph = param1;
                if (param1)
                {
                    this.showCsysDesignation();
                    this.hideRoleInfo();
                    if (this._titleImg)
                    {
                        this._titleImg.removeFromParent(true);
                    }
                    this._titleImg = null;
                }
                else
                {
                    this.showRoleInfo();
                    this.updateTitleImg();
                }
            }
            return;
        }// end function

        private function hideRoleInfo() : void
        {
            if (this.guildTxt)
            {
                if (this.guildTxt.parent == this)
                {
                    removeChild(this.guildTxt);
                }
            }
            if (!isUser() && this._nameTxt)
            {
                if (this._nameTxt.parent == this)
                {
                    removeChild(this._nameTxt);
                }
            }
            if (this.guildSign)
            {
                if (this.guildSign.parent)
                {
                    this.guildSign.parent.removeChild(this.guildSign);
                }
            }
            if (this.teamSign)
            {
                if (this.teamSign.parent)
                {
                    this.teamSign.parent.removeChild(this.teamSign);
                }
            }
            return;
        }// end function

        private function showRoleInfo() : void
        {
            if (this.guildTxt && this.guildTxt.parent != this)
            {
                addChild(this.guildTxt);
            }
            if (this._nameTxt && this._nameTxt.parent != this)
            {
                addChild(this._nameTxt);
            }
            if (this.guildSign && this.guildSign.parent != this)
            {
                this.guildSign.parent.removeChild(this.guildSign);
            }
            if (this.teamSign && this.teamSign.parent != this)
            {
                this.teamSign.parent.removeChild(this.teamSign);
            }
            this.updateNameY();
            return;
        }// end function

        override protected function addStrengthURL(param1:String, param2:ItemCfg, param3:String = "") : String
        {
            if (this.isZonesMorph)
            {
                return param1;
            }
            return super.addStrengthURL(param1, param2, param3);
        }// end function

        public function get isInSkillShunyi() : Boolean
        {
            return this._isInSkillShunyi;
        }// end function

        public function set isInSkillShunyi(param1:Boolean) : void
        {
            this._isInSkillShunyi = param1;
            return;
        }// end function

        public function showComboEffect() : void
        {
            var _loc_1:* = SpecialSkillID.SKILL_LIAN_JI;
            var _loc_2:* = SkillCfgObj.getInstance().getSkillInfoById(_loc_1);
            var _loc_3:* = new VMCView();
            _loc_3.loadRes("art/res/skill/" + _loc_2.q_ground_effect + ".png");
            _loc_3.auto = true;
            _loc_3.updatePose("90", false, false, true, true);
            getSprite().addChild(_loc_3);
            return;
        }// end function

    }
}
