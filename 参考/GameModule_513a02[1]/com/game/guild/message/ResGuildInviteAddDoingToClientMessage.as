package com.game.guild.message
{
    import com.game.friend.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResGuildInviteAddDoingToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _guildId:long;
        private var _guildName:String;
        private var _inviteName:String;
        private var _inviteLevel:int;
        private var _inviteModeInfo:FriendModeInfo;

        public function ResGuildInviteAddDoingToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeLong(this._guildId);
            writeString(this._guildName);
            writeString(this._inviteName);
            writeShort(this._inviteLevel);
            writeBean(this._inviteModeInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._guildId = readLong();
            this._guildName = readString();
            this._inviteName = readString();
            this._inviteLevel = readShort();
            this._inviteModeInfo = readBean(FriendModeInfo) as FriendModeInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 121105;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
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

        public function get inviteName() : String
        {
            return this._inviteName;
        }// end function

        public function set inviteName(param1:String) : void
        {
            this._inviteName = param1;
            return;
        }// end function

        public function get inviteLevel() : int
        {
            return this._inviteLevel;
        }// end function

        public function set inviteLevel(param1:int) : void
        {
            this._inviteLevel = param1;
            return;
        }// end function

        public function get inviteModeInfo() : FriendModeInfo
        {
            return this._inviteModeInfo;
        }// end function

        public function set inviteModeInfo(param1:FriendModeInfo) : void
        {
            this._inviteModeInfo = param1;
            return;
        }// end function

    }
}
