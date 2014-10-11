package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class EventInfo extends Bean
    {
        private var _eventId:long;
        private var _guildId:long;
        private var _guildName:String;
        private var _messageTime:int;
        private var _messageType:String;
        private var _message:String;

        public function EventInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._eventId);
            writeLong(this._guildId);
            writeString(this._guildName);
            writeInt(this._messageTime);
            writeString(this._messageType);
            writeString(this._message);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._eventId = readLong();
            this._guildId = readLong();
            this._guildName = readString();
            this._messageTime = readInt();
            this._messageType = readString();
            this._message = readString();
            return true;
        }// end function

        public function get eventId() : long
        {
            return this._eventId;
        }// end function

        public function set eventId(param1:long) : void
        {
            this._eventId = param1;
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

        public function get messageTime() : int
        {
            return this._messageTime;
        }// end function

        public function set messageTime(param1:int) : void
        {
            this._messageTime = param1;
            return;
        }// end function

        public function get messageType() : String
        {
            return this._messageType;
        }// end function

        public function set messageType(param1:String) : void
        {
            this._messageType = param1;
            return;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function set message(param1:String) : void
        {
            this._message = param1;
            return;
        }// end function

    }
}
