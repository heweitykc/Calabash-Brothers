package com.game.backpack.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqMoveItemMessage extends Message
    {
        private var _itemId:long;
        private var _toGridId:int;
        private var _num:int;

        public function ReqMoveItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._toGridId);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._toGridId = readInt();
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104202;
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

        public function get toGridId() : int
        {
            return this._toGridId;
        }// end function

        public function set toGridId(param1:int) : void
        {
            this._toGridId = param1;
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

    }
}
