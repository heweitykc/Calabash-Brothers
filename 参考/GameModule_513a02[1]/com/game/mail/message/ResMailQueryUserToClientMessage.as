package com.game.mail.message
{
    import net.*;

    public class ResMailQueryUserToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _szName:String;

        public function ResMailQueryUserToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeString(this._szName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._szName = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 124106;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get szName() : String
        {
            return this._szName;
        }// end function

        public function set szName(param1:String) : void
        {
            this._szName = param1;
            return;
        }// end function

    }
}
