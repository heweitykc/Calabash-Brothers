package com.game.guild.message
{
    import com.game.friend.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResGuildApplyAddDoingToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _userId:long;
        private var _applyName:String;
        private var _applyLevel:int;
        private var _applyJob:int;
        private var _applyModeInfo:FriendModeInfo;

        public function ResGuildApplyAddDoingToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeLong(this._userId);
            writeString(this._applyName);
            writeShort(this._applyLevel);
            writeShort(this._applyJob);
            writeBean(this._applyModeInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._userId = readLong();
            this._applyName = readString();
            this._applyLevel = readShort();
            this._applyJob = readShort();
            this._applyModeInfo = readBean(FriendModeInfo) as FriendModeInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 121104;
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

        public function get userId() : long
        {
            return this._userId;
        }// end function

        public function set userId(param1:long) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get applyName() : String
        {
            return this._applyName;
        }// end function

        public function set applyName(param1:String) : void
        {
            this._applyName = param1;
            return;
        }// end function

        public function get applyLevel() : int
        {
            return this._applyLevel;
        }// end function

        public function set applyLevel(param1:int) : void
        {
            this._applyLevel = param1;
            return;
        }// end function

        public function get applyModeInfo() : FriendModeInfo
        {
            return this._applyModeInfo;
        }// end function

        public function set applyModeInfo(param1:FriendModeInfo) : void
        {
            this._applyModeInfo = param1;
            return;
        }// end function

        public function get applyJob() : int
        {
            return this._applyJob;
        }// end function

        public function set applyJob(param1:int) : void
        {
            this._applyJob = param1;
            return;
        }// end function

    }
}
