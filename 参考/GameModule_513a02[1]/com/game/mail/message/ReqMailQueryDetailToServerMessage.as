package com.game.mail.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqMailQueryDetailToServerMessage extends Message
    {
        private var _mailid:long;

        public function ReqMailQueryDetailToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._mailid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mailid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 124152;
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
