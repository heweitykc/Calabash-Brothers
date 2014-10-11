package com.game.map.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class DropGoodsInfo extends Bean
    {
        private var _dropGoodsId:long;
        private var _itemModelId:int;
        private var _num:int;
        private var _ownerId:Vector.<long>;
        private var _dropTime:long;
        private var _intensify:int;
        private var _attributs:int;
        private var _isFullAppend:int;
        private var _isFullStrength:int;
        private var _x:int;
        private var _y:int;
        private var _addition:int;
        private var _isNanOwner:int;

        public function DropGoodsInfo()
        {
            this._ownerId = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._dropGoodsId);
            writeInt(this._itemModelId);
            writeInt(this._num);
            writeShort(this._ownerId.length);
            _loc_1 = 0;
            while (_loc_1 < this._ownerId.length)
            {
                
                writeLong(this._ownerId[_loc_1]);
                _loc_1++;
            }
            writeLong(this._dropTime);
            writeByte(this._intensify);
            writeByte(this._attributs);
            writeByte(this._isFullAppend);
            writeByte(this._isFullStrength);
            writeShort(this._x);
            writeShort(this._y);
            writeByte(this._addition);
            writeByte(this._isNanOwner);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._dropGoodsId = readLong();
            this._itemModelId = readInt();
            this._num = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._ownerId[_loc_1] = readLong();
                _loc_1++;
            }
            this._dropTime = readLong();
            this._intensify = readByte();
            this._attributs = readByte();
            this._isFullAppend = readByte();
            this._isFullStrength = readByte();
            this._x = readShort();
            this._y = readShort();
            this._addition = readByte();
            this._isNanOwner = readByte();
            return true;
        }// end function

        public function get dropGoodsId() : long
        {
            return this._dropGoodsId;
        }// end function

        public function set dropGoodsId(param1:long) : void
        {
            this._dropGoodsId = param1;
            return;
        }// end function

        public function get itemModelId() : int
        {
            return this._itemModelId;
        }// end function

        public function set itemModelId(param1:int) : void
        {
            this._itemModelId = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get ownerId() : Vector.<long>
        {
            return this._ownerId;
        }// end function

        public function set ownerId(param1:Vector.<long>) : void
        {
            this._ownerId = param1;
            return;
        }// end function

        public function get dropTime() : long
        {
            return this._dropTime;
        }// end function

        public function set dropTime(param1:long) : void
        {
            this._dropTime = param1;
            return;
        }// end function

        public function get intensify() : int
        {
            return this._intensify;
        }// end function

        public function set intensify(param1:int) : void
        {
            this._intensify = param1;
            return;
        }// end function

        public function get attributs() : int
        {
            return this._attributs;
        }// end function

        public function set attributs(param1:int) : void
        {
            this._attributs = param1;
            return;
        }// end function

        public function get isFullAppend() : int
        {
            return this._isFullAppend;
        }// end function

        public function set isFullAppend(param1:int) : void
        {
            this._isFullAppend = param1;
            return;
        }// end function

        public function get isFullStrength() : int
        {
            return this._isFullStrength;
        }// end function

        public function set isFullStrength(param1:int) : void
        {
            this._isFullStrength = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get addition() : int
        {
            return this._addition;
        }// end function

        public function set addition(param1:int) : void
        {
            this._addition = param1;
            return;
        }// end function

        public function get isNanOwner() : int
        {
            return this._isNanOwner;
        }// end function

        public function set isNanOwner(param1:int) : void
        {
            this._isNanOwner = param1;
            return;
        }// end function

    }
}
