package com.game.map.bean
{
    import __AS3__.vec.*;
    import com.game.buff.bean.*;
    import com.game.utils.*;
    import net.*;

    public class CSPlayerInfo extends Bean
    {
        private var _personId:long;
        private var _webvip:int;
        private var _name:String;
        private var _sex:int;
        private var _job:int;
        private var _level:int;
        private var _mapId:int;
        private var _x:int;
        private var _y:int;
        private var _hp:int;
        private var _maxHp:int;
        private var _mp:int;
        private var _maxMp:int;
        private var _sp:int;
        private var _maxSp:int;
        private var _speed:int;
        private var _state:int;
        private var _weapon:int;
        private var _weapon_other:int;
        private var _weaponStreng:int;
        private var _weaponStreng_other:int;
        private var _wing:int;
        private var _wingStreng:int;
        private var _armor:int;
        private var _avatar:int;
        private var _dir:int;
        private var _team:long;
        private var _guild:long;
        private var _guildName:String;
        private var _positions:Vector.<int>;
        private var _buffs:Vector.<CSBuffInfo>;
        private var _horseid:int;
        private var _horseweaponid:int;
        private var _dazuoState:int;
        private var _sxpets:Vector.<long>;
        private var _sxroleid:long;
        private var _sxtargetx:int;
        private var _sxtargety:int;
        private var _ranklevel:int;
        private var _arrowid:int;
        private var _realmlevel:int;
        private var _hiddenweaponid:int;
        private var _horseduangu:int;
        private var _equipPetId:int;
        private var _attackspeed:int;
        private var _armorStreng:int;
        private var _allStrength:int;
        private var _csysKills:int;
        private var _pkValue:int;
        public var toptitleid:int;
        public var suitEffectCount:int;
        public var suitEffectIds:Array;
        public var magicBookLevel:int;
        public var magicBookStar:int;

        public function CSPlayerInfo()
        {
            this._positions = new Vector.<int>;
            this._buffs = new Vector.<CSBuffInfo>;
            this._sxpets = new Vector.<long>;
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

        public function get wingStreng() : int
        {
            return this._wingStreng;
        }// end function

        public function set wingStreng(param1:int) : void
        {
            this._wingStreng = param1;
            return;
        }// end function

        public function get wing() : int
        {
            return this._wing;
        }// end function

        public function set wing(param1:int) : void
        {
            this._wing = param1;
            return;
        }// end function

        public function get armorStreng() : int
        {
            return this._armorStreng;
        }// end function

        public function set armorStreng(param1:int) : void
        {
            this._armorStreng = param1;
            return;
        }// end function

        public function get weaponStreng_other() : int
        {
            return this._weaponStreng_other;
        }// end function

        public function set weaponStreng_other(param1:int) : void
        {
            this._weaponStreng_other = param1;
            return;
        }// end function

        public function get attackspeed() : int
        {
            return this._attackspeed;
        }// end function

        public function set attackspeed(param1:int) : void
        {
            this._attackspeed = param1;
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

        public function get weapon_other() : int
        {
            return this._weapon_other;
        }// end function

        public function set weapon_other(param1:int) : void
        {
            this._weapon_other = param1;
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

        public function get horseduangu() : int
        {
            return this._horseduangu;
        }// end function

        public function set horseduangu(param1:int) : void
        {
            this._horseduangu = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._personId);
            writeInt(this._webvip);
            writeString(this._name);
            writeByte(this._sex);
            writeByte(this._job);
            writeInt(this._level);
            writeInt(this._mapId);
            writeShort(this._x);
            writeShort(this._y);
            writeInt(this._hp);
            writeInt(this._maxHp);
            writeInt(this._mp);
            writeInt(this._maxMp);
            writeInt(this._sp);
            writeInt(this._maxSp);
            writeInt(this._speed);
            writeInt(this._state);
            writeInt(this._weapon);
            writeByte(this._weaponStreng);
            writeInt(this._weapon_other);
            writeByte(this._weaponStreng_other);
            writeInt(this._armor);
            writeInt(this._avatar);
            writeByte(this._dir);
            writeLong(this._team);
            writeLong(this._guild);
            writeShort(this._positions.length);
            _loc_1 = 0;
            while (_loc_1 < this._positions.length)
            {
                
                writeByte(this._positions[_loc_1]);
                _loc_1++;
            }
            writeShort(this._buffs.length);
            _loc_1 = 0;
            while (_loc_1 < this._buffs.length)
            {
                
                writeBean(this._buffs[_loc_1]);
                _loc_1++;
            }
            writeShort(this._horseid);
            writeShort(this._horseweaponid);
            writeByte(this._dazuoState);
            writeShort(this._sxpets.length);
            _loc_1 = 0;
            while (_loc_1 < this._sxpets.length)
            {
                
                writeLong(this._sxpets[_loc_1]);
                _loc_1++;
            }
            writeLong(this._sxroleid);
            writeShort(this._sxtargetx);
            writeShort(this._sxtargety);
            writeByte(this._ranklevel);
            writeInt(this._arrowid);
            writeInt(this._realmlevel);
            writeShort(this._hiddenweaponid);
            writeShort(this._horseduangu);
            writeInt(this._equipPetId);
            writeInt(this._attackspeed);
            writeString(this._guildName);
            writeInt(this.magicBookStar);
            writeInt(this.magicBookLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._personId = readLong();
            this._webvip = readInt();
            this._name = readString();
            this._sex = readByte();
            this._job = readByte();
            this._level = readInt();
            this._mapId = readInt();
            this._x = readShort();
            this._y = readShort();
            this._hp = readInt();
            this._maxHp = readInt();
            this._mp = readInt();
            this._maxMp = readInt();
            this._sp = readInt();
            this._maxSp = readInt();
            this._speed = readInt();
            this._state = readInt();
            this._weapon = readInt();
            this._weaponStreng = readByte();
            this._weapon_other = readInt();
            this._weaponStreng_other = readByte();
            this._armor = readInt();
            this._armorStreng = readByte();
            this._wing = readInt();
            this._wingStreng = readByte();
            this._avatar = readInt();
            this._dir = readByte();
            this._team = readLong();
            this._guild = readLong();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._positions[_loc_2] = readByte();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._buffs[_loc_2] = readBean(CSBuffInfo) as CSBuffInfo;
                _loc_2++;
            }
            this._horseid = readShort();
            this._horseweaponid = readShort();
            this._dazuoState = readByte();
            var _loc_4:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._sxpets[_loc_2] = readLong();
                _loc_2++;
            }
            this._sxroleid = readLong();
            this._sxtargetx = readShort();
            this._sxtargety = readShort();
            this._ranklevel = readByte();
            this._arrowid = readInt();
            this._realmlevel = readInt();
            this._hiddenweaponid = readShort();
            this._horseduangu = readShort();
            this._equipPetId = readInt();
            this._attackspeed = readInt();
            this._guildName = readString();
            this._allStrength = readByte();
            this._csysKills = readInt();
            this._pkValue = readInt();
            this.toptitleid = readInt();
            this.suitEffectCount = readShort();
            this.suitEffectIds = [];
            var _loc_5:* = 0;
            while (_loc_5 < this.suitEffectCount)
            {
                
                this.suitEffectIds[_loc_5] = readInt();
                _loc_5++;
            }
            this.magicBookStar = readInt();
            this.magicBookLevel = readInt();
            return true;
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

        public function get webvip() : int
        {
            return this._webvip;
        }// end function

        public function set webvip(param1:int) : void
        {
            this._webvip = param1;
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

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

        public function get maxHp() : int
        {
            return this._maxHp;
        }// end function

        public function set maxHp(param1:int) : void
        {
            this._maxHp = param1;
            return;
        }// end function

        public function get mp() : int
        {
            return this._mp;
        }// end function

        public function set mp(param1:int) : void
        {
            this._mp = param1;
            return;
        }// end function

        public function get maxMp() : int
        {
            return this._maxMp;
        }// end function

        public function set maxMp(param1:int) : void
        {
            this._maxMp = param1;
            return;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function set sp(param1:int) : void
        {
            this._sp = param1;
            return;
        }// end function

        public function get maxSp() : int
        {
            return this._maxSp;
        }// end function

        public function set maxSp(param1:int) : void
        {
            this._maxSp = param1;
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

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get weapon() : int
        {
            return this._weapon;
        }// end function

        public function set weapon(param1:int) : void
        {
            this._weapon = param1;
            return;
        }// end function

        public function get weaponStreng() : int
        {
            return this._weaponStreng;
        }// end function

        public function set weaponStreng(param1:int) : void
        {
            this._weaponStreng = param1;
            return;
        }// end function

        public function get armor() : int
        {
            return this._armor;
        }// end function

        public function set armor(param1:int) : void
        {
            this._armor = param1;
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

        public function get dir() : int
        {
            return this._dir;
        }// end function

        public function set dir(param1:int) : void
        {
            this._dir = param1;
            return;
        }// end function

        public function get team() : long
        {
            return this._team;
        }// end function

        public function set team(param1:long) : void
        {
            this._team = param1;
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

        public function get positions() : Vector.<int>
        {
            return this._positions;
        }// end function

        public function set positions(param1:Vector.<int>) : void
        {
            this._positions = param1;
            return;
        }// end function

        public function get buffs() : Vector.<CSBuffInfo>
        {
            return this._buffs;
        }// end function

        public function set buffs(param1:Vector.<CSBuffInfo>) : void
        {
            this._buffs = param1;
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

        public function get dazuoState() : int
        {
            return this._dazuoState;
        }// end function

        public function set dazuoState(param1:int) : void
        {
            this._dazuoState = param1;
            return;
        }// end function

        public function get sxpets() : Vector.<long>
        {
            return this._sxpets;
        }// end function

        public function set sxpets(param1:Vector.<long>) : void
        {
            this._sxpets = param1;
            return;
        }// end function

        public function get sxroleid() : long
        {
            return this._sxroleid;
        }// end function

        public function set sxroleid(param1:long) : void
        {
            this._sxroleid = param1;
            return;
        }// end function

        public function get sxtargetx() : int
        {
            return this._sxtargetx;
        }// end function

        public function set sxtargetx(param1:int) : void
        {
            this._sxtargetx = param1;
            return;
        }// end function

        public function get sxtargety() : int
        {
            return this._sxtargety;
        }// end function

        public function set sxtargety(param1:int) : void
        {
            this._sxtargety = param1;
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

        public function get arrowid() : int
        {
            return this._arrowid;
        }// end function

        public function set arrowid(param1:int) : void
        {
            this._arrowid = param1;
            return;
        }// end function

        public function get realmlevel() : int
        {
            return this._realmlevel;
        }// end function

        public function set realmlevel(param1:int) : void
        {
            this._realmlevel = param1;
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

        public function get guildName() : String
        {
            return this._guildName;
        }// end function

        public function set guildName(param1:String) : void
        {
            this._guildName = param1;
            return;
        }// end function

        public function get csysKills() : int
        {
            return this._csysKills;
        }// end function

        public function set csysKills(param1:int) : void
        {
            this._csysKills = param1;
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

    }
}
