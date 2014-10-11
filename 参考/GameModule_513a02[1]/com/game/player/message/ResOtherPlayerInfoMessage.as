package com.game.player.message
{
    import __AS3__.vec.*;
    import com.game.arrow.bean.*;
    import com.game.artifact.bean.*;
    import com.game.equip.bean.*;
    import com.game.gem.bean.*;
    import com.game.guild.bean.*;
    import com.game.hiddenweapon.bean.*;
    import com.game.horseweapon.bean.*;
    import com.game.player.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResOtherPlayerInfoMessage extends Message
    {
        private var _personId:long;
        private var _name:String;
        private var _sex:int;
        private var _job:int;
        private var _guildID:long;
        private var _horseLev:int;
        private var _level:int;
        private var _exp:long;
        private var _zhenqi:int;
        private var _prestige:int;
        private var _avatar:int;
        private var _chapter:int;
        private var _attributes:Vector.<PlayerAttributeItem>;
        private var _equips:Vector.<EquipInfo>;
        private var _skill:int;
        private var _skills:int;
        private var _otherGuildInfo:OtherGuildInfo;
        private var _fightpower:int;
        private var _posallgeminfo:Vector.<PosGemInfo>;
        private var _kingcitybuffid:int;
        private var _vipid:int;
        private var _ranklevel:int;
        private var _arrowInfo:ArrowInfo;
        private var _horseWeaponInfo:OthersHorseWeaponInfo;
        private var _hiddenWeaponInfo:OthersHiddenWeaponInfo;
        private var _realmlevel:int;
        private var _realmintensifylevel:int;
        private var _attributeCount:int;
        private var _artifact:int;
        public var artifactRemold:Vector.<ArtifactRemoldInfo>;
        private var _magicBookLevel:int;
        private var _magicBookStar:int;

        public function ResOtherPlayerInfoMessage()
        {
            this._attributes = new Vector.<PlayerAttributeItem>;
            this._equips = new Vector.<EquipInfo>;
            this._posallgeminfo = new Vector.<PosGemInfo>;
            this.artifactRemold = new Vector.<ArtifactRemoldInfo>;
            return;
        }// end function

        public function get magicBookStar() : int
        {
            return this._magicBookStar;
        }// end function

        public function set magicBookStar(param1:int) : void
        {
            this._magicBookStar = param1;
            return;
        }// end function

        public function get magicBookLevel() : int
        {
            return this._magicBookLevel;
        }// end function

        public function set magicBookLevel(param1:int) : void
        {
            this._magicBookLevel = param1;
            return;
        }// end function

        public function get attributeCount() : int
        {
            return this._attributeCount;
        }// end function

        public function set attributeCount(param1:int) : void
        {
            this._attributeCount = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._personId);
            writeString(this._name);
            writeInt(this._sex);
            writeInt(this._job);
            writeLong(this._guildID);
            writeInt(this._horseLev);
            writeInt(this._level);
            writeLong(this._exp);
            writeInt(this._zhenqi);
            writeInt(this._prestige);
            writeInt(this._avatar);
            writeInt(this._chapter);
            writeShort(this._attributes.length);
            _loc_1 = 0;
            while (_loc_1 < this._attributes.length)
            {
                
                writeBean(this._attributes[_loc_1]);
                _loc_1++;
            }
            writeShort(this._equips.length);
            _loc_1 = 0;
            while (_loc_1 < this._equips.length)
            {
                
                writeBean(this._equips[_loc_1]);
                _loc_1++;
            }
            writeByte(this._skill);
            writeInt(this._skills);
            writeBean(this._otherGuildInfo);
            writeInt(this._fightpower);
            writeShort(this._posallgeminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._posallgeminfo.length)
            {
                
                writeBean(this._posallgeminfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._kingcitybuffid);
            writeInt(this._vipid);
            writeByte(this._ranklevel);
            writeBean(this._arrowInfo);
            writeBean(this._horseWeaponInfo);
            writeBean(this._hiddenWeaponInfo);
            writeInt(this._realmlevel);
            writeInt(this._realmintensifylevel);
            writeByte(this._attributeCount);
            writeShort(this._artifact);
            writeShort(this.artifactRemold.length);
            _loc_1 = 0;
            while (_loc_1 < this.artifactRemold.length)
            {
                
                writeBean(this.artifactRemold[_loc_1]);
                _loc_1++;
            }
            writeInt(this._magicBookStar);
            writeInt(this._magicBookLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._personId = readLong();
            this._name = readString();
            this._sex = readInt();
            this._job = readInt();
            this._guildID = readLong();
            this._horseLev = readInt();
            this._level = readInt();
            this._exp = readLong();
            this._zhenqi = readInt();
            this._prestige = readInt();
            this._avatar = readInt();
            this._chapter = readInt();
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
                
                this._equips[_loc_1] = readBean(EquipInfo) as EquipInfo;
                _loc_1++;
            }
            this._skill = readByte();
            this._skills = readInt();
            this._otherGuildInfo = readBean(OtherGuildInfo) as OtherGuildInfo;
            this._fightpower = readInt();
            var _loc_4:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                this._posallgeminfo[_loc_1] = readBean(PosGemInfo) as PosGemInfo;
                _loc_1++;
            }
            this._kingcitybuffid = readInt();
            this._vipid = readInt();
            this._ranklevel = readByte();
            this._arrowInfo = readBean(ArrowInfo) as ArrowInfo;
            this._horseWeaponInfo = readBean(OthersHorseWeaponInfo) as OthersHorseWeaponInfo;
            this._hiddenWeaponInfo = readBean(OthersHiddenWeaponInfo) as OthersHiddenWeaponInfo;
            this._realmlevel = readInt();
            this._realmintensifylevel = readInt();
            this._attributeCount = readByte();
            this._artifact = readShort();
            var _loc_5:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_5)
            {
                
                this.artifactRemold[_loc_1] = readBean(ArtifactRemoldInfo) as ArtifactRemoldInfo;
                _loc_1++;
            }
            this._magicBookStar = readInt();
            this._magicBookLevel = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103108;
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

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        public function get guildID() : long
        {
            return this._guildID;
        }// end function

        public function set guildID(param1:long) : void
        {
            this._guildID = param1;
            return;
        }// end function

        public function get horseLev() : int
        {
            return this._horseLev;
        }// end function

        public function set horseLev(param1:int) : void
        {
            this._horseLev = param1;
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

        public function get avatar() : int
        {
            return this._avatar;
        }// end function

        public function set avatar(param1:int) : void
        {
            this._avatar = param1;
            return;
        }// end function

        public function get chapter() : int
        {
            return this._chapter;
        }// end function

        public function set chapter(param1:int) : void
        {
            this._chapter = param1;
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

        public function get equips() : Vector.<EquipInfo>
        {
            return this._equips;
        }// end function

        public function set equips(param1:Vector.<EquipInfo>) : void
        {
            this._equips = param1;
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

        public function get otherGuildInfo() : OtherGuildInfo
        {
            return this._otherGuildInfo;
        }// end function

        public function set otherGuildInfo(param1:OtherGuildInfo) : void
        {
            this._otherGuildInfo = param1;
            return;
        }// end function

        public function get fightpower() : int
        {
            return this._fightpower;
        }// end function

        public function set fightpower(param1:int) : void
        {
            this._fightpower = param1;
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

        public function get horseWeaponInfo() : OthersHorseWeaponInfo
        {
            return this._horseWeaponInfo;
        }// end function

        public function set horseWeaponInfo(param1:OthersHorseWeaponInfo) : void
        {
            this._horseWeaponInfo = param1;
            return;
        }// end function

        public function get hiddenWeaponInfo() : OthersHiddenWeaponInfo
        {
            return this._hiddenWeaponInfo;
        }// end function

        public function set hiddenWeaponInfo(param1:OthersHiddenWeaponInfo) : void
        {
            this._hiddenWeaponInfo = param1;
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

        public function get realmintensifylevel() : int
        {
            return this._realmintensifylevel;
        }// end function

        public function set realmintensifylevel(param1:int) : void
        {
            this._realmintensifylevel = param1;
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

    }
}
