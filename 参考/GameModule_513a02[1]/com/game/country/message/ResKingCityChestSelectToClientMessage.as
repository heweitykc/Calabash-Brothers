package com.game.country.message
{
    import com.game.backpack.bean.*;
    import net.*;

    public class ResKingCityChestSelectToClientMessage extends Message
    {
        private var _iteminfo:ItemInfo;
        private var _num:int;

        public function ResKingCityChestSelectToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._iteminfo);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146109;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
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
