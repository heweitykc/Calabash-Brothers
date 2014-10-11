package com.game.shop.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ReqSellItemsMessage extends Message
    {
        private var _itemId:Vector.<long>;

        public function ReqSellItemsMessage()
        {
            this._itemId = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._itemId.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemId.length)
            {
                
                writeLong(this._itemId[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._itemId[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 105207;
        }// end function

        public function get itemId() : Vector.<long>
        {
            return this._itemId;
        }// end function

        public function set itemId(param1:Vector.<long>) : void
        {
            this._itemId = param1;
            return;
        }// end function

    }
}
