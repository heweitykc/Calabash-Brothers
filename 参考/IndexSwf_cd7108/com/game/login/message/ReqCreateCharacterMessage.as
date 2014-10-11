package com.game.login.message
{
    import net.*;

    public class ReqCreateCharacterMessage extends Message
    {
        private var _name:String;
        private var _sex:int;
        private var _job:int;
        private var _auto:int;
        private var _icon:String;

        public function ReqCreateCharacterMessage()
        {
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeByte(this._sex);
            writeByte(this._job);
            writeByte(this._auto);
            writeString(this._icon);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._sex = readByte();
            this._job = readByte();
            this._auto = readByte();
            this._icon = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100203;
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

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
            return;
        }// end function

        public function get auto() : int
        {
            return this._auto;
        }// end function

        public function set auto(param1:int) : void
        {
            this._auto = param1;
            return;
        }// end function

        public function get icon() : String
        {
            return this._icon;
        }// end function

        public function set icon(param1:String) : void
        {
            this._icon = param1;
            return;
        }// end function

    }
}
