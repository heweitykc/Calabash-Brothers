package com.game.shop.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResRebuyItemInfosMessage extends Message
    {
        private var _items:Vector.<ItemInfo>;

        public function ResRebuyItemInfosMessage()
        {
            this._items = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._items.length);
            _loc_1 = 0;
            while (_loc_1 < this._items.length)
            {
                
                writeBean(this._items[_loc_1]);
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
                
                this._items[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 105104;
        }// end function

        public function get items() : Vector.<ItemInfo>
        {
            return this._items;
        }// end function

        public function set items(param1:Vector.<ItemInfo>) : void
        {
            this._items = param1;
            return;
        }// end function

    }
}
