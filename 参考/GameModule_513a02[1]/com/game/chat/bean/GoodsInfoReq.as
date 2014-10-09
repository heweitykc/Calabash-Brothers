package com.game.chat.bean
{
    import com.game.utils.*;
    import net.*;

    public class GoodsInfoReq extends Bean
    {
        private var _goodId:long;
        private var _index:int;

        public function GoodsInfoReq()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._goodId);
            writeInt(this._index);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goodId = readLong();
            this._index = readInt();
            return true;
        }// end function

        public function get goodId() : long
        {
            return this._goodId;
        }// end function

        public function set goodId(param1:long) : void
        {
            this._goodId = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

    }
}
