package com.game.store.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStoreItemRemoveMessage extends Message
    {
        private var _itemId:long;

        public function ResStoreItemRemoveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 112103;
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
