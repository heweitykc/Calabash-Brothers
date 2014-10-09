package com.game.backpack.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqSplitGoodsMessage extends Message
    {
        private var _itemid:long;
        private var _count:int;

        public function ReqSplitGoodsMessage()
        {
            return;
        }// end function

        public function get itemid() : long
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:long) : void
        {
            this._itemid = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemid);
            writeShort(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemid = readLong();
            this.count = readShort();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104206;
        }// end function

    }
}
