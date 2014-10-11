package com.game.guild.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class GuildInfo extends Bean
    {
        private var _guildId:long;
        private var _guildName:String;
        private var _guildBanner:String;
        private var _bangZhuid:long;
        private var _bangZhuName:String;
        private var _bangZhuLevel:int;
        private var _bangZhuOnline:int;
        private var _viceBangZhuid:long;
        private var _viceBangZhuName:String;
        private var _viceBangZhuLevel:int;
        private var _viceBangZhuOnline:int;
        private var _bannerIcon:int;
        private var _bannerLevel:int;
        private var _guildBulletin:String;
        private var _dragon:int;
        private var _whiteTiger:int;
        private var _suzaku:int;
        private var _basaltic:int;
        private var _stockGold:long;
        private var _guildContribution:int;
        private var _friendGuildList:Vector.<DiplomaticInfo>;
        private var _enemyGuildList:Vector.<DiplomaticInfo>;
        private var _activeValue:int;
        private var _warningValue:int;
        private var _autoGuildAgreeAdd:int;
        private var _memberNum:int;
        private var _memberFightPower:int;
        private var _ownMapList:Vector.<int>;
        private var _ownKingCity:int;
        private var _ownEmperorCity:int;
        private var _createTime:int;
        private var _createIp:String;
        private var _lastGuildBulletinTime:int;
        private var _guildRank:int;

        public function GuildInfo()
        {
            this._friendGuildList = new Vector.<DiplomaticInfo>;
            this._enemyGuildList = new Vector.<DiplomaticInfo>;
            this._ownMapList = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._guildId);
            writeString(this._guildName);
            writeString(this._guildBanner);
            writeLong(this._bangZhuid);
            writeString(this._bangZhuName);
            writeShort(this._bangZhuLevel);
            writeByte(this._bangZhuOnline);
            writeLong(this._viceBangZhuid);
            writeString(this._viceBangZhuName);
            writeShort(this._viceBangZhuLevel);
            writeByte(this._viceBangZhuOnline);
            writeInt(this._bannerIcon);
            writeByte(this._bannerLevel);
            writeString(this._guildBulletin);
            writeInt(this._dragon);
            writeInt(this._whiteTiger);
            writeInt(this._suzaku);
            writeInt(this._basaltic);
            writeLong(this._stockGold);
            writeInt(this._guildContribution);
            writeShort(this._friendGuildList.length);
            _loc_1 = 0;
            while (_loc_1 < this._friendGuildList.length)
            {
                
                writeBean(this._friendGuildList[_loc_1]);
                _loc_1++;
            }
            writeShort(this._enemyGuildList.length);
            _loc_1 = 0;
            while (_loc_1 < this._enemyGuildList.length)
            {
                
                writeBean(this._enemyGuildList[_loc_1]);
                _loc_1++;
            }
            writeByte(this._activeValue);
            writeByte(this._warningValue);
            writeByte(this._autoGuildAgreeAdd);
            writeByte(this._memberNum);
            writeInt(this._memberFightPower);
            writeShort(this._ownMapList.length);
            _loc_1 = 0;
            while (_loc_1 < this._ownMapList.length)
            {
                
                writeInt(this._ownMapList[_loc_1]);
                _loc_1++;
            }
            writeByte(this._ownKingCity);
            writeByte(this._ownEmperorCity);
            writeInt(this._createTime);
            writeString(this._createIp);
            writeInt(this._lastGuildBulletinTime);
            writeInt(this._guildRank);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._guildId = readLong();
            this._guildName = readString();
            this._guildBanner = readString();
            this._bangZhuid = readLong();
            this._bangZhuName = readString();
            this._bangZhuLevel = readShort();
            this._bangZhuOnline = readByte();
            this._viceBangZhuid = readLong();
            this._viceBangZhuName = readString();
            this._viceBangZhuLevel = readShort();
            this._viceBangZhuOnline = readByte();
            this._bannerIcon = readInt();
            this._bannerLevel = readByte();
            this._guildBulletin = readString();
            this._dragon = readInt();
            this._whiteTiger = readInt();
            this._suzaku = readInt();
            this._basaltic = readInt();
            this._stockGold = readLong();
            this._guildContribution = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._friendGuildList[_loc_2] = readBean(DiplomaticInfo) as DiplomaticInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._enemyGuildList[_loc_2] = readBean(DiplomaticInfo) as DiplomaticInfo;
                _loc_2++;
            }
            this._activeValue = readByte();
            this._warningValue = readByte();
            this._autoGuildAgreeAdd = readByte();
            this._memberNum = readByte();
            this._memberFightPower = readInt();
            var _loc_4:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._ownMapList[_loc_2] = readInt();
                _loc_2++;
            }
            this._ownKingCity = readByte();
            this._ownEmperorCity = readByte();
            this._createTime = readInt();
            this._createIp = readString();
            this._lastGuildBulletinTime = readInt();
            this._guildRank = readInt();
            return true;
        }// end function

        public function get guildId() : long
        {
            return this._guildId;
        }// end function

        public function set guildId(param1:long) : void
        {
            this._guildId = param1;
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

        public function get guildBanner() : String
        {
            return this._guildBanner;
        }// end function

        public function set guildBanner(param1:String) : void
        {
            this._guildBanner = param1;
            return;
        }// end function

        public function get bangZhuid() : long
        {
            return this._bangZhuid;
        }// end function

        public function set bangZhuid(param1:long) : void
        {
            this._bangZhuid = param1;
            return;
        }// end function

        public function get bangZhuName() : String
        {
            return this._bangZhuName;
        }// end function

        public function set bangZhuName(param1:String) : void
        {
            this._bangZhuName = param1;
            return;
        }// end function

        public function get bangZhuLevel() : int
        {
            return this._bangZhuLevel;
        }// end function

        public function set bangZhuLevel(param1:int) : void
        {
            this._bangZhuLevel = param1;
            return;
        }// end function

        public function get bangZhuOnline() : int
        {
            return this._bangZhuOnline;
        }// end function

        public function set bangZhuOnline(param1:int) : void
        {
            this._bangZhuOnline = param1;
            return;
        }// end function

        public function get viceBangZhuid() : long
        {
            return this._viceBangZhuid;
        }// end function

        public function set viceBangZhuid(param1:long) : void
        {
            this._viceBangZhuid = param1;
            return;
        }// end function

        public function get viceBangZhuName() : String
        {
            return this._viceBangZhuName;
        }// end function

        public function set viceBangZhuName(param1:String) : void
        {
            this._viceBangZhuName = param1;
            return;
        }// end function

        public function get viceBangZhuLevel() : int
        {
            return this._viceBangZhuLevel;
        }// end function

        public function set viceBangZhuLevel(param1:int) : void
        {
            this._viceBangZhuLevel = param1;
            return;
        }// end function

        public function get viceBangZhuOnline() : int
        {
            return this._viceBangZhuOnline;
        }// end function

        public function set viceBangZhuOnline(param1:int) : void
        {
            this._viceBangZhuOnline = param1;
            return;
        }// end function

        public function get bannerIcon() : int
        {
            return this._bannerIcon;
        }// end function

        public function set bannerIcon(param1:int) : void
        {
            this._bannerIcon = param1;
            return;
        }// end function

        public function get bannerLevel() : int
        {
            return this._bannerLevel;
        }// end function

        public function set bannerLevel(param1:int) : void
        {
            this._bannerLevel = param1;
            return;
        }// end function

        public function get guildBulletin() : String
        {
            return this._guildBulletin;
        }// end function

        public function set guildBulletin(param1:String) : void
        {
            this._guildBulletin = param1;
            return;
        }// end function

        public function get dragon() : int
        {
            return this._dragon;
        }// end function

        public function set dragon(param1:int) : void
        {
            this._dragon = param1;
            return;
        }// end function

        public function get whiteTiger() : int
        {
            return this._whiteTiger;
        }// end function

        public function set whiteTiger(param1:int) : void
        {
            this._whiteTiger = param1;
            return;
        }// end function

        public function get suzaku() : int
        {
            return this._suzaku;
        }// end function

        public function set suzaku(param1:int) : void
        {
            this._suzaku = param1;
            return;
        }// end function

        public function get basaltic() : int
        {
            return this._basaltic;
        }// end function

        public function set basaltic(param1:int) : void
        {
            this._basaltic = param1;
            return;
        }// end function

        public function get stockGold() : long
        {
            return this._stockGold;
        }// end function

        public function set stockGold(param1:long) : void
        {
            this._stockGold = param1;
            return;
        }// end function

        public function get friendGuildList() : Vector.<DiplomaticInfo>
        {
            return this._friendGuildList;
        }// end function

        public function set friendGuildList(param1:Vector.<DiplomaticInfo>) : void
        {
            this._friendGuildList = param1;
            return;
        }// end function

        public function get enemyGuildList() : Vector.<DiplomaticInfo>
        {
            return this._enemyGuildList;
        }// end function

        public function set enemyGuildList(param1:Vector.<DiplomaticInfo>) : void
        {
            this._enemyGuildList = param1;
            return;
        }// end function

        public function get activeValue() : int
        {
            return this._activeValue;
        }// end function

        public function set activeValue(param1:int) : void
        {
            this._activeValue = param1;
            return;
        }// end function

        public function get warningValue() : int
        {
            return this._warningValue;
        }// end function

        public function set warningValue(param1:int) : void
        {
            this._warningValue = param1;
            return;
        }// end function

        public function get autoGuildAgreeAdd() : int
        {
            return this._autoGuildAgreeAdd;
        }// end function

        public function set autoGuildAgreeAdd(param1:int) : void
        {
            this._autoGuildAgreeAdd = param1;
            return;
        }// end function

        public function get memberNum() : int
        {
            return this._memberNum;
        }// end function

        public function set memberNum(param1:int) : void
        {
            this._memberNum = param1;
            return;
        }// end function

        public function get memberFightPower() : int
        {
            return this._memberFightPower;
        }// end function

        public function set memberFightPower(param1:int) : void
        {
            this._memberFightPower = param1;
            return;
        }// end function

        public function get ownMapList() : Vector.<int>
        {
            return this._ownMapList;
        }// end function

        public function set ownMapList(param1:Vector.<int>) : void
        {
            this._ownMapList = param1;
            return;
        }// end function

        public function get ownKingCity() : int
        {
            return this._ownKingCity;
        }// end function

        public function set ownKingCity(param1:int) : void
        {
            this._ownKingCity = param1;
            return;
        }// end function

        public function get ownEmperorCity() : int
        {
            return this._ownEmperorCity;
        }// end function

        public function set ownEmperorCity(param1:int) : void
        {
            this._ownEmperorCity = param1;
            return;
        }// end function

        public function get createTime() : int
        {
            return this._createTime;
        }// end function

        public function set createTime(param1:int) : void
        {
            this._createTime = param1;
            return;
        }// end function

        public function get createIp() : String
        {
            return this._createIp;
        }// end function

        public function set createIp(param1:String) : void
        {
            this._createIp = param1;
            return;
        }// end function

        public function get lastGuildBulletinTime() : int
        {
            return this._lastGuildBulletinTime;
        }// end function

        public function set lastGuildBulletinTime(param1:int) : void
        {
            this._lastGuildBulletinTime = param1;
            return;
        }// end function

        public function get guildContribution() : int
        {
            return this._guildContribution;
        }// end function

        public function set guildContribution(param1:int) : void
        {
            this._guildContribution = param1;
            return;
        }// end function

        public function get guildRank() : int
        {
            return this._guildRank;
        }// end function

        public function set guildRank(param1:int) : void
        {
            this._guildRank = param1;
            return;
        }// end function

    }
}
