package com.game.login.bean
{
    import com.game.utils.*;
    import net.*;

    public class CharacterInfo extends Bean
    {
        private var _playerId:long;
        private var _name:String;
        private var _level:int;
        private var _sex:int;
        private var _longintime:int;

        public function CharacterInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeString(this._name);
            writeInt(this._level);
            writeByte(this._sex);
            writeInt(this._longintime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._name = readString();
            this._level = readInt();
            this._sex = readByte();
            this._longintime = readInt();
            return true;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
            return;
        }// end function

        public function get longintime() : int
        {
            return this._longintime;
        }// end function

        public function set longintime(param1:int) : void
        {
            this._longintime = param1;
            return;
        }// end function

    }
}
