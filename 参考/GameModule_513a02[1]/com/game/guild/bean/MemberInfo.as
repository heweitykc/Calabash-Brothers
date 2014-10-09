package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class MemberInfo extends Bean
    {
        private var _userId:long;
        private var _userName:String;
        private var _guildId:long;
        private var _guildName:String;
        private var _mapId:int;
        private var _level:int;
        private var _guildPowerLevel:int;
        private var _nickName:String;
        private var _groupName:String;
        private var _contributionPoint:int;
        private var _contributionPointHistory:int;
        private var _contributionPointWeek:int;
        private var _addTime:int;
        private var _lastOnlineTime:int;
        private var _mountLevel:int;
        private var _arrowLevel:int;
        private var _tianyuanLevel:int;
        private var _prestigePoint:int;
        private var _achievementPoint:int;
        private var _fightPower:int;
        private var _dragonHistory:int;
        private var _whiteTigerHistory:int;
        private var _suzakuHistory:int;
        private var _basalticHistory:int;
        private var _stockGoldHistory:long;
        private var _job:int;
        private var _vipLevel:int;
        private var _vipStageLevel:int;

        public function MemberInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._userId);
            writeString(this._userName);
            writeLong(this._guildId);
            writeString(this._guildName);
            writeInt(this._mapId);
            writeShort(this._level);
            writeByte(this._guildPowerLevel);
            writeString(this._nickName);
            writeString(this._groupName);
            writeInt(this._contributionPoint);
            writeInt(this._contributionPointHistory);
            writeInt(this._contributionPointWeek);
            writeInt(this._addTime);
            writeInt(this._lastOnlineTime);
            writeByte(this._mountLevel);
            writeByte(this._arrowLevel);
            writeByte(this._tianyuanLevel);
            writeInt(this._prestigePoint);
            writeInt(this._achievementPoint);
            writeInt(this._fightPower);
            writeInt(this._dragonHistory);
            writeInt(this._whiteTigerHistory);
            writeInt(this._suzakuHistory);
            writeInt(this._basalticHistory);
            writeLong(this._stockGoldHistory);
            writeByte(this._job);
            writeShort(this._vipLevel);
            writeShort(this._vipStageLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._userId = readLong();
            this._userName = readString();
            this._guildId = readLong();
            this._guildName = readString();
            this._mapId = readInt();
            this._level = readShort();
            this._guildPowerLevel = readByte();
            this._nickName = readString();
            this._groupName = readString();
            this._contributionPoint = readInt();
            this._contributionPointHistory = readInt();
            this._contributionPointWeek = readInt();
            this._addTime = readInt();
            this._lastOnlineTime = readInt();
            this._mountLevel = readByte();
            this._arrowLevel = readByte();
            this._tianyuanLevel = readByte();
            this._prestigePoint = readInt();
            this._achievementPoint = readInt();
            this._fightPower = readInt();
            this._dragonHistory = readInt();
            this._whiteTigerHistory = readInt();
            this._suzakuHistory = readInt();
            this._basalticHistory = readInt();
            this._stockGoldHistory = readLong();
            this._job = readByte();
            this._vipLevel = readShort();
            this._vipStageLevel = readShort();
            return true;
        }// end function

        public function get userId() : long
        {
            return this._userId;
        }// end function

        public function set userId(param1:long) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get userName() : String
        {
            return this._userName;
        }// end function

        public function set userName(param1:String) : void
        {
            this._userName = param1;
            return;
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

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
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

        public function get guildPowerLevel() : int
        {
            return this._guildPowerLevel;
        }// end function

        public function set guildPowerLevel(param1:int) : void
        {
            this._guildPowerLevel = param1;
            return;
        }// end function

        public function get nickName() : String
        {
            return this._nickName;
        }// end function

        public function set nickName(param1:String) : void
        {
            this._nickName = param1;
            return;
        }// end function

        public function get groupName() : String
        {
            return this._groupName;
        }// end function

        public function set groupName(param1:String) : void
        {
            this._groupName = param1;
            return;
        }// end function

        public function get contributionPoint() : int
        {
            return this._contributionPoint;
        }// end function

        public function set contributionPoint(param1:int) : void
        {
            this._contributionPoint = param1;
            return;
        }// end function

        public function get contributionPointHistory() : int
        {
            return this._contributionPointHistory;
        }// end function

        public function set contributionPointHistory(param1:int) : void
        {
            this._contributionPointHistory = param1;
            return;
        }// end function

        public function get addTime() : int
        {
            return this._addTime;
        }// end function

        public function set addTime(param1:int) : void
        {
            this._addTime = param1;
            return;
        }// end function

        public function get lastOnlineTime() : int
        {
            return this._lastOnlineTime;
        }// end function

        public function set lastOnlineTime(param1:int) : void
        {
            this._lastOnlineTime = param1;
            return;
        }// end function

        public function get mountLevel() : int
        {
            return this._mountLevel;
        }// end function

        public function set mountLevel(param1:int) : void
        {
            this._mountLevel = param1;
            return;
        }// end function

        public function get arrowLevel() : int
        {
            return this._arrowLevel;
        }// end function

        public function set arrowLevel(param1:int) : void
        {
            this._arrowLevel = param1;
            return;
        }// end function

        public function get tianyuanLevel() : int
        {
            return this._tianyuanLevel;
        }// end function

        public function set tianyuanLevel(param1:int) : void
        {
            this._tianyuanLevel = param1;
            return;
        }// end function

        public function get prestigePoint() : int
        {
            return this._prestigePoint;
        }// end function

        public function set prestigePoint(param1:int) : void
        {
            this._prestigePoint = param1;
            return;
        }// end function

        public function get achievementPoint() : int
        {
            return this._achievementPoint;
        }// end function

        public function set achievementPoint(param1:int) : void
        {
            this._achievementPoint = param1;
            return;
        }// end function

        public function get fightPower() : int
        {
            return this._fightPower;
        }// end function

        public function set fightPower(param1:int) : void
        {
            this._fightPower = param1;
            return;
        }// end function

        public function get dragonHistory() : int
        {
            return this._dragonHistory;
        }// end function

        public function set dragonHistory(param1:int) : void
        {
            this._dragonHistory = param1;
            return;
        }// end function

        public function get whiteTigerHistory() : int
        {
            return this._whiteTigerHistory;
        }// end function

        public function set whiteTigerHistory(param1:int) : void
        {
            this._whiteTigerHistory = param1;
            return;
        }// end function

        public function get suzakuHistory() : int
        {
            return this._suzakuHistory;
        }// end function

        public function set suzakuHistory(param1:int) : void
        {
            this._suzakuHistory = param1;
            return;
        }// end function

        public function get basalticHistory() : int
        {
            return this._basalticHistory;
        }// end function

        public function set basalticHistory(param1:int) : void
        {
            this._basalticHistory = param1;
            return;
        }// end function

        public function get stockGoldHistory() : long
        {
            return this._stockGoldHistory;
        }// end function

        public function set stockGoldHistory(param1:long) : void
        {
            this._stockGoldHistory = param1;
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

        public function get vipLevel() : int
        {
            return this._vipLevel;
        }// end function

        public function set vipLevel(param1:int) : void
        {
            this._vipLevel = param1;
            return;
        }// end function

        public function get vipStageLevel() : int
        {
            return this._vipStageLevel;
        }// end function

        public function set vipStageLevel(param1:int) : void
        {
            this._vipStageLevel = param1;
            return;
        }// end function

        public function get contributionPointWeek() : int
        {
            return this._contributionPointWeek;
        }// end function

        public function set contributionPointWeek(param1:int) : void
        {
            this._contributionPointWeek = param1;
            return;
        }// end function

    }
}
