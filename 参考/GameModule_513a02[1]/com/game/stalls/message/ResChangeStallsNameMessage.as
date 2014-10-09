package com.game.stalls.message
{
    import net.*;

    public class ResChangeStallsNameMessage extends Message
    {
        private var _name:String;
        private var _status:int;

        public function ResChangeStallsNameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeByte(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._status = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123110;
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

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

    }
}
