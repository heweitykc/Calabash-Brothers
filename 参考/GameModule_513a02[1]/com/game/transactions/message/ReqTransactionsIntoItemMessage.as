package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqTransactionsIntoItemMessage extends Message
    {
        private var _itemposition:int;
        private var _itemid:long;

        public function ReqTransactionsIntoItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._itemposition);
            writeLong(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemposition = readShort();
            this._itemid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122205;
        }// end function

        public function get itemposition() : int
        {
            return this._itemposition;
        }// end function

        public function set itemposition(param1:int) : void
        {
            this._itemposition = param1;
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
