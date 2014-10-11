package com.game.monster.message
{
    import net.*;

    public class ResMonsterDoubleNoticeMessage extends Message
    {
        private var _type:int;
        private var _status:int;
        private var _content:String;
        private var _time:int;

        public function ResMonsterDoubleNoticeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeByte(this._status);
            writeString(this._content);
            writeInt(this._time);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._status = readByte();
            this._content = readString();
            this._time = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114111;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get content() : String
        {
            return this._content;
        }// end function

        public function set content(param1:String) : void
        {
            this._content = param1;
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

    }
}
