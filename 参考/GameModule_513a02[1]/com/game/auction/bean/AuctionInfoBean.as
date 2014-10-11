package com.game.auction.bean
{
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import net.*;

    public class AuctionInfoBean extends Bean
    {
        private var _itemId:long;
        private var _roleId:long;
        private var _playerName:String;
        private var _itemName:String;
        private var _unitprice:int;
        private var _price:int;
        private var _itemdata:ItemInfo;
        private var _deleteTime:long;

        public function AuctionInfoBean()
        {
            return;
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function set roleId(param1:long) : void
        {
            this._roleId = param1;
            return;
        }// end function

        public function get roleId() : long
        {
            return this._roleId;
        }// end function

        public function set playerName(param1:String) : void
        {
            this._playerName = param1;
            return;
        }// end function

        public function get playerName() : String
        {
            return this._playerName;
        }// end function

        public function set itemName(param1:String) : void
        {
            this._itemName = param1;
            return;
        }// end function

        public function get itemName() : String
        {
            return this._itemName;
        }// end function

        public function set unitprice(param1:int) : void
        {
            this._unitprice = param1;
            return;
        }// end function

        public function get unitprice() : int
        {
            return this._unitprice;
        }// end function

        public function set price(param1:int) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get price() : int
        {
            return this._price;
        }// end function

        public function set itemdata(param1:ItemInfo) : void
        {
            this._itemdata = param1;
            return;
        }// end function

        public function get itemdata() : ItemInfo
        {
            return this._itemdata;
        }// end function

        public function set deleteTime(param1:long) : void
        {
            this._deleteTime = param1;
            return;
        }// end function

        public function get deleteTime() : long
        {
            return this._deleteTime;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeLong(this._roleId);
            writeString(this._playerName);
            writeString(this._itemName);
            writeInt(this._unitprice);
            writeInt(this._price);
            writeBean(this._itemdata);
            writeLong(this._deleteTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._roleId = readLong();
            this._playerName = readString();
            this._itemName = readString();
            this._unitprice = readInt();
            this._price = readInt();
            this._itemdata = readBean(ItemInfo) as ItemInfo;
            this._deleteTime = readLong();
            return true;
        }// end function

    }
}
