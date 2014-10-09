package com.game.guild.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.game.guild.bean.*;
    import com.game.guild.events.*;
    import com.game.utils.*;
    import com.model.*;

    public class GuildData extends BaseEventDispatcher
    {
        private var _guildInfo:GuildInfo;
        private var _myMemberInfo:MemberInfo;
        private var _memberInfo:MemberInfo;
        private var _leaderMemberInfo:MemberInfo;
        private var _memberList:Vector.<MemberInfo>;
        private var _guildShortInfoList:Vector.<GuildShortInfo>;
        private var _guildList:Vector.<GuildInfo>;
        private var _eventList:Vector.<EventInfo>;
        private var _contributionList:Vector.<ContributionInfo>;
        private var _isAutoAgreeAddGuild:Boolean = false;
        private var _isImpeach:int = 0;
        public var openOrigin:int = 1;
        private static var _instance:GuildData;

        public function GuildData()
        {
            return;
        }// end function

        public function getGuildPowerName(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10739");
                    break;
                }
                case 2:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10740");
                    break;
                }
                case 3:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10741");
                    break;
                }
                case 4:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10742");
                    break;
                }
                default:
                {
                    _loc_2 = _loc_2 + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function updateMemberList(param1:MemberInfo) : void
        {
            var _loc_2:* = 0;
            while (this.memberList && _loc_2 < this.memberList.length)
            {
                
                if (this.memberList[_loc_2].userId.equal(param1.userId))
                {
                    this.memberList[_loc_2] = param1;
                    dispatchEvt(new GuildEvent(GuildEvent.OTHER_MEMBER_INFO_CHANGE, param1));
                    return;
                }
                _loc_2++;
            }
            if (this.memberList)
            {
                this.memberList.push(param1);
            }
            dispatchEvt(new GuildEvent(GuildEvent.MEMBER_INFO_CHANGE));
            return;
        }// end function

        public function deleteMember(param1:long) : void
        {
            var _loc_2:* = 0;
            if (this.memberList)
            {
                _loc_2 = 0;
                while (_loc_2 < this.memberList.length)
                {
                    
                    if (this.memberList[_loc_2].userId.equal(param1))
                    {
                        this.memberList.splice(_loc_2, 1);
                        dispatchEvt(new GuildEvent(GuildEvent.MEMBER_INFO_CHANGE));
                        return;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function searchGuild(param1:String) : Vector.<GuildInfo>
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (this._guildList && _loc_3 < this._guildList.length)
            {
                
                if (this._guildList[_loc_3].guildName.search(param1) != -1)
                {
                    if (!_loc_2)
                    {
                        _loc_2 = new Vector.<GuildInfo>;
                    }
                    _loc_2.push(this._guildList[_loc_3]);
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getGuildNameById(param1:long) : String
        {
            var _loc_2:* = 0;
            while (this.guildShortInfoList && _loc_2 < this.guildShortInfoList.length)
            {
                
                if (this.guildShortInfoList[_loc_2].guildId.equal(param1))
                {
                    return this.guildShortInfoList[_loc_2].guildName;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (this.guildList && _loc_2 < this.guildList.length)
            {
                
                if (this.guildList[_loc_2].guildId.equal(param1))
                {
                    return this.guildList[_loc_2].guildName;
                }
                _loc_2++;
            }
            if (this._guildInfo && this._guildInfo.guildId.equal(param1))
            {
                return this._guildInfo.guildName;
            }
            return "";
        }// end function

        public function getMemberNum() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (this.memberList && _loc_2 < this.memberList.length)
            {
                
                if (this.memberList[_loc_2].lastOnlineTime == 0)
                {
                    _loc_1++;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getGuildNum() : int
        {
            if (this._guildShortInfoList)
            {
                return this._guildShortInfoList.length;
            }
            return 0;
        }// end function

        public function get guildInfo() : GuildInfo
        {
            return this._guildInfo;
        }// end function

        public function set guildInfo(param1:GuildInfo) : void
        {
            this._guildInfo = param1;
            UserObj.getInstance().playerInfo.guildName = param1 ? (param1.guildName) : (null);
            UserObj.getInstance().playerInfo.guildId = param1 ? (param1.guildId) : (null);
            dispatchEvt(new GuildEvent(GuildEvent.GUILD_INFO_CHANGE));
            return;
        }// end function

        public function get memberInfo() : MemberInfo
        {
            return this._memberInfo;
        }// end function

        public function set memberInfo(param1:MemberInfo) : void
        {
            this._memberInfo = param1;
            if (param1 && param1.userId.equal(UserObj.getInstance().playerInfo.personId))
            {
                this.myMemberInfo = param1;
                dispatchEvt(new GuildEvent(GuildEvent.MY_MEMBER_INFO_CHANGE));
            }
            return;
        }// end function

        public function get leaderMemberInfo() : MemberInfo
        {
            return this._leaderMemberInfo;
        }// end function

        public function set leaderMemberInfo(param1:MemberInfo) : void
        {
            this._leaderMemberInfo = param1;
            return;
        }// end function

        public function get myMemberInfo() : MemberInfo
        {
            return this._myMemberInfo;
        }// end function

        public function set myMemberInfo(param1:MemberInfo) : void
        {
            this._myMemberInfo = param1;
            return;
        }// end function

        public function get memberList() : Vector.<MemberInfo>
        {
            return this._memberList;
        }// end function

        public function set memberList(param1:Vector.<MemberInfo>) : void
        {
            this._memberList = param1;
            var _loc_2:* = 0;
            while (param1 && _loc_2 < param1.length)
            {
                
                if (param1[_loc_2].guildPowerLevel == 1)
                {
                    this._leaderMemberInfo = param1[_loc_2];
                }
                if (param1[_loc_2].userId.equal(UserObj.getInstance().playerInfo.personId))
                {
                    this._myMemberInfo = param1[_loc_2];
                }
                _loc_2++;
            }
            dispatchEvt(new GuildEvent(GuildEvent.MEMBERLIST_CHANGE));
            return;
        }// end function

        public function get guildShortInfoList() : Vector.<GuildShortInfo>
        {
            return this._guildShortInfoList;
        }// end function

        public function set guildShortInfoList(param1:Vector.<GuildShortInfo>) : void
        {
            this._guildShortInfoList = param1;
            return;
        }// end function

        public function get guildList() : Vector.<GuildInfo>
        {
            return this._guildList;
        }// end function

        public function set guildList(param1:Vector.<GuildInfo>) : void
        {
            this._guildList = param1;
            dispatchEvt(new GuildEvent(GuildEvent.GUILDLIST_CHANGE));
            return;
        }// end function

        public function get isAutoAgreeAddGuild() : Boolean
        {
            return this._isAutoAgreeAddGuild;
        }// end function

        public function set isAutoAgreeAddGuild(param1:Boolean) : void
        {
            this._isAutoAgreeAddGuild = param1;
            return;
        }// end function

        public function get eventList() : Vector.<EventInfo>
        {
            return this._eventList;
        }// end function

        public function set eventList(param1:Vector.<EventInfo>) : void
        {
            this._eventList = param1;
            dispatchEvt(new GuildEvent(GuildEvent.EVENTLIST_CHANGE));
            return;
        }// end function

        public function get contributionList() : Vector.<ContributionInfo>
        {
            return this._contributionList;
        }// end function

        public function set contributionList(param1:Vector.<ContributionInfo>) : void
        {
            this._contributionList = param1;
            return;
        }// end function

        public function get isImpeach() : int
        {
            return this._isImpeach;
        }// end function

        public function set isImpeach(param1:int) : void
        {
            this._isImpeach = param1;
            return;
        }// end function

        public static function getInstance() : GuildData
        {
            if (_instance == null)
            {
                _instance = new GuildData;
            }
            return _instance;
        }// end function

    }
}
