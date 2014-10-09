package com.game.backpack.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResItemInfosMessage extends Message
    {
        private var _cellnum:int;
        private var _items:Vector.<ItemInfo>;

        public function ResItemInfosMessage()
        {
            this._items = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._cellnum);
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
            this._cellnum = readInt();
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
            return 104101;
        }// end function

        public function get cellnum() : int
        {
            return this._cellnum;
        }// end function

        public function set cellnum(param1:int) : void
        {
            this._cellnum = param1;
            return;
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
