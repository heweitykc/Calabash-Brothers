package com.game.backpack.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ItemInfo extends Bean
    {
        private var _itemId:long;
        private var _itemModelId:int;
        private var _num:long;
        private var _gridId:int;
        private var _isbind:int;
        private var _intensify:int;
        private var _addAttributLevel:int;
        private var _attributs:int;
        private var _isFullAppend:int;
        private var _lostTime:int;
        private var _goodAttributes:Vector.<GoodsAttribute>;
        private var _params:String;
        private var _fightNumber:int;
        private var _attributeCount:int;
        public var suitId:int;

        public function ItemInfo()
        {
            this._goodAttributes = new Vector.<GoodsAttribute>;
            return;
        }// end function

        public function get fightNumber() : int
        {
            return this._fightNumber;
        }// end function

        public function set fightNumber(param1:int) : void
        {
            this._fightNumber = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._itemModelId);
            writeLong(this._num);
            writeInt(this._gridId);
            writeByte(this._isbind);
            writeByte(this._intensify);
            writeByte(this._addAttributLevel);
            writeShort(this._goodAttributes.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._goodAttributes.length)
            {
                
                writeBean(this._goodAttributes[_loc_1]);
                _loc_1++;
            }
            writeByte(this._attributs);
            writeInt(this._lostTime);
            writeString(this._params);
            writeInt(this._fightNumber);
            writeInt(this._attributeCount);
            writeInt(this.suitId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._itemModelId = readInt();
            this._num = readLong();
            this._gridId = readInt();
            this._isbind = readByte();
            this._intensify = readByte();
            this._addAttributLevel = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._goodAttributes[_loc_2] = readBean(GoodsAttribute) as GoodsAttribute;
                _loc_2++;
            }
            this._attributs = readByte();
            this._lostTime = readInt();
            this._params = readString();
            this._fightNumber = readInt();
            this._attributeCount = readInt();
            this.suitId = readInt();
            return true;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = param1;
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

        public function get num() : long
        {
            return this._num;
        }// end function

        public function set num(param1:long) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function set gridId(param1:int) : void
        {
            this._gridId = param1;
            return;
        }// end function

        public function get isbind() : int
        {
            return this._isbind;
        }// end function

        public function set isbind(param1:int) : void
        {
            this._isbind = param1;
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

        public function get addAttributLevel() : int
        {
            return this._addAttributLevel;
        }// end function

        public function set addAttributLevel(param1:int) : void
        {
            this._addAttributLevel = param1;
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

        public function get lostTime() : int
        {
            return this._lostTime;
        }// end function

        public function set lostTime(param1:int) : void
        {
            this._lostTime = param1;
            return;
        }// end function

        public function get goodAttributes() : Vector.<GoodsAttribute>
        {
            return this._goodAttributes;
        }// end function

        public function set goodAttributes(param1:Vector.<GoodsAttribute>) : void
        {
            this._goodAttributes = param1;
            return;
        }// end function

        public function get params() : String
        {
            return this._params;
        }// end function

        public function set params(param1:String) : void
        {
            this._params = param1;
            return;
        }// end function

        public function get attributeCount() : int
        {
            return this._attributeCount;
        }// end function

        public function set attributeCount(param1:int) : void
        {
            this._attributeCount = param1;
            return;
        }// end function

    }
}
