package com.model.vo
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.bean.*;
    import com.game.buff.bean.*;
    import com.game.equip.bean.*;
    import com.game.gem.bean.*;
    import com.game.structs.*;
    import com.game.utils.*;
    import com.staticdata.*;
    import flash.display.*;

    public class RoleInfo extends BaseEventDispatcher
    {
        protected var _q_gethit_type:Boolean;
        protected var _currentSkill:SkillInfo;
        protected var _q_head:String;
        protected var _q_evasive_style:int;
        protected var _q_mouse:int;
        private var _isInBlackRoom:Boolean;
        protected var _owner:long;
        protected var _headIcon:String;
        public var q_weight:uint = 100;
        protected var _roleType:uint;
        protected var _personId:long;
        protected var _name:String;
        protected var _sex:int;
        protected var _job:int;
        protected var _level:int;
        protected var _mapId:int;
        protected var _weapon:ItemCfg;
        protected var _weapon_other:ItemCfg;
        protected var _x:int;
        protected var _y:int;
        protected var _skill:int;
        protected var _skills:int;
        protected var _state:int;
        protected var _pkState:int;
        protected var _pkValue:int;
        protected var _exp:long;
        protected var _zhenqi:int;
        protected var _prestige:int;
        protected var _dir:int;
        protected var _avatar:int;
        protected var _positions:Vector.<Position>;
        protected var _equips:Vector.<EquipInfo>;
        protected var _cellnum:int;
        protected var _storecellnum:int;
        protected var _items:Vector.<ItemInfo>;
        protected var _maxExp:Number;
        protected var _money:int;
        protected var _gold:int;
        protected var _bindeddiamond:int;
        protected var _spirit:int;
        protected var _diamond:int;
        protected var _bindgold:int;
        protected var _nonage:int;
        protected var _horseweaponid:int;
        protected var _hiddenweaponid:int;
        protected var _posallgeminfo:Vector.<PosGemInfo>;
        protected var _maintaskId:int;
        protected var _kingcitybuffid:int;
        protected var _vipid:int;
        protected var _longyuanlv:int;
        protected var _longyuannum:int;
        protected var _ranklevel:int;
        protected var _webvip:int;
        protected var _webvip2:int;
        protected var _equipPetId:int;
        protected var _battleExp:int;
        protected var _attack:int;
        protected var _defense:int;
        protected var _dodge:int;
        protected var _crit:int;
        protected var _luck:int;
        protected var _attackspeed:int;
        protected var _wingInfo:ItemCfg;
        protected var _armor:ItemCfg;
        protected var _allStrength:int;
        protected var _isBecome:Boolean;
        protected var _sculpt_zoom:int;
        protected var _monster_type:int;
        protected var _enemies:Vector.<long>;
        protected var _csysKills:int;
        protected var _topTitleId:int;
        protected var _suitEffectCount:int;
        protected var _suitEffectIds:Array;
        protected var _hp:uint;
        protected var _hpMax:uint;
        protected var _mp:uint;
        protected var _mpMax:uint;
        protected var _sp:uint;
        protected var _spMax:uint;
        protected var _skillList:Vector.<SkillInfo>;
        protected var _defaultSkillId:int;
        protected var _cfgId:uint;
        public var ifLayout:Boolean;
        protected var _url:String;
        private var _actType:String = "act01";
        public var direct:int = 90;
        private var _showID:String;
        private var _orginFightNumer:int;
        private var _artifact:int;
        public var artifactRemold:Vector.<ArtifactRemoldInfo>;
        protected var _horseInfo:HorseInfo;
        public var jobkind:int;
        public var atkRange:uint = 1;
        public var position:uint;
        public var side:int;
        protected var _speed:uint = 500;
        private var _guildId:long;
        private var _guildName:String;
        public var strPills:Array;
        public var atsPills:Array;
        public var buffs:Array;
        public var atkId:uint;
        private var _fightPower:int;
        protected var _headPic:String = "";
        protected var _standPic:String = "";
        public var bigHeadPic:String = "";
        private var _icon:String = "";
        public var atkedRes:String = "atkedRes1";
        private var _lastLevel:int = 0;
        private var _levelUp:Boolean = false;
        public static const DEFAULT_SPEED:uint = 500;

        public function RoleInfo()
        {
            this._positions = new Vector.<Position>;
            this._equips = new Vector.<EquipInfo>;
            this._items = new Vector.<ItemInfo>;
            this._posallgeminfo = new Vector.<PosGemInfo>;
            this._enemies = new Vector.<long>;
            this._suitEffectIds = [];
            this.buffs = [];
            return;
        }// end function

        public function get suitEffectIds() : Array
        {
            return this._suitEffectIds;
        }// end function

        public function set suitEffectIds(param1:Array) : void
        {
            this._suitEffectIds = param1;
            return;
        }// end function

        public function get suitEffectCount() : int
        {
            return this._suitEffectCount;
        }// end function

        public function set suitEffectCount(param1:int) : void
        {
            this._suitEffectCount = param1;
            return;
        }// end function

        public function set isInBlack(param1:int) : void
        {
            this._isInBlackRoom = param1 == 1 ? (true) : (false);
            return;
        }// end function

        public function isBlack() : Boolean
        {
            return this._isInBlackRoom;
        }// end function

        public function get topTitleId() : int
        {
            return this._topTitleId;
        }// end function

        public function set topTitleId(param1:int) : void
        {
            if (this._topTitleId != param1)
            {
                this._topTitleId = param1;
            }
            return;
        }// end function

        public function get q_mouse() : int
        {
            return this._q_mouse;
        }// end function

        public function set q_mouse(param1:int) : void
        {
            this._q_mouse = param1;
            return;
        }// end function

        public function get q_evasive_style() : int
        {
            return this._q_evasive_style;
        }// end function

        public function set q_evasive_style(param1:int) : void
        {
            this._q_evasive_style = param1;
            return;
        }// end function

        public function get q_head() : String
        {
            return this._q_head;
        }// end function

        public function set q_head(param1:String) : void
        {
            this._q_head = param1;
            return;
        }// end function

        public function get orginFightNumer() : int
        {
            return this._orginFightNumer;
        }// end function

        public function set orginFightNumer(param1:int) : void
        {
            this._orginFightNumer = param1;
            return;
        }// end function

        public function get q_gethit_type() : Boolean
        {
            return this._q_gethit_type;
        }// end function

        public function set q_gethit_type(param1:Boolean) : void
        {
            this._q_gethit_type = param1;
            return;
        }// end function

        public function get allStrength() : int
        {
            return this._allStrength;
        }// end function

        public function set allStrength(param1:int) : void
        {
            this._allStrength = param1;
            return;
        }// end function

        public function get wingInfo() : ItemCfg
        {
            return this._wingInfo;
        }// end function

        public function set wingInfo(param1:ItemCfg) : void
        {
            this._wingInfo = param1;
            return;
        }// end function

        public function get headIcon() : String
        {
            return this._headIcon;
        }// end function

        public function set headIcon(param1:String) : void
        {
            this._headIcon = param1;
            return;
        }// end function

        public function get icon() : String
        {
            return this._icon;
        }// end function

        public function get actType() : String
        {
            return this._actType;
        }// end function

        public function set actType(param1:String) : void
        {
            this._actType = param1;
            return;
        }// end function

        public function get weapon_other() : ItemCfg
        {
            return this._weapon_other;
        }// end function

        public function set weapon_other(param1:ItemCfg) : void
        {
            this._weapon_other = param1;
            return;
        }// end function

        public function get weapon() : ItemCfg
        {
            return this._weapon;
        }// end function

        public function set weapon(param1:ItemCfg) : void
        {
            this._weapon = param1;
            return;
        }// end function

        public function set currentSkill(param1:SkillInfo) : void
        {
            this._currentSkill = param1;
            return;
        }// end function

        public function get currentSkill() : SkillInfo
        {
            return this._currentSkill;
        }// end function

        public function get owner() : long
        {
            return this._owner;
        }// end function

        public function set owner(param1:long) : void
        {
            this._owner = param1;
            return;
        }// end function

        public function get armor() : ItemCfg
        {
            return this._armor;
        }// end function

        public function set armor(param1:ItemCfg) : void
        {
            var _loc_2:* = null;
            this._armor = param1;
            if (param1)
            {
                this.showID = this._armor.q_equip_resource;
            }
            else if (this.job > 0)
            {
                _loc_2 = PlayerCfgObj.getInstance().getPriObjByJob(this._job);
                this.showID = _loc_2.model_resourse;
            }
            return;
        }// end function

        public function get equipPetId() : int
        {
            return this._equipPetId;
        }// end function

        public function set equipPetId(param1:int) : void
        {
            this._equipPetId = param1;
            return;
        }// end function

        public function get horseInfo() : HorseInfo
        {
            return this._horseInfo;
        }// end function

        public function set horseInfo(param1:HorseInfo) : void
        {
            this._horseInfo = param1;
            return;
        }// end function

        public function get fightPower() : int
        {
            return this._fightPower;
        }// end function

        public function set fightPower(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 == this._fightPower)
            {
                return;
            }
            if (param1 - this._fightPower >= GlobalCfgObj.getInstance().getFightChangeValue() && this._fightPower != 0)
            {
                _loc_2 = ToolKit.getNew("fightUP");
                _loc_2.mouseEnabled = false;
                _loc_3 = "+" + (param1 - this._fightPower);
                Global.popManager.addedFightTips(_loc_2, _loc_3);
            }
            else
            {
                this._fightPower = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_FIGHT_DOWN_NUMBER));
            }
            this._fightPower = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_FIGHT_NUMBER));
            if (this._orginFightNumer > -1)
            {
                if (this._fightPower > this._orginFightNumer)
                {
                    dispatchEvent(new RoleEvent(RoleEvent.FIGHT_NUMBER_UP, this._fightPower - this._orginFightNumer));
                    this._orginFightNumer = -1;
                }
            }
            return;
        }// end function

        public function get maxExp() : Number
        {
            return this._maxExp;
        }// end function

        public function set maxExp(param1:Number) : void
        {
            this._maxExp = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MAX_EXP));
            return;
        }// end function

        public function get roleType() : uint
        {
            return this._roleType;
        }// end function

        public function set roleType(param1:uint) : void
        {
            this._roleType = param1;
            return;
        }// end function

        public function get defaultSkillId() : int
        {
            return this._defaultSkillId;
        }// end function

        public function set defaultSkillId(param1:int) : void
        {
            this._defaultSkillId = param1;
            return;
        }// end function

        public function get skillList() : Vector.<SkillInfo>
        {
            return this._skillList;
        }// end function

        public function set skillList(param1:Vector.<SkillInfo>) : void
        {
            this._skillList = param1;
            return;
        }// end function

        public function get cfgId() : uint
        {
            return this._cfgId;
        }// end function

        public function set cfgId(param1:uint) : void
        {
            this._cfgId = param1;
            return;
        }// end function

        public function get speed() : uint
        {
            return this._speed;
        }// end function

        public function set speed(param1:uint) : void
        {
            this._speed = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_SPEED));
            return;
        }// end function

        public function get showID() : String
        {
            return this._showID;
        }// end function

        public function set showID(param1:String) : void
        {
            this._showID = param1;
            this._url = Params.ROLE_RES_PATH + this._showID;
            this._headIcon = Params.ROLE_HEAD_PATH + this._showID + ".png";
            return;
        }// end function

        public function get diamond() : int
        {
            return this._diamond;
        }// end function

        public function set diamond(param1:int) : void
        {
            this._diamond = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DIAMOND));
            return;
        }// end function

        public function get attackspeed() : int
        {
            return this._attackspeed;
        }// end function

        public function set attackspeed(param1:int) : void
        {
            this._attackspeed = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_ATTACKSPEED));
            return;
        }// end function

        public function get luck() : int
        {
            return this._luck;
        }// end function

        public function set luck(param1:int) : void
        {
            this._luck = param1;
            return;
        }// end function

        public function get crit() : int
        {
            return this._crit;
        }// end function

        public function set crit(param1:int) : void
        {
            this._crit = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_CRIT));
            return;
        }// end function

        public function get dodge() : int
        {
            return this._dodge;
        }// end function

        public function set dodge(param1:int) : void
        {
            this._dodge = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DODGE));
            return;
        }// end function

        public function get defense() : int
        {
            return this._defense;
        }// end function

        public function set defense(param1:int) : void
        {
            this._defense = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_DEFENSE));
            return;
        }// end function

        public function get attack() : int
        {
            return this._attack;
        }// end function

        public function set attack(param1:int) : void
        {
            this._attack = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_ATTACK));
            return;
        }// end function

        public function get battleExp() : int
        {
            return this._battleExp;
        }// end function

        public function set battleExp(param1:int) : void
        {
            this._battleExp = param1;
            return;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
            return;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            var _loc_2:* = 0;
            this._job = param1;
            this._headIcon = Params.ROLE_HEAD_PATH + "job" + this._job + ".png";
            if (param1 < 100)
            {
                this.jobkind = (this.job - 1) % 3 + 1;
            }
            else
            {
                _loc_2 = this.job % 100;
                this.jobkind = (_loc_2 - 1) % 3 + 4;
            }
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_JOB));
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function get spirit() : int
        {
            return this._spirit;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function set url(param1:String) : void
        {
            this._url = param1;
            return;
        }// end function

        public function get standPic() : String
        {
            return this._standPic;
        }// end function

        public function set standPic(param1:String) : void
        {
            this._standPic = param1;
            return;
        }// end function

        public function get headPic() : String
        {
            return this._headPic;
        }// end function

        public function set headPic(param1:String) : void
        {
            this._headPic = param1;
            return;
        }// end function

        public function get HP() : int
        {
            return this._hp;
        }// end function

        public function set HP(param1:int) : void
        {
            if (this._hp != param1)
            {
                if (this._hpMax > 0 && param1 > this._hpMax)
                {
                    this._hp = this._hpMax;
                }
                else
                {
                    this._hp = param1;
                }
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_HP));
            }
            return;
        }// end function

        public function get HPMax() : uint
        {
            return this._hpMax;
        }// end function

        public function set HPMax(param1:uint) : void
        {
            if (this._hpMax != param1)
            {
                this._hpMax = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_HPMAX));
            }
            return;
        }// end function

        public function get MP() : int
        {
            return this._mp;
        }// end function

        public function set MP(param1:int) : void
        {
            if (this._mp != param1)
            {
                if (this._mpMax > 0 && param1 > this._mpMax)
                {
                    this._mp = this._mpMax;
                }
                else
                {
                    this._mp = param1;
                }
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MP));
            }
            return;
        }// end function

        public function get MPMax() : uint
        {
            return this._mpMax;
        }// end function

        public function set MPMax(param1:uint) : void
        {
            if (this._mpMax != param1)
            {
                this._mpMax = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MPMAX));
            }
            return;
        }// end function

        public function get SP() : int
        {
            return this._sp;
        }// end function

        public function set SP(param1:int) : void
        {
            if (this._sp != param1)
            {
                if (this._spMax > 0 && param1 > this._spMax)
                {
                    this._sp = this._spMax;
                }
                else
                {
                    this._sp = param1;
                }
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_SP));
            }
            return;
        }// end function

        public function get SPMax() : uint
        {
            return this._spMax;
        }// end function

        public function set SPMax(param1:uint) : void
        {
            if (this._spMax != param1)
            {
                this._spMax = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_SPMAX));
            }
            return;
        }// end function

        public function alive() : Boolean
        {
            return this.HP > 0 || this.HPMax == 0;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function set level(param1:int) : void
        {
            if (this._level != param1)
            {
                if (this._level == 0)
                {
                    this._lastLevel = param1;
                }
                else
                {
                    this._lastLevel = this._level;
                    this._levelUp = true;
                }
                this._level = param1;
                dispatchEvent(new RoleEvent(RoleEvent.UPDATE_LEVEL, {pre:this._lastLevel}));
            }
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get skill() : int
        {
            return this._skill;
        }// end function

        public function set skill(param1:int) : void
        {
            this._skill = param1;
            return;
        }// end function

        public function get skills() : int
        {
            return this._skills;
        }// end function

        public function set skills(param1:int) : void
        {
            this._skills = param1;
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get pkState() : int
        {
            return this._pkState;
        }// end function

        public function set pkState(param1:int) : void
        {
            this._pkState = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PK_STATE));
            return;
        }// end function

        public function get pkValue() : int
        {
            return this._pkValue;
        }// end function

        public function set pkValue(param1:int) : void
        {
            this._pkValue = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_PK_VALUE));
            return;
        }// end function

        public function get exp() : long
        {
            return this._exp;
        }// end function

        public function set exp(param1:long) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = this._exp.toNumber();
            if (!this._levelUp)
            {
                _loc_2 = param1.toNumber() - _loc_3;
            }
            else
            {
                _loc_2 = LevelExpCfgObj.getInstance().getExpByLevel(this._job, this._lastLevel) - _loc_3;
                _loc_4 = this._lastLevel + 1;
                while (_loc_4 < this.level)
                {
                    
                    _loc_5 = LevelExpCfgObj.getInstance().getExpByLevel(this._job, _loc_4);
                    _loc_2 = _loc_2 + _loc_5;
                    _loc_4++;
                }
                _loc_2 = _loc_2 + param1.toNumber();
            }
            this._levelUp = false;
            this._exp = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_EXP, _loc_2));
            return;
        }// end function

        public function get zhenqi() : int
        {
            return this._zhenqi;
        }// end function

        public function set zhenqi(param1:int) : void
        {
            this._zhenqi = param1;
            return;
        }// end function

        public function get prestige() : int
        {
            return this._prestige;
        }// end function

        public function set prestige(param1:int) : void
        {
            this._prestige = param1;
            return;
        }// end function

        public function get dir() : int
        {
            return this._dir;
        }// end function

        public function set dir(param1:int) : void
        {
            this._dir = param1;
            return;
        }// end function

        public function get avatar() : int
        {
            return this._avatar;
        }// end function

        public function set avatar(param1:int) : void
        {
            this._avatar = param1;
            return;
        }// end function

        public function get positions() : Vector.<Position>
        {
            return this._positions;
        }// end function

        public function set positions(param1:Vector.<Position>) : void
        {
            this._positions = param1;
            return;
        }// end function

        public function get equips() : Vector.<EquipInfo>
        {
            return this._equips;
        }// end function

        public function set equips(param1:Vector.<EquipInfo>) : void
        {
            this._equips = param1;
            return;
        }// end function

        public function get cellnum() : int
        {
            return this._cellnum;
        }// end function

        public function set cellnum(param1:int) : void
        {
            this._cellnum = param1;
            return;
        }// end function

        public function get storecellnum() : int
        {
            return this._storecellnum;
        }// end function

        public function set storecellnum(param1:int) : void
        {
            this._storecellnum = param1;
            return;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_MONEY));
            return;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_GOLD));
            return;
        }// end function

        public function set spirit(param1:int) : void
        {
            this._spirit = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_SPIRIT));
            return;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_BINDGOLD));
            return;
        }// end function

        public function get nonage() : int
        {
            return this._nonage;
        }// end function

        public function set nonage(param1:int) : void
        {
            this._nonage = param1;
            return;
        }// end function

        public function get horseweaponid() : int
        {
            return this._horseweaponid;
        }// end function

        public function set horseweaponid(param1:int) : void
        {
            this._horseweaponid = param1;
            return;
        }// end function

        public function get hiddenweaponid() : int
        {
            return this._hiddenweaponid;
        }// end function

        public function set hiddenweaponid(param1:int) : void
        {
            this._hiddenweaponid = param1;
            return;
        }// end function

        public function get posallgeminfo() : Vector.<PosGemInfo>
        {
            return this._posallgeminfo;
        }// end function

        public function set posallgeminfo(param1:Vector.<PosGemInfo>) : void
        {
            this._posallgeminfo = param1;
            return;
        }// end function

        public function get maintaskId() : int
        {
            return this._maintaskId;
        }// end function

        public function set maintaskId(param1:int) : void
        {
            this._maintaskId = param1;
            return;
        }// end function

        public function get kingcitybuffid() : int
        {
            return this._kingcitybuffid;
        }// end function

        public function set kingcitybuffid(param1:int) : void
        {
            this._kingcitybuffid = param1;
            return;
        }// end function

        public function get vipid() : int
        {
            return this._vipid;
        }// end function

        public function set vipid(param1:int) : void
        {
            this._vipid = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_VIP_LEVEL));
            return;
        }// end function

        public function get longyuanlv() : int
        {
            return this._longyuanlv;
        }// end function

        public function set longyuanlv(param1:int) : void
        {
            this._longyuanlv = param1;
            return;
        }// end function

        public function get longyuannum() : int
        {
            return this._longyuannum;
        }// end function

        public function set longyuannum(param1:int) : void
        {
            this._longyuannum = param1;
            return;
        }// end function

        public function get ranklevel() : int
        {
            return this._ranklevel;
        }// end function

        public function set ranklevel(param1:int) : void
        {
            this._ranklevel = param1;
            return;
        }// end function

        public function get webvip() : int
        {
            return this._webvip;
        }// end function

        public function set webvip(param1:int) : void
        {
            this._webvip = param1;
            return;
        }// end function

        public function get webvip2() : int
        {
            return this._webvip2;
        }// end function

        public function set webvip2(param1:int) : void
        {
            this._webvip2 = param1;
            return;
        }// end function

        public function isPlayer(param1:long) : Boolean
        {
            if (this.personId)
            {
                return this.personId.equal(param1);
            }
            return false;
        }// end function

        public function initBuffs(param1:Vector.<CSBuffInfo>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                this.addBuff(_loc_2);
            }
            return;
        }// end function

        public function addBuff(param1:CSBuffInfo, param2:Boolean = false) : BuffInfo
        {
            var _loc_3:* = this.addOneBuff(param1);
            if (!_loc_3)
            {
                return _loc_3;
            }
            var _loc_4:* = new RoleEvent(RoleEvent.UPDATE_BUFF);
            _loc_4.obj = {op:"AU", t:_loc_3.q_buff_id};
            dispatchEvent(_loc_4);
            return _loc_3;
        }// end function

        private function addOneBuff(param1:CSBuffInfo) : BuffInfo
        {
            var _loc_2:* = this.checkAddBuff(param1);
            if (!_loc_2)
            {
                _loc_2 = BuffCfgObj.getInstance().getBuffInfo(param1.modelId);
                if (_loc_2)
                {
                    _loc_2.conv(param1);
                    _loc_2.num = 1;
                    _loc_2.buffIds.push(param1.buffId);
                    this.buffs.push(_loc_2);
                }
            }
            return _loc_2;
        }// end function

        private function checkAddBuff(param1:CSBuffInfo) : BuffInfo
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.buffs.length)
            {
                
                if (param1.modelId == this.buffs[_loc_2].q_buff_id)
                {
                    var _loc_3:* = this.buffs[_loc_2];
                    var _loc_4:* = _loc_3.num + 1;
                    _loc_3.num = _loc_4;
                    _loc_3.buffIds.push(param1.buffId);
                    return this.buffs[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function removeBuff(param1:long) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = this.buffs.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_3 = this.buffs[_loc_6];
                if (_loc_3)
                {
                    _loc_5 = _loc_3.buffIds.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_5)
                    {
                        
                        _loc_4 = _loc_3.buffIds[_loc_7];
                        if (_loc_4 && _loc_4.equal(param1))
                        {
                            _loc_3.buffIds.splice(_loc_7, 1);
                            var _loc_9:* = _loc_3;
                            var _loc_10:* = _loc_3.num - 1;
                            _loc_9.num = _loc_10;
                            if (_loc_3.num == 0)
                            {
                                this.buffs.splice(_loc_6, 1);
                            }
                            _loc_8 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                            _loc_8.obj = {op:"D", t:_loc_3.q_buff_id};
                            dispatchEvent(_loc_8);
                            return _loc_3;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return null;
        }// end function

        public function removeBuffByModelId(param1:int) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_2:* = this.buffs.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this.buffs[_loc_4];
                if (_loc_3)
                {
                    if (_loc_3.q_buff_id == param1)
                    {
                        _loc_3.buffIds.length = 0;
                        _loc_3.num = 0;
                        this.buffs.splice(_loc_4, 1);
                        _loc_5 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                        _loc_5.obj = {op:"D", t:_loc_3.q_buff_id};
                        dispatchEvent(_loc_5);
                        return _loc_3;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            return null;
        }// end function

        public function updateBuff(param1:CSBuffInfo) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this.buffs.length)
            {
                
                if (param1.modelId == this.buffs[_loc_2].q_buff_id)
                {
                    this.buffs[_loc_2].overlay = param1.overlay;
                    this.buffs[_loc_2].percent = param1.percent;
                    this.buffs[_loc_2].remain = param1.remain;
                    this.buffs[_loc_2].total = param1.total;
                    this.buffs[_loc_2].value = param1.value;
                    _loc_3 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                    _loc_3.obj = {op:"AU", t:this.buffs[_loc_2].q_buff_id};
                    dispatchEvent(_loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getBuff(param1:long) : BuffInfo
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.buffs)
            {
                
                if (_loc_2)
                {
                    if (_loc_2.buffId.equal(param1))
                    {
                        return _loc_2;
                    }
                }
            }
            return null;
        }// end function

        public function getBuffsByActType(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this.buffs)
            {
                
                if (_loc_3)
                {
                    if (_loc_3.q_action_type == param1)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getBuffByModelId(param1:int) : BuffInfo
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.buffs)
            {
                
                if (_loc_2)
                {
                    if (_loc_2.q_buff_id == param1)
                    {
                        return _loc_2;
                    }
                }
            }
            return null;
        }// end function

        public function getBecomeBuffSkillId() : int
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.buffs)
            {
                
                if (_loc_1)
                {
                    if (_loc_1.q_buff_id == BuffSpecilId.BECOME1 || _loc_1.q_buff_id == BuffSpecilId.BECOME2 || _loc_1.q_buff_id == BuffSpecilId.BECOME3 || _loc_1.q_buff_id == BuffSpecilId.BECOME4)
                    {
                        return _loc_1.q_shapechange_skill;
                    }
                }
            }
            return 0;
        }// end function

        public function setAttributte(param1) : void
        {
            Attributes.setAttr(this, param1);
            return;
        }// end function

        public function get guildName() : String
        {
            return this._guildName;
        }// end function

        public function set guildName(param1:String) : void
        {
            this._guildName = param1;
            return;
        }// end function

        public function get guildId() : long
        {
            return this._guildId;
        }// end function

        public function set guildId(param1:long) : void
        {
            this._guildId = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_GUILD_ID));
            return;
        }// end function

        public function get isBecome() : Boolean
        {
            return this._isBecome;
        }// end function

        public function set isBecome(param1:Boolean) : void
        {
            this._isBecome = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_BECOME, param1));
            return;
        }// end function

        public function get csysKills() : int
        {
            return this._csysKills;
        }// end function

        public function set csysKills(param1:int) : void
        {
            this._csysKills = param1;
            dispatchEvent(new RoleEvent(RoleEvent.UPDATE_CSYS_KILLS));
            return;
        }// end function

        public function get sculpt_zoom() : int
        {
            return this._sculpt_zoom;
        }// end function

        public function set sculpt_zoom(param1:int) : void
        {
            this._sculpt_zoom = param1;
            return;
        }// end function

        public function get monster_type() : int
        {
            return this._monster_type;
        }// end function

        public function set monster_type(param1:int) : void
        {
            this._monster_type = param1;
            return;
        }// end function

        public function get enemies() : Vector.<long>
        {
            return this._enemies;
        }// end function

        public function set enemies(param1:Vector.<long>) : void
        {
            this._enemies = param1;
            return;
        }// end function

        public function get artifact() : int
        {
            return this._artifact;
        }// end function

        public function set artifact(param1:int) : void
        {
            this._artifact = param1;
            return;
        }// end function

        public function setRoleInfo(param1:int, param2:int, param3:int, param4:ItemCfg, param5:ItemCfg, param6:ItemCfg, param7:ItemCfg) : void
        {
            this.roleType = RoleType.ROLE_TYPE_PLAYER;
            this.actType = Params.ACTION_STAND_ID;
            this.avatar = param2;
            this.job = param3;
            this.direct = 180;
            this.level = param1;
            this.armor = param4;
            this.weapon = param5;
            this.weapon_other = param6;
            this.wingInfo = param7;
            return;
        }// end function

        public static function getJobName(param1:uint) : String
        {
            var _loc_2:* = "";
            _loc_2 = JobType.getJobName(param1);
            if (_loc_2 == null)
            {
                trace("HeroInfo::getJobName,Error! unknow job id:" + param1);
            }
            return _loc_2;
        }// end function

    }
}
