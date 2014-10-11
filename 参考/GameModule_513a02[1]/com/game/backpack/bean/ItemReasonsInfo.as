package com.game.backpack.bean
{
    import com.game.utils.*;
    import net.*;

    public class ItemReasonsInfo extends Bean
    {
        private var _itemId:long;
        private var _itemModelId:int;
        private var _itemNum:int;
        private var _itemReasons:int;

        public function ItemReasonsInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._itemModelId);
            writeInt(this._itemNum);
            writeInt(this._itemReasons);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._itemModelId = readInt();
            this._itemNum = readInt();
            this._itemReasons = readInt();
            return true;
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

        public function get itemModelId() : int
        {
            return this._itemModelId;
        }// end function

        public function set itemModelId(param1:int) : void
        {
            this._itemModelId = param1;
            return;
        }// end function

        public function get itemNum() : int
        {
            return this._itemNum;
        }// end function

        public function set itemNum(param1:int) : void
        {
            this._itemNum = param1;
            return;
        }// end function

        public function get itemReasons() : int
        {
            return this._itemReasons;
        }// end function

        public function set itemReasons(param1:int) : void
        {
            this._itemReasons = param1;
            return;
        }// end function

    }
}
