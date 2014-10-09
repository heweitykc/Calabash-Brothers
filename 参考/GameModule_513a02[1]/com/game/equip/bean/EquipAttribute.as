package com.game.equip.bean
{
    import net.*;

    public class EquipAttribute extends Bean
    {
        private var _attributeType:int;
        private var _attributeValue:int;

        public function EquipAttribute()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._attributeType);
            writeInt(this._attributeValue);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._attributeType = readByte();
            this._attributeValue = readInt();
            return true;
        }// end function

        public function get attributeType() : int
        {
            return this._attributeType;
        }// end function

        public function set attributeType(param1:int) : void
        {
            this._attributeType = param1;
            return;
        }// end function

        public function get attributeValue() : int
        {
            return this._attributeValue;
        }// end function

        public function set attributeValue(param1:int) : void
        {
            this._attributeValue = param1;
            return;
        }// end function

    }
}
