package com.game.shop.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResNotSaleMessage extends Message
    {
        private var _sellId:int;
        private var _itemIds:Vector.<int>;

        public function ResNotSaleMessage()
        {
            this._itemIds = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._sellId);
            writeShort(this._itemIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemIds.length)
            {
                
                writeInt(this._itemIds[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._sellId = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._itemIds[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 105101;
        }// end function

        public function get sellId() : int
        {
            return this._sellId;
        }// end function

        public function set sellId(param1:int) : void
        {
            this._sellId = param1;
            return;
        }// end function

        public function get itemIds() : Vector.<int>
        {
            return this._itemIds;
        }// end function

        public function set itemIds(param1:Vector.<int>) : void
        {
            this._itemIds = param1;
            return;
        }// end function

    }
}
