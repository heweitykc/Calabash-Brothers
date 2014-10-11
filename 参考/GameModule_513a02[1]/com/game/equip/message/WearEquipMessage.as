package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class WearEquipMessage extends Message
    {
        private var _itemId:long;
        private var _pos:int;

        public function WearEquipMessage()
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
            writeByte(this._pos);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._pos = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 106201;
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

    }
}
