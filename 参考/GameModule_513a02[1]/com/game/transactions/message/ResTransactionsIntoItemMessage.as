package com.game.transactions.message
{
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResTransactionsIntoItemMessage extends Message
    {
        private var _playerid:long;
        private var _itemposition:int;
        private var _iteminfo:ItemInfo;

        public function ResTransactionsIntoItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeShort(this._itemposition);
            writeBean(this._iteminfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._itemposition = readShort();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 122104;
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

        public function get itemposition() : int
        {
            return this._itemposition;
        }// end function

        public function set itemposition(param1:int) : void
        {
            this._itemposition = param1;
            return;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

    }
}
