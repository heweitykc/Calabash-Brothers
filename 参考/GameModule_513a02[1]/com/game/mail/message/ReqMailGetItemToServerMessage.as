package com.game.mail.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqMailGetItemToServerMessage extends Message
    {
        private var _mailid:long;
        private var _itemid:long;

        public function ReqMailGetItemToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._mailid);
            writeLong(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._mailid = readLong();
            this._itemid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 124153;
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

        public function get itemid() : long
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:long) : void
        {
            this._itemid = param1;
            return;
        }// end function

    }
}
