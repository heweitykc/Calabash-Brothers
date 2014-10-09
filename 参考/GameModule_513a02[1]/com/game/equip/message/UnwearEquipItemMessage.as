package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class UnwearEquipItemMessage extends Message
    {
        private var _itemId:long;
        private var _gridId:int;
        private var _pos:int;

        public function UnwearEquipItemMessage()
        {
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._gridId);
            writeByte(this._pos);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._gridId = readInt();
            this._pos = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 106102;
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

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function set gridId(param1:int) : void
        {
            this._gridId = param1;
            return;
        }// end function

    }
}
