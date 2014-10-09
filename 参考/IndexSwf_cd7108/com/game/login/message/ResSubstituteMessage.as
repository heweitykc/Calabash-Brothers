package com.game.login.message
{
    import net.*;

    public class ResSubstituteMessage extends Message
    {
        private var _ip:String;

        public function ResSubstituteMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._ip);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._ip = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100103;
        }// end function

        public function get ip() : String
        {
            return this._ip;
        }// end function

        public function set ip(param1:String) : void
        {
            this._ip = param1;
            return;
        }// end function

    }
}
