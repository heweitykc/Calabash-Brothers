package com.platform
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import com.game.guild.message.*;

    public class PlatformKugou extends Platform
    {
        private var isInBox:int;

        public function PlatformKugou()
        {
            return;
        }// end function

        override protected function initUser() : void
        {
            this.isInBox = callJs("kugouCheckIsInTheBox");
            return;
        }// end function

        override public function guildMemberListNotify(param1:ResGuildMemberListToKugooClientMessage) : void
        {
            var _loc_5:* = null;
            var _loc_9:* = null;
            if (this.isInBox <= 0)
            {
                return;
            }
            var _loc_2:* = new Object();
            _loc_2.loginID = userName;
            _loc_2.factionID = param1.guildId.toString();
            _loc_2.factionName = param1.guildName;
            _loc_2.notice = param1.guildBulletin;
            _loc_2.userID = playerInfo.personId.toString();
            var _loc_3:* = param1.memberList;
            var _loc_4:* = _loc_3.length;
            var _loc_6:* = new Array();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_5 = _loc_3[_loc_7];
                _loc_9 = new Object();
                _loc_9.loginID = _loc_5.loginID;
                _loc_9.userID = _loc_5.userId.toString();
                _loc_9.name = _loc_5.userName;
                _loc_9.pos = _loc_5.pos - 1;
                _loc_9.sex = 0;
                _loc_6.push(_loc_9);
                _loc_7++;
            }
            _loc_2.memberList = _loc_6;
            var _loc_8:* = JSON.stringify(_loc_2);
            callJs("kugouFactionMemberListNotify", _loc_8);
            return;
        }// end function

        override public function guildLeaveNotify(param1:ResGuildLeaveToKugooClientMessage) : void
        {
            if (this.isInBox <= 0)
            {
                return;
            }
            var _loc_2:* = new Object();
            _loc_2.loginID = userName;
            _loc_2.factionID = param1.guildId.toString();
            _loc_2.userID = param1.userId.toString();
            _loc_2.isKick = param1.isKick;
            _loc_2.managerID = param1.managerID.toString();
            _loc_2.managerLoginID = param1.managerLoginID;
            _loc_2.leaveID = param1.leaveID.toString();
            _loc_2.leaveLoginID = param1.leaveLoginID;
            var _loc_3:* = JSON.stringify(_loc_2);
            callJs("kugouLeaveFactionNotify", _loc_3);
            return;
        }// end function

        override public function guildInfoChange(param1:ResGuildBulletinToKugooClientMessage) : void
        {
            if (this.isInBox <= 0)
            {
                return;
            }
            var _loc_2:* = new Object();
            _loc_2.loginID = userName;
            _loc_2.factionID = param1.guildId.toString();
            _loc_2.userID = param1.userId.toString();
            _loc_2.notice = param1.guildBulletin;
            var _loc_3:* = JSON.stringify(_loc_2);
            callJs("kugouOnFactionInfoChange", _loc_3);
            return;
        }// end function

        override public function guildDeleteNotify(param1:ResGuildDeleteToKugooClientMessage) : void
        {
            if (this.isInBox <= 0)
            {
                return;
            }
            var _loc_2:* = new Object();
            _loc_2.loginID = userName;
            _loc_2.factionID = param1.guildId.toString();
            _loc_2.userID = playerInfo.personId.toString();
            var _loc_3:* = JSON.stringify(_loc_2);
            callJs("kugouDeleteFactionNotify", _loc_3);
            return;
        }// end function

    }
}
