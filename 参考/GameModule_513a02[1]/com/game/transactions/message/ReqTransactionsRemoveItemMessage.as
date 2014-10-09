package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqTransactionsRemoveItemMessage extends Message
    {
        private var _itemid:long;

        public function ReqTransactionsRemoveItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122206;
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
