package com.game.guild.protocol
{
    import com.*;
    import com.game.guild.message.*;
    import com.game.utils.*;

    public class GuildProtocol extends BaseProtocol
    {

        public function GuildProtocol()
        {
            return;
        }// end function

        public function reqCreateGuild(param1:String, param2:String, param3:int) : void
        {
            var _loc_4:* = new ReqGuildCreateToServerMessage();
            _loc_4.guildName = param1;
            _loc_4.guildBanner = param2;
            _loc_4.guildBannerIcon = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqGuildList(param1:int, param2:int, param3:String) : void
        {
            var _loc_4:* = new ReqGuildGetGuildListToServerMessage();
            _loc_4.type = param1;
            _loc_4.page = param2;
            _loc_4.name = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqGuildApplyAdd(param1:long) : void
        {
            var _loc_2:* = new ReqGuildApplyAddToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildAddMember(param1:long, param2:long, param3:int) : void
        {
            var _loc_4:* = new ReqGuildAddMemberToServerMessage();
            _loc_4.guildId = param1;
            _loc_4.userId = param2;
            _loc_4.argee = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqGuildDeleteMember(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqGuildDeleteMemberToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.userId = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildDeleteGuild(param1:long) : void
        {
            var _loc_2:* = new ReqGuildDeleteGuildToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildQuit(param1:long) : void
        {
            var _loc_2:* = new ReqGuildQuitToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildGetMemberList(param1:long) : void
        {
            var _loc_2:* = new ReqGuildGetMemberListToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildInviteAdd(param1:long, param2:long) : void
        {
            var _loc_3:* = new ReqGuildInviteAddToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.userId = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildAutoGuildArgeeAdd(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqGuildAutoGuildArgeeAddToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.autoGuildAgreeAdd = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildAutoArgeeAddGuild(param1:int) : void
        {
            var _loc_2:* = new ReqGuildAutoArgeeAddGuildToServerMessage();
            _loc_2.autoArgeeAddGuild = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildChangePowerLevel(param1:long, param2:long, param3:int) : void
        {
            var _loc_4:* = new ReqGuildChangePowerLevelToServerMessage();
            _loc_4.guildId = param1;
            _loc_4.userId = param2;
            _loc_4.newPowerLevel = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqGuildChangeBulletin(param1:long, param2:String) : void
        {
            var _loc_3:* = new ReqGuildChangeBulletinToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.guildBulletin = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildSubmitItem(param1:long, param2:int, param3:int) : void
        {
            var _loc_4:* = new ReqGuildSubmitItemToServerMessage();
            _loc_4.guildId = param1;
            _loc_4.itemType = param2;
            _loc_4.itemNum = param3;
            send(_loc_4);
            return;
        }// end function

        public function reqGuildChangeBannerName(param1:long, param2:String) : void
        {
            var _loc_3:* = new ReqGuildChangeBannerNameToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.bannerName = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildBannerLevelUp(param1:long) : void
        {
            var _loc_2:* = new ReqGuildBannerLevelUpToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildChangeBannerIcon(param1:long, param2:int) : void
        {
            var _loc_3:* = new ReqGuildChangeBannerIconToServerMessage();
            _loc_3.guildId = param1;
            _loc_3.bannerIcon = param2;
            send(_loc_3);
            return;
        }// end function

        public function reqGuildGetEventList(param1:long) : void
        {
            var _loc_2:* = new ReqGuildGetEventListToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqGuildImpeach(param1:long) : void
        {
            var _loc_2:* = new ReqGuildImpeachToServerMessage();
            _loc_2.guildId = param1;
            send(_loc_2);
            return;
        }// end function

    }
}
