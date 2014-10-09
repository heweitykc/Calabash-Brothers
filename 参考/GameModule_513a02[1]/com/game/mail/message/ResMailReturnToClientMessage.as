package com.game.mail.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMailReturnToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _mailid:long;

        public function ResMailReturnToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeLong(this._mailid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._mailid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 124107;
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

        public function get mailid() : long
        {
            return this._mailid;
        }// end function

        public function set mailid(param1:long) : void
        {
            this._mailid = param1;
            return;
        }// end function

    }
}
