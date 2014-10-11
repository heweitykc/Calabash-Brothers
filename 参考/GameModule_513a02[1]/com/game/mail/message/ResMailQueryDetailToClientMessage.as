package com.game.mail.message
{
    import com.game.mail.bean.*;
    import net.*;

    public class ResMailQueryDetailToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _mailDetail:MailDetailInfo;

        public function ResMailQueryDetailToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeBean(this._mailDetail);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._mailDetail = readBean(MailDetailInfo) as MailDetailInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 124102;
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

        public function get mailDetail() : MailDetailInfo
        {
            return this._mailDetail;
        }// end function

        public function set mailDetail(param1:MailDetailInfo) : void
        {
            this._mailDetail = param1;
            return;
        }// end function

    }
}
