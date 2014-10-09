package com.game.player.message
{
    import __AS3__.vec.*;
    import com.game.arrow.bean.*;
    import com.game.backpack.bean.*;
    import com.game.equip.bean.*;
    import com.game.gem.bean.*;
    import com.game.player.bean.*;
    import com.game.structs.*;
    import com.game.utils.*;
    import com.model.*;
    import net.*;

    public class ResMyPlayerInfoMessage extends Message
    {
        private var _personId:long;
        private var _name:String;
        private var _sex:int;
        private var _job:int;
        private var _level:int;
        private var _mapId:int;
        private var _x:int;
        private var _y:int;
        private var _skill:int;
        private var _skills:int;
        private var _state:int;
        private var _pkState:int;
        private var _exp:long;
        private var _zhenqi:int;
        private var _prestige:int;
        private var _dir:int;
        private var _avatar:int;
        private var _attributes:Vector.<PlayerAttributeItem>;
        private var _positions:Vector.<Position>;
        private var _equips:Vector.<EquipInfo>;
        private var _cellnum:int;
        private var _storecellnum:int;
        private var _items:Vector.<ItemInfo>;
        private var _cellTime:int;
        private var _gridId:int;
        private var _money:int;
        private var _gold:int;
        private var _bindgold:int;
        private var _nonage:int;
        private var _horseid:int;
        private var _horseweaponid:int;
        private var _hiddenweaponid:int;
        private var _posallgeminfo:Vector.<PosGemInfo>;
        private var _maintaskId:int;
        private var _kingcitybuffid:int;
        private var _vipid:int;
        private var _longyuanlv:int;
        private var _longyuannum:int;
        private var _ranklevel:int;
        private var _arrowInfo:ArrowInfo;
        private var _webvip:int;
        private var _webvip2:int;
        private var _power:int;
        private var _agile:int;
        private var _horseduangu:int;
        private var _strength:int;
        private var _wit:int;
        private var _unallocatedTalent:int;
        private var _ice_attack:int;
        private var _ray_attack:int;
        private var _poison_attack:int;
        private var _ice_def:int;
        private var _ray_def:int;
        private var _poison_def:int;
        private var _gnore_attackPercent:int;
        private var _hit:int;
        private var _dodge:int;
        private var _hitPercent:int;
        private var _dodgePercent:int;
        private var _crit:int;
        private var _critPercent:int;
        private var _attackPercent:int;
        private var _physic_attackPercent:int;
        private var _magic_attackPercent:int;
        private var _Knowing_attackPercent:int;
        private var _fatal_blow:int;
        private var _physic_attackupper:int;
        private var _physic_attacklower:int;
        private var _magic_attackupper:int;
        private var _magic_attacklower:int;
        private var _ignore_attackPercent:int;
        private var _attack:int;
        private var _defense:int;
        private var _defensePercent:int;
        private var _teamId:long;
        private var _guild:long;
        private var _guildName:String;
        private var _gm:int;
        private var _createTime:long;
        private var _speed:int;
        private var _spirit:int;
        private var _pkValue:int;
        private var _enemies:Vector.<long>;
        private var _firstWeiDuan:int;
        private var _config:int;
        public var topTitleId:int;
        public var suitEffectCount:int;
        public var suitEffectIds:Array;
        public var magicBookLevel:int;
        public var magicBookStar:int;

        public function ResMyPlayerInfoMessage()
        {
            this._attributes = new Vector.<PlayerAttributeItem>;
            this._positions = new Vector.<Position>;
            this._equips = new Vector.<EquipInfo>;
            this._items = new Vector.<ItemInfo>;
            this._posallgeminfo = new Vector.<PosGemInfo>;
            this._enemies = new Vector.<long>;
            return;
        }// end function

        public function get pkValue() : int
        {
            return this._pkValue;
        }// end function

        public function set pkValue(param1:int) : void
        {
            this._pkValue = param1;
            return;
        }// end function

        public function get gm() : int
        {
            return this._gm;
        }// end function

        public function set gm(param1:int) : void
        {
            this._gm = param1;
            return;
        }// end function

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function set gridId(param1:int) : void
        {
            this._gridId = param1;
            return;
        }// end function

        public function get cellTime() : int
        {
            return this._cellTime;
        }// end function

        public function set cellTime(param1:int) : void
        {
            this._cellTime = param1;
            return;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function set speed(param1:int) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function get defense() : int
        {
            return this._defense;
        }// end function

        public function set defense(param1:int) : void
        {
            this._defense = param1;
            return;
        }// end function

        public function get defensePercent() : int
        {
            return this._defensePercent;
        }// end function

        public function set defensePercent(param1:int) : void
        {
            this._defensePercent = param1;
            return;
        }// end function

        public function get attack() : int
        {
            return this._attack;
        }// end function

        public function set attack(param1:int) : void
        {
            this._attack = param1;
            return;
        }// end function

        public function get ignore_attackPercent() : int
        {
            return this._ignore_attackPercent;
        }// end function

        public function set ignore_attackPercent(param1:int) : void
        {
            this._ignore_attackPercent = param1;
            return;
        }// end function

        public function get magic_attacklower() : int
        {
            return this._magic_attacklower;
        }// end function

        public function set magic_attacklower(param1:int) : void
        {
            this._magic_attacklower = param1;
            return;
        }// end function

        public function get magic_attackupper() : int
        {
            return this._magic_attackupper;
        }// end function

        public function set magic_attackupper(param1:int) : void
        {
            this._magic_attackupper = param1;
            return;
        }// end function

        public function get physic_attacklower() : int
        {
            return this._physic_attacklower;
        }// end function

        public function set physic_attacklower(param1:int) : void
        {
            this._physic_attacklower = param1;
            return;
        }// end function

        public function get physic_attackupper() : int
        {
            return this._physic_attackupper;
        }// end function

        public function set physic_attackupper(param1:int) : void
        {
            this._physic_attackupper = param1;
            return;
        }// end function

        public function get Knowing_attackPercent() : int
        {
            return this._Knowing_attackPercent;
        }// end function

        public function set Knowing_attackPercent(param1:int) : void
        {
            this._Knowing_attackPercent = param1;
            return;
        }// end function

        public function get fatal_blow() : int
        {
            return this._fatal_blow;
        }// end function

        public function set fatal_blow(param1:int) : void
        {
            this._fatal_blow = param1;
            return;
        }// end function

        public function get magic_attackPercent() : int
        {
            return this._magic_attackPercent;
        }// end function

        public function set magic_attackPercent(param1:int) : void
        {
            this._magic_attackPercent = param1;
            return;
        }// end function

        public function get physic_attackPercent() : int
        {
            return this._physic_attackPercent;
        }// end function

        public function set physic_attackPercent(param1:int) : void
        {
            this._physic_attackPercent = param1;
            return;
        }// end function

        public function get attackPercent() : int
        {
            return this._attackPercent;
        }// end function

        public function set attackPercent(param1:int) : void
        {
            this._attackPercent = param1;
            return;
        }// end function

        public function get critPercent() : int
        {
            return this._critPercent;
        }// end function

        public function set critPercent(param1:int) : void
        {
            this._critPercent = param1;
            return;
        }// end function

        public function get crit() : int
        {
            return this._crit;
        }// end function

        public function set crit(param1:int) : void
        {
            this._crit = param1;
            return;
        }// end function

        public function get dodgePercent() : int
        {
            return this._dodgePercent;
        }// end function

        public function set dodgePercent(param1:int) : void
        {
            this._dodgePercent = param1;
            return;
        }// end function

        public function get hitPercent() : int
        {
            return this._hitPercent;
        }// end function

        public function set hitPercent(param1:int) : void
        {
            this._hitPercent = param1;
            return;
        }// end function

        public function get dodge() : int
        {
            return this._dodge;
        }// end function

        public function set dodge(param1:int) : void
        {
            this._dodge = param1;
            return;
        }// end function

        public function get hit() : int
        {
            return this._hit;
        }// end function

        public function set hit(param1:int) : void
        {
            this._hit = param1;
            return;
        }// end function

        public function get gnore_attackPercent() : Number
        {
            return this._gnore_attackPercent;
        }// end function

        public function set gnore_attackPercent(param1:Number) : void
        {
            this._gnore_attackPercent = param1;
            return;
        }// end function

        public function get poison_def() : int
        {
            return this._poison_def;
        }// end function

        public function set poison_def(param1:int) : void
        {
            this._poison_def = param1;
            return;
        }// end function

        public function get ray_def() : int
        {
            return this._ray_def;
        }// end function

        public function set ray_def(param1:int) : void
        {
            this._ray_def = param1;
            return;
        }// end function

        public function get ice_def() : int
        {
            return this._ice_def;
        }// end function

        public function set ice_def(param1:int) : void
        {
            this._ice_def = param1;
            return;
        }// end function

        public function get poison_attack() : int
        {
            return this._poison_attack;
        }// end function

        public function set poison_attack(param1:int) : void
        {
            this._poison_attack = param1;
            return;
        }// end function

        public function get ray_attack() : int
        {
            return this._ray_attack;
        }// end function

        public function set ray_attack(param1:int) : void
        {
            this._ray_attack = param1;
            return;
        }// end function

        public function get ice_attack() : int
        {
            return this._ice_attack;
        }// end function

        public function set ice_attack(param1:int) : void
        {
            this._ice_attack = param1;
            return;
        }// end function

        public function get power() : int
        {
            return this._power;
        }// end function

        public function set power(param1:int) : void
        {
            this._power = param1;
            return;
        }// end function

        public function get agile() : int
        {
            return this._agile;
        }// end function

        public function set agile(param1:int) : void
        {
            this._agile = param1;
            return;
        }// end function

        public function get strength() : int
        {
            return this._strength;
        }// end function

        public function set strength(param1:int) : void
        {
            this._strength = param1;
            return;
        }// end function

        public function get wit() : int
        {
            return this._wit;
        }// end function

        public function set wit(param1:int) : void
        {
            this._wit = param1;
            return;
        }// end function

        public function get reserved() : int
        {
            return this._unallocatedTalent;
        }// end function

        public function set reserved(param1:int) : void
        {
            this._unallocatedTalent = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._personId);
            writeString(this._name);
            writeInt(this._sex);
            writeInt(this._job);
            writeInt(this._level);
            writeInt(this._mapId);
            writeShort(this._x);
            writeShort(this._y);
            writeByte(this._skill);
            writeInt(this._skills);
            writeInt(this._state);
            writeInt(this._pkState);
            writeLong(this._exp);
            writeInt(this._zhenqi);
            writeInt(this._prestige);
            writeByte(this._dir);
            writeInt(this._avatar);
            writeShort(this._attributes.length);
            _loc_1 = 0;
            while (_loc_1 < this._attributes.length)
            {
                
                writeBean(this._attributes[_loc_1]);
                _loc_1++;
            }
            writeShort(this._positions.length);
            _loc_1 = 0;
            while (_loc_1 < this._positions.length)
            {
                
                writeBean(this._positions[_loc_1]);
                _loc_1++;
            }
            writeShort(this._equips.length);
            _loc_1 = 0;
            while (_loc_1 < this._equips.length)
            {
                
                writeBean(this._equips[_loc_1]);
                _loc_1++;
            }
            writeShort(this._gridId);
            writeInt(this._cellTime);
            writeShort(this._cellnum);
            writeShort(this._storecellnum);
            writeShort(this._items.length);
            _loc_1 = 0;
            while (_loc_1 < this._items.length)
            {
                
                writeBean(this._items[_loc_1]);
                _loc_1++;
            }
            writeInt(this._money);
            writeInt(this._gold);
            writeInt(this._bindgold);
            writeInt(this._spirit);
            writeByte(this._nonage);
            writeShort(this._horseid);
            writeShort(this._horseweaponid);
            writeShort(this._hiddenweaponid);
            writeShort(this._posallgeminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._posallgeminfo.length)
            {
                
                writeBean(this._posallgeminfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._maintaskId);
            writeInt(this._kingcitybuffid);
            writeInt(this._vipid);
            writeByte(this._longyuanlv);
            writeByte(this._longyuannum);
            writeByte(this._ranklevel);
            writeBean(this._arrowInfo);
            writeInt(this._webvip);
            writeInt(this._webvip2);
            writeInt(this._horseduangu);
            writeInt(this._power);
            writeInt(this._strength);
            writeInt(this._agile);
            writeInt(this._wit);
            writeInt(this._unallocatedTalent);
            writeLong(this.teamId);
            writeLong(this._guild);
            writeString(this._guildName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_1:* = 0;
            this._personId = readLong();
            this._name = readString();
            this._sex = readInt();
            this._job = readInt();
            this._gm = readInt();
            this._createTime = readLong();
            this._level = readInt();
            this._mapId = readInt();
            this._x = readShort();
            this._y = readShort();
            this._skill = readByte();
            this._skills = readInt();
            this._state = readInt();
            this._pkState = readInt();
            this._exp = readLong();
            this._zhenqi = readInt();
            this._prestige = readInt();
            this._dir = readByte();
            this._avatar = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._attributes[_loc_1] = readBean(PlayerAttributeItem) as PlayerAttributeItem;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._positions[_loc_1] = readBean(Position) as Position;
                _loc_1++;
            }
            var _loc_4:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                this._equips[_loc_1] = readBean(EquipInfo) as EquipInfo;
                _loc_1++;
            }
            this._cellnum = readShort();
            this._storecellnum = readShort();
            var _loc_5:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_5)
            {
                
                this._items[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            this._gridId = readShort();
            this._cellTime = readInt();
            this._money = readInt();
            this._gold = readInt();
            this._bindgold = readInt();
            this._spirit = readInt();
            this._nonage = readByte();
            this._horseid = readShort();
            this._horseweaponid = readShort();
            this._hiddenweaponid = readShort();
            var _loc_6:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_6)
            {
                
                this._posallgeminfo[_loc_1] = readBean(PosGemInfo) as PosGemInfo;
                _loc_1++;
            }
            this._maintaskId = readInt();
            this._kingcitybuffid = readInt();
            this._vipid = readInt();
            this._longyuanlv = readByte();
            this._longyuannum = readByte();
            this._ranklevel = readByte();
            this._arrowInfo = readBean(ArrowInfo) as ArrowInfo;
            this._webvip = readInt();
            this._webvip2 = readInt();
            this._horseduangu = readShort();
            this._power = readInt();
            this._strength = readInt();
            this._agile = readInt();
            this._wit = readInt();
            this._unallocatedTalent = readInt();
            this.teamId = readLong();
            this._guild = readLong();
            this._guildName = readString();
            this._pkValue = readInt();
            var _loc_7:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_7)
            {
                
                this._enemies.push(readLong());
                _loc_1++;
            }
            this._firstWeiDuan = readByte();
            this.topTitleId = readInt();
            var _loc_8:* = readShort();
            var _loc_9:* = [];
            var _loc_10:* = [];
            _loc_11 = 0;
            while (_loc_11 < _loc_8)
            {
                
                _loc_12 = readInt();
                _loc_13 = readInt();
                _loc_9.push(_loc_12);
                _loc_10.push(_loc_13);
                _loc_11++;
            }
            UserObj.getInstance().playerInfo.job = this._job;
            MyTitleData.instance.initMyTitles(_loc_9, _loc_10);
            MyTitleData.instance.topTitleId = this.topTitleId;
            this.suitEffectCount = readShort();
            this.suitEffectIds = [];
            _loc_11 = 0;
            while (_loc_11 < this.suitEffectCount)
            {
                
                this.suitEffectIds[_loc_11] = readInt();
                _loc_11++;
            }
            this._config = readInt();
            this.magicBookStar = readInt();
            this.magicBookLevel = readInt();
            UserObj.getInstance().playerInfo.isInBlack = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103107;
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

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
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

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
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
            return;
        }// end function

        public function get exp() : long
        {
            return this._exp;
        }// end function

        public function set exp(param1:long) : void
        {
            this._exp = param1;
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

        public function get attributes() : Vector.<PlayerAttributeItem>
        {
            return this._attributes;
        }// end function

        public function set attributes(param1:Vector.<PlayerAttributeItem>) : void
        {
            this._attributes = param1;
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

        public function get items() : Vector.<ItemInfo>
        {
            return this._items;
        }// end function

        public function set items(param1:Vector.<ItemInfo>) : void
        {
            this._items = param1;
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
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

        public function get horseid() : int
        {
            return this._horseid;
        }// end function

        public function set horseid(param1:int) : void
        {
            this._horseid = param1;
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

        public function get arrowInfo() : ArrowInfo
        {
            return this._arrowInfo;
        }// end function

        public function set arrowInfo(param1:ArrowInfo) : void
        {
            this._arrowInfo = param1;
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

        public function get teamId() : long
        {
            return this._teamId;
        }// end function

        public function set teamId(param1:long) : void
        {
            this._teamId = param1;
            return;
        }// end function

        public function get guild() : long
        {
            return this._guild;
        }// end function

        public function set guild(param1:long) : void
        {
            this._guild = param1;
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

        public function get createTime() : long
        {
            return this._createTime;
        }// end function

        public function set createTime(param1:long) : void
        {
            this._createTime = param1;
            return;
        }// end function

        public function get spirit() : int
        {
            return this._spirit;
        }// end function

        public function set spirit(param1:int) : void
        {
            this._spirit = param1;
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

        public function get firstWeiDuan() : int
        {
            return this._firstWeiDuan;
        }// end function

        public function get config() : int
        {
            return this._config;
        }// end function

        public function set config(param1:int) : void
        {
            this._config = param1;
            return;
        }// end function

    }
}
