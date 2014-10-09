package com.game.gift.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class GiftInfo extends Bean
    {
        private var _giftid:int;
        private var _gifttype:int;
        private var _value:int;
        private var _canreceive:int;
        private var _iteminfos:Vector.<ItemInfo>;

        public function GiftInfo()
        {
            this._iteminfos = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._giftid);
            writeByte(this._gifttype);
            writeInt(this._value);
            writeByte(this._canreceive);
            writeShort(this._iteminfos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._iteminfos.length)
            {
                
                writeBean(this._iteminfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._giftid = readInt();
            this._gifttype = readByte();
            this._value = readInt();
            this._canreceive = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._iteminfos[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get giftid() : int
        {
            return this._giftid;
        }// end function

        public function set giftid(param1:int) : void
        {
            this._giftid = param1;
            return;
        }// end function

        public function get gifttype() : int
        {
            return this._gifttype;
        }// end function

        public function set gifttype(param1:int) : void
        {
            this._gifttype = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get canreceive() : int
        {
            return this._canreceive;
        }// end function

        public function set canreceive(param1:int) : void
        {
            this._canreceive = param1;
            return;
        }// end function

        public function get iteminfos() : Vector.<ItemInfo>
        {
            return this._iteminfos;
        }// end function

        public function set iteminfos(param1:Vector.<ItemInfo>) : void
        {
            this._iteminfos = param1;
            return;
        }// end function

    }
}
