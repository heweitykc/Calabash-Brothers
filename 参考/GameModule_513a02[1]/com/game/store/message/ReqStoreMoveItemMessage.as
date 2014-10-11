package com.game.store.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqStoreMoveItemMessage extends Message
    {
        private var _itemId:long;
        private var _toGridId:int;
        private var _num:int;
        private var _npcid:int;

        public function ReqStoreMoveItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._toGridId);
            writeInt(this._num);
            writeInt(this._npcid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._toGridId = readInt();
            this._num = readInt();
            this._npcid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112201;
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

        public function get npcid() : int
        {
            return this._npcid;
        }// end function

        public function set npcid(param1:int) : void
        {
            this._npcid = param1;
            return;
        }// end function

    }
}
