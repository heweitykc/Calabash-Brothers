package com.game.newactivity.bean
{
    import com.game.utils.*;
    import net.*;

    public class SimpleRankInfo extends Bean
    {
        private var _playerId:long;
        private var _playerName:String;
        private var _job:int;
        private var _rank:int;
        private var _data:String;

        public function SimpleRankInfo()
        {
            return;
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

        public function set playerName(param1:String) : void
        {
            this._playerName = param1;
            return;
        }// end function

        public function get playerName() : String
        {
            return this._playerName;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set rank(param1:int) : void
        {
            this._rank = param1;
            return;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function set data(param1:String) : void
        {
            this._data = param1;
            return;
        }// end function

        public function get data() : String
        {
            return this._data;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeString(this._playerName);
            writeByte(this._job);
            writeShort(this._rank);
            writeString(this._data);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._playerName = readString();
            this._job = readByte();
            this._rank = readShort();
            this._data = readString();
            return true;
        }// end function

    }
}
