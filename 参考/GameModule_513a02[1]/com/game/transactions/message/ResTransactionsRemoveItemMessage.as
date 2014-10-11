package com.game.transactions.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsRemoveItemMessage extends Message
    {
        private var _playerid:long;
        private var _itemid:long;

        public function ResTransactionsRemoveItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeLong(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._itemid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 122105;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
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
