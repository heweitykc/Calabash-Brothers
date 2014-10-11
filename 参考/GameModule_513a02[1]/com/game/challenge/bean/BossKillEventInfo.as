package com.game.challenge.bean
{
    import com.game.utils.*;
    import net.*;

    public class BossKillEventInfo extends Bean
    {
        private var _eventId:long;
        private var _playerName:String;
        private var _playerId:long;
        private var _bossId:int;
        private var _type:int;
        private var _touchTime:long;

        public function BossKillEventInfo()
        {
            return;
        }// end function

        public function set eventId(param1:long) : void
        {
            this._eventId = param1;
            return;
        }// end function

        public function get eventId() : long
        {
            return this._eventId;
        }// end function

        public function set playerName(param1:String) : void
        {
            this._playerName = param1;
            return;
        }// end function

        public function get playerName() : String
        {
            return this._playerName;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set bossId(param1:int) : void
        {
            this._bossId = param1;
            return;
        }// end function

        public function get bossId() : int
        {
            return this._bossId;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set touchTime(param1:long) : void
        {
            this._touchTime = param1;
            return;
        }// end function

        public function get touchTime() : long
        {
            return this._touchTime;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._eventId);
            writeString(this._playerName);
            writeLong(this._playerId);
            writeInt(this._bossId);
            writeByte(this._type);
            writeLong(this._touchTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._eventId = readLong();
            this._playerName = readString();
            this._playerId = readLong();
            this._bossId = readInt();
            this._type = readByte();
            this._touchTime = readLong();
            return true;
        }// end function

    }
}
