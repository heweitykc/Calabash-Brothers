package com.game.shop.message
{
    import __AS3__.vec.*;
    import com.game.shop.bean.*;
    import net.*;

    public class ResShopItemListMessage extends Message
    {
        private var _shopModelId:int;
        private var _page:int;
        private var _shopItemList:Vector.<CSShopItemInfo>;

        public function ResShopItemListMessage()
        {
            this._shopItemList = new Vector.<CSShopItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._shopModelId);
            writeByte(this._page);
            writeShort(this._shopItemList.length);
            _loc_1 = 0;
            while (_loc_1 < this._shopItemList.length)
            {
                
                writeBean(this._shopItemList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._shopModelId = readInt();
            this._page = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._shopItemList[_loc_1] = readBean(CSShopItemInfo) as CSShopItemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 105105;
        }// end function

        public function get shopModelId() : int
        {
            return this._shopModelId;
        }// end function

        public function set shopModelId(param1:int) : void
        {
            this._shopModelId = param1;
            return;
        }// end function

        public function get page() : int
        {
            return this._page;
        }// end function

        public function set page(param1:int) : void
        {
            this._page = param1;
            return;
        }// end function

        public function get shopItemList() : Vector.<CSShopItemInfo>
        {
            return this._shopItemList;
        }// end function

        public function set shopItemList(param1:Vector.<CSShopItemInfo>) : void
        {
            this._shopItemList = param1;
            return;
        }// end function

    }
}
