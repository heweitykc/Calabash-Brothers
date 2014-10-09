package com.game.backpack.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqUseItemMessage extends Message
    {
        private var _itemId:long;
        private var _num:int;

        public function ReqUseItemMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104203;
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
