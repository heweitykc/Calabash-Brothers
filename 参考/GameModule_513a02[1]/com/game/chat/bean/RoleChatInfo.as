package com.game.chat.bean
{
    import com.game.utils.*;
    import net.*;

    public class RoleChatInfo extends Bean
    {
        private var _id:long;
        private var _name:String;
        private var _job:int;
        private var _level:int;
        private var _sex:int;

        public function RoleChatInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._id);
            writeString(this._name);
            writeInt(this._level);
            writeByte(this._sex);
            writeByte(this._job);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._id = readLong();
            this._name = readString();
            this._level = readInt();
            this._sex = readByte();
            this._job = readByte();
            return true;
        }// end function

        public function get id() : long
        {
            return this._id;
        }// end function

        public function set id(param1:long) : void
        {
            this._id = param1;
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

    }
}
