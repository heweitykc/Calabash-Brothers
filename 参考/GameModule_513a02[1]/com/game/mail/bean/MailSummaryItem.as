package com.game.mail.bean
{
    import net.*;

    public class MailSummaryItem extends Bean
    {
        private var _itemid:int;
        private var _itemnum:int;

        public function MailSummaryItem()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemid);
            writeInt(this._itemnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemid = readInt();
            this._itemnum = readInt();
            return true;
        }// end function

        public function get itemid() : int
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:int) : void
        {
            this._itemid = param1;
            return;
        }// end function

        public function get itemnum() : int
        {
            return this._itemnum;
        }// end function

        public function set itemnum(param1:int) : void
        {
            this._itemnum = param1;
            return;
        }// end function

    }
}
