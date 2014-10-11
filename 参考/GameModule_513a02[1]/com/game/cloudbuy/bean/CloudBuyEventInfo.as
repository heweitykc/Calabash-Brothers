package com.game.cloudbuy.bean
{
    import com.game.utils.*;
    import net.*;

    public class CloudBuyEventInfo extends Bean
    {
        private var _eventId:long;
        private var _messageTime:int;
        private var _message:String;

        public function CloudBuyEventInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._eventId);
            writeInt(this._messageTime);
            writeString(this._message);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._eventId = readLong();
            this._messageTime = readInt();
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

        public function get messageTime() : int
        {
            return this._messageTime;
        }// end function

        public function set messageTime(param1:int) : void
        {
            this._messageTime = param1;
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
