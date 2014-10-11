package com.game.toplist.bean
{
    import __AS3__.vec.*;
    import com.game.equip.bean.*;
    import com.game.guild.bean.*;
    import com.game.utils.*;
    import net.*;

    public class TopInfo extends Bean
    {
        private var _playerid:long;
        private var _webvip:int;
        private var _playername:String;
        private var _mapModelId:int;
        private var _toptype:int;
        private var _topidx:int;
        private var _level:int;
        private var _sex:int;
        private var _exp:long;
        private var _avatar:int;
        private var _vipid:int;
        private var _money:int;
        private var _fightPower:int;
        private var _maxEventcut:int;
        private var _horselayer:int;
        private var _horselevel:int;
        private var _guildinfo:GuildInfo;
        private var _itemlist:Vector.<EquipInfo>;
        private var _job:int;
        private var _alv:int;
        private var _magicBookStar:int;
        private var _magicBookLevel:int;
        private var _magicBookExp:int;
        private var _suitEffectCount:int;
        private var _suitEffectIds:Array;

        public function TopInfo()
        {
            this._itemlist = new Vector.<EquipInfo>;
            return;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set webvip(param1:int) : void
        {
            this._webvip = param1;
            return;
        }// end function

        public function get webvip() : int
        {
            return this._webvip;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set mapModelId(param1:int) : void
        {
            this._mapModelId = param1;
            return;
        }// end function

        public function get mapModelId() : int
        {
            return this._mapModelId;
        }// end function

        public function set toptype(param1:int) : void
        {
            this._toptype = param1;
            return;
        }// end function

        public function get toptype() : int
        {
            return this._toptype;
        }// end function

        public function set topidx(param1:int) : void
        {
            this._topidx = param1;
            return;
        }// end function

        public function get topidx() : int
        {
            return this._topidx;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
            return;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set exp(param1:long) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp() : long
        {
            return this._exp;
        }// end function

        public function set avatar(param1:int) : void
        {
            this._avatar = param1;
            return;
        }// end function

        public function get avatar() : int
        {
            return this._avatar;
        }// end function

        public function set vipid(param1:int) : void
        {
            this._vipid = param1;
            return;
        }// end function

        public function get vipid() : int
        {
            return this._vipid;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set fightPower(param1:int) : void
        {
            this._fightPower = param1;
            return;
        }// end function

        public function get fightPower() : int
        {
            return this._fightPower;
        }// end function

        public function set maxEventcut(param1:int) : void
        {
            this._maxEventcut = param1;
            return;
        }// end function

        public function get maxEventcut() : int
        {
            return this._maxEventcut;
        }// end function

        public function set horselayer(param1:int) : void
        {
            this._horselayer = param1;
            return;
        }// end function

        public function get horselayer() : int
        {
            return this._horselayer;
        }// end function

        public function set horselevel(param1:int) : void
        {
            this._horselevel = param1;
            return;
        }// end function

        public function get horselevel() : int
        {
            return this._horselevel;
        }// end function

        public function set guildinfo(param1:GuildInfo) : void
        {
            this._guildinfo = param1;
            return;
        }// end function

        public function get guildinfo() : GuildInfo
        {
            return this._guildinfo;
        }// end function

        public function set itemlist(param1:Vector.<EquipInfo>) : void
        {
            this._itemlist = param1;
            return;
        }// end function

        public function get itemlist() : Vector.<EquipInfo>
        {
            return this._itemlist;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function get alv() : int
        {
            return this._alv;
        }// end function

        public function set alv(param1:int) : void
        {
            this._alv = param1;
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

        public function get magicBookExp() : int
        {
            return this._magicBookExp;
        }// end function

        public function set magicBookExp(param1:int) : void
        {
            this._magicBookExp = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._webvip);
            writeString(this._playername);
            writeInt(this._mapModelId);
            writeByte(this._toptype);
            writeInt(this._topidx);
            writeInt(this._level);
            writeByte(this._sex);
            writeLong(this._exp);
            writeInt(this._avatar);
            writeInt(this._vipid);
            writeInt(this._money);
            writeInt(this._fightPower);
            writeInt(this._maxEventcut);
            writeInt(this._horselayer);
            writeInt(this._horselevel);
            writeBean(this._guildinfo);
            writeShort(this._itemlist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._itemlist.length)
            {
                
                writeBean(this._itemlist[_loc_1]);
                _loc_1++;
            }
            writeInt(this._job);
            writeInt(this._alv);
            writeInt(this.magicBookStar);
            writeInt(this.magicBookLevel);
            writeInt(this.magicBookExp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._webvip = readInt();
            this._playername = readString();
            this._mapModelId = readInt();
            this._toptype = readByte();
            this._topidx = readInt();
            this._level = readInt();
            this._sex = readByte();
            this._exp = readLong();
            this._avatar = readInt();
            this._vipid = readInt();
            this._money = readInt();
            this._fightPower = readInt();
            this._maxEventcut = readInt();
            this._horselayer = readInt();
            this._horselevel = readInt();
            this._guildinfo = readBean(GuildInfo) as GuildInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemlist[_loc_2] = readBean(EquipInfo) as EquipInfo;
                _loc_2++;
            }
            this._job = readByte();
            this._alv = readInt();
            this._suitEffectCount = readShort();
            this._suitEffectIds = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._suitEffectCount)
            {
                
                this._suitEffectIds[_loc_3] = readInt();
                _loc_3++;
            }
            this.magicBookStar = readInt();
            this.magicBookLevel = readInt();
            this.magicBookExp = readInt();
            return true;
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

        public function get suitEffectIds() : Array
        {
            return this._suitEffectIds;
        }// end function

        public function set suitEffectIds(param1:Array) : void
        {
            this._suitEffectIds = param1;
            return;
        }// end function

    }
}
