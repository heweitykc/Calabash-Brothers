package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGuildLeaveToKugooClientMessage extends Message
    {
        private var _guildId:long;
        private var _userId:long;
        private var _isKick:int;
        private var _managerID:long;
        private var _managerLoginID:String;
        private var _leaveID:long;
        private var _leaveLoginID:String;

        public function ResGuildLeaveToKugooClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.guildId);
            writeLong(this.userId);
            writeInt(this.isKick);
            writeLong(this.managerID);
            writeString(this.managerLoginID);
            writeLong(this.leaveID);
            writeString(this.leaveLoginID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.guildId = readLong();
            this.userId = readLong();
            this.isKick = readInt();
            this.managerID = readLong();
            this.managerLoginID = readString();
            this.leaveID = readLong();
            this.leaveLoginID = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529123;
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

        public function get userId() : long
        {
            return this._userId;
        }// end function

        public function set userId(param1:long) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get isKick() : int
        {
            return this._isKick;
        }// end function

        public function set isKick(param1:int) : void
        {
            this._isKick = param1;
            return;
        }// end function

        public function get managerID() : long
        {
            return this._managerID;
        }// end function

        public function set managerID(param1:long) : void
        {
            this._managerID = param1;
            return;
        }// end function

        public function get managerLoginID() : String
        {
            return this._managerLoginID;
        }// end function

        public function set managerLoginID(param1:String) : void
        {
            this._managerLoginID = param1;
            return;
        }// end function

        public function get leaveID() : long
        {
            return this._leaveID;
        }// end function

        public function set leaveID(param1:long) : void
        {
            this._leaveID = param1;
            return;
        }// end function

        public function get leaveLoginID() : String
        {
            return this._leaveLoginID;
        }// end function

        public function set leaveLoginID(param1:String) : void
        {
            this._leaveLoginID = param1;
            return;
        }// end function

    }
}
