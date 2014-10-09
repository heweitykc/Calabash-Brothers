package com.game.equip.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class EquipInfo extends Bean
    {
        private var _itemId:long;
        private var _itemModelId:int;
        private var _itemLevel:int;
        private var _addAttributLevel:int;
        private var _itemAttributes:Vector.<EquipAttribute>;
        private var _itemBind:int;
        private var _lostTime:int;
        private var _fightNumber:int;
        private var _attributeCount:int;
        public var suitId:int;

        public function EquipInfo()
        {
            this._itemAttributes = new Vector.<EquipAttribute>;
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
            writeByte(this._itemLevel);
            writeByte(this._addAttributLevel);
            writeShort(this._itemAttributes.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._itemAttributes.length)
            {
                
                writeBean(this._itemAttributes[_loc_1]);
                _loc_1++;
            }
            writeByte(this._itemBind);
            writeInt(this._lostTime);
            writeInt(this._fightNumber);
            writeInt(this._attributeCount);
            writeInt(this.suitId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._itemModelId = readInt();
            this._itemLevel = readByte();
            this._addAttributLevel = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemAttributes[_loc_2] = readBean(EquipAttribute) as EquipAttribute;
                _loc_2++;
            }
            this._itemBind = readByte();
            this._lostTime = readInt();
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

        public function get itemLevel() : int
        {
            return this._itemLevel;
        }// end function

        public function set itemLevel(param1:int) : void
        {
            this._itemLevel = param1;
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

        public function get itemAttributes() : Vector.<EquipAttribute>
        {
            return this._itemAttributes;
        }// end function

        public function set itemAttributes(param1:Vector.<EquipAttribute>) : void
        {
            this._itemAttributes = param1;
            return;
        }// end function

        public function get itemBind() : int
        {
            return this._itemBind;
        }// end function

        public function set itemBind(param1:int) : void
        {
            this._itemBind = param1;
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
