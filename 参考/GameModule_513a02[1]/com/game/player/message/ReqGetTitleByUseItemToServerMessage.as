package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGetTitleByUseItemToServerMessage extends Message
    {
        private var _itemId:long;

        public function ReqGetTitleByUseItemToServerMessage()
        {
            return;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = new long(param1.low, param1.high);
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
            return 529207;
        }// end function

    }
}
